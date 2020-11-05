<?php 

use SilverStripe\Assets\Image;

class CustomImage extends Image{
    
    private static $has_one = [
        'CommentEventData' => CommentEventData::class
    ];
    
    public function onAfterWrite()
    {
        parent::onAfterWrite();
        $this->publishRecursive();
    }
}