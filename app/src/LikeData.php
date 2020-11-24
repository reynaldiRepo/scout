<?php

use SilverStripe\ORM\DataObject;

class LikeData extends DataObject{
    private static $has_one = [
        'MemberData' => MemberData::class,
        'FeedData' => FeedData::class
    ];
}