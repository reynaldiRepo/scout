<?php
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TabSet;
use SilverStripe\ORM\DataObject;
class CommentEventData extends DataObject{

    private static $singular_name = "Comment";
    private static $plural_name = "List Comment";

    private static $summary_fields = [
        "Created"=>'Post',
        'MemberData.FirstName' => 'Member',
        'MemberData.Kwarcab.Title' => 'Kwarcab Member',
        "Content" => 'Comment',
    ];

    private static $db = [
        'Content' => 'HTMLText',
    ];

    private static $has_many = [
        'CustomImage' => CustomImage::class
    ];

    private static $has_one = [
        'MemberData' => MemberData::class,
        'EventData' => EventData::class
    ];

    /**
     * CMS Fields
     * @return FieldList
     */
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeByName([
            'MemberData'
        ]);
        $fields->addFieldToTab(
            'Root.Main',
            DropdownField::create(
                'MemberDataID',
                'Member',
                MemberData::get()->map('ID', 'FirstName')
            )
        );
        return $fields;
    }

    /**
     * DataObject edit permissions
     * @param Member $member
     * @return boolean
     */
    public function canEdit($member = null)
    {
        return false;
    }



}