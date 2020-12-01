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

    public function getpreviewimg(){
        return $this->Fill(50,50);
    }

    private static $summary_fields = [
        'getpreviewimg' => 'Preview',
        'URL' => 'Url',
        'Created',
    ];
}

class CustomFile extends File{    
    public function onAfterWrite()
    {
        parent::onAfterWrite();
        $this->publishRecursive();
    }
}