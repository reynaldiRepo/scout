<?php

use SilverStripe\ORM\DataObject;

class LikeData extends DataObject{
    private static $has_one = [
        'MemberData' => MemberData::class,
        'FeedData' => FeedData::class
    ];

    /**
     * DataObject create permissions
     * @param Member $member
     * @param array $context Additional context-specific data which might
     * affect whether (or where) this object could be created.
     * @return boolean
     */
    public function canCreate($member = null, $context = [])
    {
        return false;
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