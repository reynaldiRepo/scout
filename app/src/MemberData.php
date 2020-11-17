<?php 
use SilverStripe\Control\Director;
use SilverStripe\SiteConfig\SiteConfig;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Forms\OptionsetField;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\HTMLEditor\HtmlEditorField;
use SilverStripe\Security\Member;
use SilverStripe\Forms\NumericField;
use SilverStripe\Forms\EmailField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\DateField;
use SilverStripe\Security\Permission;
use SilverStripe\ORM\DataExtension;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TabSet;
use SilverStripe\ORM\DataObject;
use SilverStripe\Forms\PasswordField;
use SilverStripe\Forms\GridField\GridFieldAddNewButton;


class MemberData extends Member
{
    private static $singular_name = "Member";
    private static $plural_name = "List Member";
    private static $default_sort = "Created Desc";

    /**
     * Defines a default list of filters for the search context
     * @var array
     */
    private static $searchable_fields = [
        'Kwarcab.Title' => [
            'title' => 'Kabupaten Kwarcab',
        ],
        'SakaDataID' => [
            'filter'=>'ExactMatchFilter',
            'title' => 'Saka',
        ]
    ];


    private static $db = [
        'NTA_SIPA'=> 'Varchar(255)',
        'Sex' => 'Varchar(255)',
        'TglLahir' => 'Date',
        'Agama' => 'Varchar(255)',
        'PhoneNumber' => 'Varchar(255)',
        'Address' => 'Text',
        'Bio' => 'HTMLText',
        'Status' => 'Boolean'
    ];

    private static $has_one = [
        'KabupatenLahir' => KabupatenData::class,
        'Kecamatan' => KecamatanData::class,
        'GolonganData' => GolonganData::class,
        'SakaData' => SakaData::class,
        'BannerImage' => CustomImage::class
    ];

    private static $has_many = [
        'SosmedData' => SosmedData::class,
        'HobbyData' => HobbyData::class,
        'CommentEventData' => CommentEventData::class
    ];

    private static $belongs_many_many = [
        'EventData' => EventData::class
    ];

    /**
     * Defines summary fields commonly used in table columns
     * as a quick overview of the data for this dataobject
     * @var array
     */
    private static $summary_fields = [
        'Kwarcab.Title' => 'Kwarcab',
        'SakaData.Title' => 'Saka',
        'GolonganData.Title' => 'Golongan'
    ];

    
    
    private $arrKelamin = [
        'L'=>'Laki - Laki',
        'P'=>'Perempuan'
    ];
    
    private $arrAgama = [
        'Islam' => 'Islam',
        'Kristen' => 'Kristen',
        'Protestan' => 'Protestan',
        'Katolik' => 'Katolik',
        'Hindu' => 'Hindu',
        'Buddha' => 'Buddha',
        'Khonghucu' => 'Khonghucu'
    ];
    
    public function getStatusStr(){
        $arr = ['0'=>'Not Acive', '1'=>'Active'];
        return($arr[$this->Status]);
    }

    public function getBannerImage(){
        
        if ($this->BannerImageID != 0 && $this->BannerImage()->exists()){
            return $this->BannerImage();
        }else{
            $sc = SiteConfig::current_site_config();
            return $sc->DefaultPhotoBannerMember();
        }
    }

    public function getURLSegment(){
        $nama = $this->FirstName." ".$this->Surname;
        $nama = explode(" ",$nama);
        $nama = implode("-",$nama);
        return $nama;
    }

