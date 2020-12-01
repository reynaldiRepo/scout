<?php

use SilverStripe\ORM\DataObject;

class CommentFeedData extends DataObject{
    /**
     * Database fields
     * @var array
     */

    private static $default_sort = "Created Desc";

    private static $db = [
        'Content' => 'HTMLText',
    ];

    private static $has_many = [
        'CommentFeedReply' => CommentFeedData::class
    ];

    private static $has_one = [
        'MemberData' => MemberData::class,
        'FeedData' => FeedData::class,
        'CommentFeedData' => CommentFeedData::class
    ];

    private static $summary_fields = [
        'MemberData.FirstName' => 'User',
        'Content',
        'Created' => 'Date Post'
    ];

    
    public function canEdit($member = null)
    {
        return false ;
    }

    public function canCreate($member = null, $context = [])
    {
        return false;
    }

    public function getChild(){
        return CommentFeedData::get()->filter(['CommentFeedDataID'=> $this->ID])->sort("ID", "DESC");
    }
    
    public function CountComment(){
       return $this->getChild()->count();
    }

    /**
     * CMS Fields
     * @return FieldList
     */
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeByName([
            'MemberDataID',
        ]);
        $fields->addFieldToTab(
            'Root.Main',
            CustomDropdown::create('MemberDataID', 'Sender' , MemberData::get()->map("ID", "FirstName"))
        );
        return $fields;
    }
}