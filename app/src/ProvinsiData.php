<?php
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;
use SilverStripe\Security\Permission;

class ProvinsiData extends DataObject {
    private static $db = [
        'Title' => 'Varchar(255)',
    ];

    private static $summary_fields = [
        'Title' => 'Nama Provinsi'
    ];

    private static $has_many = [
        'KabupatenData' => KabupatenData::class
    ];
    
    public function canCreate($member = null, $context = []) 
    {
        return false;
    }

    public function canEdit($member = null)
    {
        return false;
    }
    public function canDelete($member = null)
    {
        return false;
    }

    static function getJatim(){
        return DataObject::get('ProvinsiData', "Title Like '%Jawa Timur%'")->first();
    }

    public function toJsonArray(){
        $res = [];
        $res['ID'] = $this->ID;
        $res['Title'] = $this->Title;
        return $res;
    }
}