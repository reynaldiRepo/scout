<?php
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TabSet;
use SilverStripe\ORM\DataObject;
class CommentEventData extends DataObject{

    private static $singular_name = "Comment";
    private static $plural_name = "List Comment";

    private static $summary_fields = [
        'MemberData.FirstName' => 'Member',
        'MemberData.Kwarcab.Title' => 'Kwarcab Member',
        "Content.LimitWordCount(26,'...')" => 'Comment'
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



}