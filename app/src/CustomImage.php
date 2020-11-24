<?php 

use SilverStripe\Assets\Image;
use SilverStripe\Assets\File;

class CustomImage extends Image{
    
    private static $has_one = [
        'CommentEventData' => CommentEventData::class,
        'FeedData' => FeedData::class
    ];
    
    public function onAfterWrite()
    {
        parent::onAfterWrite();
        $this->publishRecursive();
    }
}

class CustomFile extends File{    
    public function onAfterWrite()
    {
        parent::onAfterWrite();
        $this->publishRecursive();
    }
}