<?php 
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;

class HomePage extends Page{
    
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeByName([
            'Content'
        ]);
        return $fields;
    }
} 

class HomePageController extends PageController{
    private static $allowed_actions = [
        'Test'
    ];
}