<?php 

use SilverStripe\Forms\DropdownField;
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
    private static $default_sort = "Created Desc";
    
    public function onAfterWrite()
    {
        parent::onAfterWrite();
        $this->addToGroupByCode("admin-cabang");        
    }
    /**
     * Defines summary fields commonly used in table columns
     * as a quick overview of the data for this dataobject
     * @var array
     */
    private static $summary_fields = [
        'Kwarcab.Title' => 'Kwarcab',
    ];

    /**
     * CMS Fields
     * @return FieldList
     */
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeFieldFromTab('Root', 'Permissions');
        $member = Member::currentUser();
        if ($member->inGroup(CT::getGroupID('admin-cabang'))){
            $fields->removeByName([
                'KwarcabID',
                'KwarranID',
                'DirectGroups'
            ]);
            $fields->addFieldToTab(
                'Root.Main',
                DropdownField::create(
                    'KwarcabID',
                    'KwarcabID',
                    [$member->KwarcabID=>$member->Kwarcab()->Title]
                )->setValue($member->KwarcabID)
            );
            $fields->addFieldToTab(
                'Root.Main',
                DropdownField::create(
                    'KwarranID',
                    'KwarranID',
                    KecamatanData::get()->filter(['KabupatenDataID'=>$member->KwarcabID])
                )
            );
        }else{
            $fields->removeByName([
                'DirectGroups'
            ]);
        }
        return $fields;
    }
    
    
}