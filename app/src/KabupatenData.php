<?php
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;
use SilverStripe\Security\Permission;

class KabupatenData extends DataObject {
    private static $db = [
        'Title' => 'Varchar(255)',
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
}