    public function Link(){
        // {$BaseHref}member/v/$ID-$getURLSegment
        return Director::baseURL()."member/v/".$this->ID."-".$this->getURLSegment();
    }

    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
    }

    public function onAfterWrite()
    {
        parent::onAfterWrite(); 
    }


    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->add(new TabSet("Root"));
        $fields->removeFieldFromTab('Root', 'HobbyData');
        $fields->removeFieldFromTab('Root', 'SosmedData');
        $fields->removeFieldFromTab('Root', 'Permissions');
        $fields->removeFieldFromTab('Root', 'CommentEventData');
        $fields->removeFieldFromTab('Root', 'EventData');

        $fields->removeByName([
            'Sex',
            'Agama',
            'Locale',
            'FailedLoginCount',
            'NTA_SIPA',
            'Sex' ,
            'TglLahir',
            'Agama' ,
            'Address',
            'Bio',
            'PhoneNumber',
            'FirstName',
            'Surname',
            'Email',
            'KabupatenLahirID',
            'KecamatanID',
            'DirectGroups',
            'BannerImage',
            'PhotoProfile'
        ]);
        $fields->addFieldToTab(
            'Root.Main',
            TextField::create(
                'NTA_SIPA',
                'NTA SIPA (Nomoe Tanda Anggota)'
            )
        );
        $fields->insertBefore('Password', EmailField::create(
            'Email',
            'Email'
        ));

        $fields->insertBefore('Email', CustomDropdown::create(
            'Status',
            'Status',
            ['0'=>'Not Acive', '1'=>'Active']
        ));
        
        $fields->insertBefore('Email', UploadField::create(
            'PhotoProfile',
            'Photo Profile'
        ));

        $fields->insertBefore('Email', UploadField::create(
            'BannerImage',
            'Image Banner'
        ));
        
        $fields->insertAfter('Email', TextField::create(
            'FirstName',
            'Firstname'
        ));
        $fields->insertAfter('FirstName', TextField::create(
            'Surname',
            'Surname'
        ));

        $fields->insertAfter('Surname', OptionsetField::create(
            'Sex',
            'Gender',
            $this->arrKelamin
        )->setValue("L"));

        $fields->insertAfter('Sex', CustomDropdown::create(
            'Agama',
            'Agama',
            $this->arrAgama
        )->setEmptyString('Pilih Agama'));
        $fields->insertAfter('Agama', DateField::create(
            'TglLahir',
            'Tanggal Lahir'
        ));

        $fields->insertAfter('TglLahir', CustomDropdown::create(
            'KabupatenLahirID',
            'Kota Kelahiran',
            KabupatenData::get()->sort("Title", "ASC")->map("ID", "Title")
        )->setEmptyString('Pilih Kabupaten Kota'));

        $fields->insertAfter('KabupatenLahirID', TextField::create(
            'PhoneNumber',
            'Nomor Telephone'
        ));
        
        $KabupatenDD = CustomDropdown::create(
            'KabupatenSelect',
            'Kabupaten Tempat Tinggal',
            ProvinsiData::getJatim()->KabupatenData()->sort("Title", "ASC")->map("ID", "Title")
        )->setEmptyString('Pilih Kabupatem/Kota');

        if ($this->KecamatanID != 0){
            $KabupatenDD->setValue($this->Kecamatan()->KabupatenDataID);
            $KecamatanDD = CustomDropdown::create(
                'KecamatanID',
                'Kecamatan Tempat Tinggal',
                KecamatanData::get()->filter(['KabupatenDataID'=>$this->Kecamatan()->KabupatenDataID])->sort("Title", "ASC")->map("ID", "Title")
            )->setEmptyString('Pilih Kecamatan')->setHasEmptyDefault(true);
        }else{
            $KecamatanDD = CustomDropdown::create(
                'KecamatanID',
                'Kecamatan Tempat Tinggal',
                array()
            )->setEmptyString('Pilih Kecamatan')->setHasEmptyDefault(true);
        }
        

        $fields->addFieldsToTab(
            'Root.Main',
            [
                $KabupatenDD, $KecamatanDD, 
                TextareaField::create(
                    'Address',
                    'Alamat'
                )
            ]
        );

    
        $fields->addFieldsToTab(
            'Root.Main',
            [
                HtmlEditorField::create(
                    'Bio',
                    'Bio'
                )
            ]
        );


        $member = Member::currentUser();
        if ($member->inGroup(CT::getGroupID("admin-cabang"))){
            $arrKab = [$member->KwarcabID=>$member->Kwarcab()->Title];
            $arrKec = KecamatanData::get()->filter(['KabupatenDataID'=>$member->KwarcabID]);
            $Kwarcab = CustomDropdown::create(
                'KwarcabID',
                'Kwarcab',
                $arrKab
            );
        }else{
            $arrKab = KabupatenData::get()->filter(['ProvinsiDataID'=>ProvinsiData::getJatim()->ID])->sort("Title", "ASC")->map("ID", "Title");
            $arrKec = [];
            $Kwarcab = CustomDropdown::create(
                'KwarcabID',
                'Kwarcab',
                $arrKab
            )->setEmptyString('Plih Kabupaten Kwarcab');
        }

        
        if ($this->KwarranID != 0){
            $Kwarcab->setValue($this->Kwarran()->KabupatenDataID);
            $Kwarran = CustomDropdown::create(
                'KwarranID',
                'Kwarran',
                KecamatanData::get()->filter(['KabupatenDataID'=>$this->Kwarran()->KabupatenDataID])->sort("Title", "ASC")->map("ID", "Title")
            )->setEmptyString('Pilih Kecamatan Kwarran')->setHasEmptyDefault(true);
        }else{
            if ($this->KwarcabID != 0){
                $Kwarran = CustomDropdown::create(
                    'KwarranID',
                    'Kwarran',
                    KecamatanData::get()->filter(['KabupatenDataID'=>$this->KwarcabID])->sort("Title", "ASC")->map("ID", "Title")
                )->setEmptyString('Pilih Kecamatan Kwarran')->setHasEmptyDefault(true);
            }else{
                $Kwarran = CustomDropdown::create(
                    'KwarranID',
                    'Kwarran',
                    $arrKec
                )->setEmptyString('Pilih Kecamatan Kwarran')->setHasEmptyDefault(true);
            }
        }
        $Kwarcab->setIsRequired(true);
        // $Kwarran->setIsRequired(true);


        $fields->addFieldsToTab(
            'Root.Data Kepramukaan',
            [
                $Kwarcab,
                $Kwarran,
                $golongan = CustomDropdown::create(
                    'GolonganDataID',
                    'Golongan',
                    GolonganData::get()->sort("Title", "ASC")->map("ID", "Title")
                )->setEmptyString('Pilih Golongan'),
                $saka = CustomDropdown::create(
                    'SakaDataID',
                    'Saka',
                    SakaData::get()->sort("Title", "ASC")->map("ID", "Title")
                )->setEmptyString('Pilih Saka')
            ]
        );
        $saka->setIsRequired(true);
        $golongan->setIsRequired(true);

        $gridFieldConfig = GridFieldConfig_RecordEditor::create();
        $itemSosmed = GridField::create(
            'SosmedData',
            'List Sosial Media',
            $this->SosmedData(),
            $gridFieldConfig            
        );
        
        $fields->addFieldToTab('Root.Sosial Media', $itemSosmed);

        $gridFieldConfig = GridFieldConfig_RecordEditor::create();
        $itemHobby = GridField::create(
            'HobbyData',
            'List Hobi',
            $this->HobbyData(),
            $gridFieldConfig            
        );
        $fields->addFieldToTab('Root.Hobi', $itemHobby);
        return  $fields;
    }

}