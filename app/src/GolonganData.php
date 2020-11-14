<?php

use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataObject;

class GolonganData extends DataObject{
    
    private static $db = [
        'Title' => 'Varchar(255)',
    ];
    
    private static $summary_fields = [
        'Title' => 'Golongan'
    ];

    /**
     * CMS Fields
     * @return FieldList
     */
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeByName([
            'Title'
        ]);
        $fields->addFieldToTab(
            'Root.Main',
            TextField::create(
                'Title',
                'Nama Golongan'
        ));
        return $fields;
    }
}


class SakaData extends DataObject{
    
    private static $db = [
        'Title' => 'Varchar(255)',
    ];

    
    private static $summary_fields = [
        'Title' => 'Saka'
    ];

    public function getTitleShort(){
        $t = $this->Title;
        $t = explode(' ', $t);
        $t = array_slice($t, 1);
        $t = implode(" ", $t);
        return $t;  
    }

    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeByName([
            'Title'
        ]);
        $fields->addFieldToTab(
            'Root.Main',
            TextField::create(
                'Title',
                'Nama Saka'
        ));
        return $fields;
    }
}