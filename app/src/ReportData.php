<?php

use SilverStripe\ORM\DataObject;
use SilverStripe\Forms\LiteralField;


class ReportReasonData extends DataObject{
    private static $db = [
        'Title' => 'Varchar(255)'
    ];
}

class ReportData extends DataObject{

    private static $default_sort = "Created Desc";

    private static $db = [
        'OtherReason' => 'Text'
    ];

    private static $summary_fields = [
        'Created' => 'Tanggal Report',
        'MemberData.Email' => 'Sender',
        'getReasonData' => 'Report',
    ];

    private static $has_one = [
        'MemberData' => MemberData::class,
        'FeedData' => FeedData::class,
        'ReportReasonData' => ReportReasonData::class
    ];

    
    public function canCreate($member = null, $context = [])
    {
        return false;
    }

    public function canEdit($member = null)
    {
        return false ;
    }

    public function getReasonData(){
        if ($this->ReportReasonDataID == "0"){
            return "Lainnya : ".$this->OtherReason;
        }else{
            return $this->ReportReasonData()->Title;
        }
    }

    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeByName([
            'MemberDataID',
            'FeedDataID',
            'ReportReasonDataID',
            'OtherReason'
        ]);

        $fields->addFieldToTab(
            'Root.Main',
            LiteralField::create("Created", "Reported at ".$this->Created)
        );

        $fields->addFieldToTab(
            'Root.Main',
            LiteralField::create("Sender", "Reported By ".$this->MemberData()->FirstName." / ".$this->MemberData()->Email)
        );

        $fields->addFieldToTab(
            'Root.Main',
            LiteralField::create("FeedContent", "Feed Content : ".$this->FeedData()->content)
        );

        $fields->addFieldToTab(
            'Root.Main',
            LiteralField::create("FeedContent", "Report Reason ".$this->getReasonData())
        );

        return $fields;
    }

}


