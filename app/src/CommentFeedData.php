<?php

use SilverStripe\ORM\DataObject;

class CommentFeedData extends DataObject{
    /**
     * Database fields
     * @var array
     */
    private static $db = [
        'Content' => 'HTMLText',
    ];

    private static $has_many = [
        'CommentFeedData' => CommentFeedData::class
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

    public function getChild(){
        return CommentFeedData::get()->filter(['CommentFeedDataID'=> $this->ID])->sort("ID", "DESC");
    }
    
    public function CountComment(){
       return $this->getChild()->count();
    }
}