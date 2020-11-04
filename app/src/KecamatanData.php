<?php 
use SilverStripe\ORM\DataObject;
class KecamatanData extends DataObject {
    private static $db = [
        'Title' => 'Varchar(255)',
    ];   

    private static $summary_fields = [
        'Title' => 'Nama Kecamatan',
        'KabupatenData.Title' => 'Kabupaten'
    ];

    private static $has_one = [
        'KabupatenData' => KabupatenData::class,
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

    public function toJsonArray(){
        $res = [];
        $res['ID'] = $this->ID;
        $res['Title'] = $this->Title;
        $res['KabupatenDataID'] = $this->KabupatenDataID;
        return $res;
    }


}