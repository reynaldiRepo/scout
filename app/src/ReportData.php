<?php

use SilverStripe\Forms\ReadonlyField;
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
            ReadonlyField::create("Created", "Reported at ")->setValue($this->Created)
        );

        $fields->addFieldToTab(
            'Root.Main',
            ReadonlyField::create("Sender", "Reported By ")->setValue($this->MemberData()->FirstName." / ".$this->MemberData()->Email)
        );

        $fields->addFieldToTab(
            'Root.Main',
            ReadonlyField::create("FeedContent", "Feed Content : ")->setValue($this->FeedData()->content)
        );

        $fields->addFieldToTab(
            'Root.Main',
            ReadonlyField::create("FeedContent", "Report Reason ")->setValue($this->getReasonData())
        );

        return $fields;
    }

}


