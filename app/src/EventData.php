<?php
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


class EventData extends DataObject {
    
    private static $singular_name = "Event";
    private static $plural_name = "List Event";

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
        'SakaData.Title' => 'Saka',
        'KategoriEventData.Title' => 'Kategori',
        'getJumlahParticipant' => 'Participant'
    ];

    public function getJumlahParticipant(){
        return $this->MemberData()->count();
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

        
        $gridFieldConfig = GridFieldConfig_RecordEditor::create();
        $memberList = GridField::create(
            'MemberData',
            'List Participant',
            $this->MemberData(),
            $gridFieldConfig            
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

        $gridFieldConfig = GridFieldConfig_RecordEditor::create();
        $CommentList = GridField::create(
            'CommentEventData',
            'List Comment',
            $this->CommentEventData(),
            $gridFieldConfig            
        );
        

        $fields->addFieldToTab(
            'Root.Comment',
            $CommentList
        );



        
        return $fields;
    }

}


class KategoriEventData extends DataObject
{
    private static $singular_name = "Kategori Event";
    private static $plural_name = "List Kategori Event";
    private static $db = [
        'Title' => 'Varchar',
    ];

    private static $has_many = [
        'EventData' => EventData::class
    ];
}

