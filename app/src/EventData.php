<?php
use SilverStripe\Control\Director;
use SilverStripe\SiteConfig\SiteConfig;
use SilverStripe\Security\Member;
use SilverStripe\Forms\GridField\GridFieldConfig_RelationEditor;
use SilverStripe\Forms\LabelField;
use SilverStripe\Forms\NumericField_Readonly;
use SilverStripe\Forms\ReadonlyField;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\TextareaField;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Forms\HTMLEditor\HtmlEditorField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TabSet;
use SilverStripe\ORM\DataObject;
use SilverStripe\Forms\DatetimeField;
use SilverStripe\Forms\GridField\GridFieldAddNewButton;
use SilverStripe\Forms\GridField\GridFieldExportButton;
use SilverStripe\Forms\GridField\GridFieldPrintButton;
use SilverStripe\Forms\RequiredFields;

class EventData extends DataObject {
    
    private static $singular_name = "Event";
    private static $plural_name = "List Event";
    private static $default_sort = "Created Desc";

    private static $db = [
        'Title' => 'Varchar',
        'Mulai' => 'Datetime',
        'Selesai' => 'Datetime',
        'Content' => 'HTMLText',
        'WebinarURL' => 'Text'
    ];

    private static $has_one = [
        'Image' => CustomImage::class,
        'SakaData' => SakaData::class,
        'KategoriEventData' => KategoriEventData::class,
    ];

    private static $many_many = [
        'MemberData' => MemberData::class
    ];

    private static $has_many = [
        'CommentEventData' => CommentEventData::class
    ];

    /**
     * Defines summary fields commonly used in table columns
     * as a quick overview of the data for this dataobject
     * @var array
     */
    private static $summary_fields = [
        'Title' => 'Nama Kegiatan',
        'Mulai' => 'Tanggal Pelaksanaan',
        'Selesai' => 'Event Berakhir',
        'SakaData.Title' => 'Saka',
        'KategoriEventData.Title' => 'Kategori',
        'getJumlahParticipant' => 'Participant'
    ];

    /**
     * DataObject create permissions
     * @param Member $member
     * @return boolean
     */
    public function canDelete($member = null)
    {
        $member = Member::currentUser();
        if ($member->inGroup(CT::getGroupID('admin-cabang'))) {
            return false;
        }else{
            return true;
        }
    }

    public function canCreate($member = null, $context = [])
    {
        $member = Member::currentUser();
        if ($member->inGroup(CT::getGroupID('admin-cabang'))) {
            return false;
        }else{
            return true;
        }
    }
    
    public function canEdit($member = null)
    {
        $member = Member::currentUser();
        if ($member->inGroup(CT::getGroupID('admin-cabang'))) {
            return false;
        }else{
            return true;
        }
    }

    public function getJumlahParticipant(){
        return $this->MemberData()->count();
    }

    public function getURLSegment(){
        $nama = $this->Title;
        $nama = explode(" ",$nama);
        $nama = implode("-",$nama);
        return $nama;
    }

    public function getImageEvent(){
        $sc = SiteConfig::current_site_config();
        if ($this->ImageID != 0 && $this->Image()->exists()){
            return $this->Image();
        }else{
            return $sc->DefaultPhoto();
        }
    }

    public function Link(){
        // {$BaseHref}event/v/$ID-$getURLSegment
        return Director::baseURL()."event/".$this->ID."-".$this->getURLSegment();
    }

    public function getCMSValidator()
    {
      return new Event_Validator();
    }

    public function getCMSFields()
    {
        $fields = new FieldList();
        $fields->add(new TabSet("Root"));
        $fields->addFieldToTab(
            'Root.Main',
            UploadField::create(
                'Image',
                'Image'
            )
        );
        $fields->addFieldToTab(
            'Root.Main',
            TextField::create(
                'Title',
                'Judul Kegiatan'
            )
        );

        $fields->addFieldsToTab(
            'Root.Main',[
                DatetimeField::create('Mulai', 'Event Mulai'),
                DatetimeField::create('Selesai', 'Event Selesai'),
                DropdownField::create(
                    'SakaDataID',
                    'Saka',
                    SakaData::get()->map("ID", "Title")
                ),
                
                DropdownField::create(
                    'KategoriEventDataID',
                    'Kategori Event',
                    KategoriEventData::get()->map("ID", "Title")
                ),
                
                TextareaField::create(
                    'WebinarURL',
                    'Webinar URL (Link Undangan Zoom Meeting, Google Meets dll)'
                ),

                HtmlEditorField::create(
                    'Content',
                    'Deskripsi'
                )      
            ]
        );
        
        $memberList = GridField::create(
            'MemberData',
            'List Participant',
            $this->MemberData(),
            GridFieldConfig_RecordEditor::create()->removeComponentsByType(GridFieldAddNewButton::class)->addComponents(new GridFieldExportButton('buttons-before-left'),new GridFieldPrintButton('buttons-before-left'))
        );
        
        $fields->addFieldToTab(
            'Root.Participant',
            ReadonlyField::create(
                'JumlahParticipant',
                'Jumlah Participant'
            )->setValue($this->MemberData()->count())
        );

        $fields->addFieldToTab(
            'Root.Participant',
            $memberList
        );

        $CommentList = GridField::create(
            'CommentEventData',
            'List Comment',
            $this->CommentEventData(),
            GridFieldConfig_RecordEditor::create()->removeComponentsByType(GridFieldAddNewButton::class)
        );
        

        $fields->addFieldToTab(
            'Root.Comment',
            $CommentList
        );
        return $fields;
    }
}


class Event_Validator extends RequiredFields {
    function php($data)
    {
        $bRet = parent::php($data);
        if ($data['Mulai'] > $data['Selesai']){
            $this->validationError('Mulai','Waktu  Mulai Melebehi Waktu Selesai',"required");
            $bRet = false;
        }
        return $bRet;
    }
}


class KategoriEventData extends DataObject
{
    private static $singular_name = "Kategori Event";
    private static $plural_name = "List Kategori Event";
    private static $db = [
        'Title' => 'Varchar',
    ];


    public function canDelete($member = null)
    {
        $member = Member::currentUser();
        if ($member->inGroup(CT::getGroupID('admin-cabang'))) {
            return false;
        }else{
            return true;
        }
    }

    public function canCreate($member = null, $context = [])
    {
        $member = Member::currentUser();
        if ($member->inGroup(CT::getGroupID('admin-cabang'))) {
            return false;
        }else{
            return true;
        }
    }
    
    public function canEdit($member = null)
    {
        $member = Member::currentUser();
        if ($member->inGroup(CT::getGroupID('admin-cabang'))) {
            return false;
        }else{
            return true;
        }
    }

    private static $has_many = [
        'EventData' => EventData::class
    ];
}

