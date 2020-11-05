<?php 

use SilverStripe\Security\Member;
use SilverStripe\ORM\DataExtension;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TabSet;
use SilverStripe\ORM\DataObject;


class AdminCabangData extends Member
{
    private static $db = [
        
    ];

    private static $singular_name = "Admin Cabang";
    private static $plural_name = "List Admin Cabang";
    
    public function onAfterWrite()
    {
        parent::onAfterWrite();
        $this->Groups()->removeAll();
        $this->addToGroupByCode("admin-cabang");        
    }

    /**
     * CMS Fields
     * @return FieldList
     */
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeFieldFromTab('Root', 'Permissions');
        $fields->removeByName([
            'DirectGroups'
        ]);
        return $fields;
    }
    
}