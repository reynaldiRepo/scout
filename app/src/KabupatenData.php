<?php
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;
use SilverStripe\Security\Permission;

class KabupatenData extends DataObject {
    private static $db = [
        'Title' => 'Varchar(255)',
        'PathVmap' => 'Varchar(255)'
    ];
    private static $summary_fields = [
        'Title' => 'Nama Kabupaten',
        'ProvinsiData.Title' => 'Provinsi'
    ];

    private static $has_one = [
        'ProvinsiData' => ProvinsiData::class
    ];

    private static $has_many = [
        'KecamatanData' => KecamatanData::class
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

    static function getKabupatenWithProv(){
        $res = [];
        foreach(KabupatenData::get()->sort("Title","Asc") as $pd){
            $res[$pd->ID] = $pd->Title." Provinsi ".$pd->ProvinsiData()->Title;
        }
        return $res;
    }

    public function getTitleShort(){
        $t = $this->Title;
        $t = explode(' ', $t);
        $t = array_slice($t, 1);
        $t = implode(" ", $t);
        return $t;  
    }

    public function toJsonArray(){
        $res = [];
        $res['ID'] = $this->ID;
        $res['Title'] = $this->Title;
        $res['ProvinsiDataID'] = $this->ProvinsiDataID;
        return $res;
    }
}