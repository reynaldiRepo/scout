<?php
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataObject;

class HobbyData extends DataObject{
    private static $singular_name = "Hobi";
    private static $plural_name = "List Hobi";

    private static $default_sort = "Created Desc";
    private static $db = [
        'Title' => 'Varchar(255)',
    ];

    private static $has_one = [
        'MemberData' => MemberData::class
    ];

    /**
     * Defines summary fields commonly used in table columns
     * as a quick overview of the data for this dataobject
     * @var array
     */
    private static $summary_fields = [
        'Title' => 'Hobi'
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
        $fields->addFieldsToTab(
            'Root.Main',
            [
                TextField::create(
                    'Title',
                    'Hobi'
                )
            ]
        );
        return $fields;
    }
}