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
use SilverStripe\Forms\GridField\GridFieldAddNewButton;
use SilverStripe\Forms\GridField\GridFieldExportButton;
use SilverStripe\Forms\GridField\GridFieldPrintButton;
use SilverStripe\Forms\RequiredFields;

class FeedData extends DataObject{
    /**
     * Database fields
     * @var array
     */
    private static $db = [
        'Content' => 'HTMLText',
    ];

    private static $has_one = [
        'MemberData' => MemberData::class,
    ];

    private static $has_many = [
        'Image' => CustomImage::class,
        'CommentFeedData' => CommentFeedData::class,
        'LikeData' => LikeData::class
    ];

    private static $singular_name = 'Feed Anggota';
    private static $plural_name = 'List Feed Anggota';

    private static $summary_fields = [
        'Created' => 'Date Post',
        'MemberData.FirstName' => 'User',
        'Content',
        'CountLike' => 'Like',
        'CountComment' => 'Comment'
    ];

    public function CountLike(){
        return $this->LikeData()->count();
    }

    public function CountComment(){
        return $this->CommentFeedData()->count();
    }

    public function Link(){
        return Director::absoluteBaseURL()."member/post/".$this->ID;
    }

    public function canCreate($member = null, $context = [])
    {
        return false;
    }

    public function canEdit($member = null)
    {
        return false;
    }

    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeByName([
            'MemberDataID'
        ]);
        $fields->addFieldToTab(
            'Root.Main',
            CustomDropdown::create('MemberDataID', 'Member', MemberData::get()->map("ID", "FirstName"))
        );

        $gridfield = GridField::create(
            'Image',
            'Image',
            $this->Image(),
            GridFieldConfig_RecordEditor::create()  
        );
        $fields->addFieldToTab(
            'Root.Image',
            $gridfield
        );
        return $fields;
    }
}