<?php 
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

class MemberData extends Member
{
    private static $db = [
        'NTA_SIPA'=> 'Varchar(255)',
        'Sex' => 'Varchar(255)',
        'TglLahir' => 'Date',
        'Agama' => 'Varchar(255)',
        'PhoneNumber' => 'Varchar(255)',
        'Address' => 'Text',
        'Bio' => 'HTMLText',
    ];

    private static $has_one = [
        'KabupatenLahir' => KabupatenData::class,
        'Kecamatan' => KecamatanData::class,
        'GolonganData' => GolonganData::class,
        'SakaData' => SakaData::class
    ];

    private static $has_many = [
        'SosmedData' => SosmedData::class,
        'HobbyData' => HobbyData::class
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


    
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
         
    }

    public function getCMSFields()
    {
        $fields = new FieldList();
        $fields->add(new TabSet("Root"));
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
            'DirectGroups'
        ]);
        $fields->addFieldToTab(
            'Root.Main',
            TextField::create(
                'NTA_SIPA',
                'NTA SIPA (Nomoe Tanda Anggota)'
            ),
            'Password'
        );
        $fields->insertBefore('NTA_SIPA', EmailField::create(
            'Email',
            'Email'
        ));
        
        $fields->insertBefore('Email', UploadField::create(
            'PhotoProfile',
            'Photo Profile'
        ));
        
        $fields->insertAfter('Email', TextField::create(
            'FirstName',
            'Nama Depan'
        ));
        $fields->insertAfter('FirstName', TextField::create(
            'Surname',
            'Nama Belakang'
        ));

        

        $fields->insertAfter('Surname', OptionsetField::create(
            'Sex',
            'Gender',
            $this->arrKelamin
        )->setValue("L"));

        $fields->insertAfter('Sex', DropdownField::create(
            'Agama',
            'Agama',
            $this->arrAgama
        )->setEmptyString('Pilih Agama'));
        $fields->insertAfter('Agama', DateField::create(
            'TglLahir',
            'Tanggal Lahir'
        ));

        $fields->insertAfter('TglLahir', DropdownField::create(
            'KabupatenLahirID',
            'Kota Kelahiran',
            KabupatenData::get()->sort("Title", "ASC")->map("ID", "Title")
        )->setEmptyString('Pilih Kabupaten Kota'));

        $fields->insertAfter('KabupatenLahirID', NumericField::create(
            'PhoneNumber',
            'Nomor Telephone'
        ));
        
        $KabupatenDD = DropdownField::create(
            'KabupatenSelect',
            'Kabupaten Tempat Tinggal',
            ProvinsiData::getJatim()->KabupatenData()->sort("Title", "ASC")->map("ID", "Title")
        )->setEmptyString('Pilih kota anda');

        if ($this->KecamatanID != 0){
            $KabupatenDD->setValue($this->Kecamatan()->KabupatenDataID);
            $KecamatanDD = DropdownField::create(
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


        // Kwarcab
        // Kwarran
        $Kwarcab = CustomDropdown::create(
            'KwarcabID',
            'Kwarcab',
            KabupatenData::get()->filter(['ProvinsiDataID'=>ProvinsiData::getJatim()->ID])->sort("Title", "ASC")->map("ID", "Title")
        )->setEmptyString('Plih Kabupaten Kwarcab');
        if ($this->KwarranID != 0){
            $Kwarcab->setValue($this->Kwarran()->KabupatenDataID);
            $Kwarran = DropdownField::create(
                'KwarranID',
                'Kwarran',
                KecamatanData::get()->filter(['KabupatenDataID'=>$this->Kwarran()->KabupatenDataID])->sort("Title", "ASC")->map("ID", "Title")
            )->setEmptyString('Pilih Kecamatan Kwarran')->setHasEmptyDefault(true);
        }else{
            $Kwarran = CustomDropdown::create(
                'KwarranID',
                'Kwarran',
                array()
            )->setEmptyString('Pilih Kecamatan Kwarran')->setHasEmptyDefault(true);
        }


        $fields->addFieldsToTab(
            'Root.Data Kepramukaan',
            [
                $Kwarcab,
                $Kwarran,
                DropdownField::create(
                    'GolonganDataID',
                    'Golongan',
                    GolonganData::get()->sort("Title", "ASC")->map("ID", "Title")
                )->setEmptyString('Pilih Golongan'),
                DropdownField::create(
                    'SakaDataID',
                    'Saka',
                    SakaData::get()->sort("Title", "ASC")->map("ID", "Title")
                )->setEmptyString('Pilih Saka')
            ]
        );

        $gridFieldConfig = GridFieldConfig_RecordEditor::create();
        $itemSosmed = GridField::create(
            'SosmedData',
            'List Sosial Media',
            $this->SosmedData(),
            $gridFieldConfig            
        );
        
        $fields->addFieldToTab('Root.Sosial Media', $itemSosmed);
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