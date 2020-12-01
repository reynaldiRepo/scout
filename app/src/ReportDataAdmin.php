<?php

use SilverStripe\Security\Member;
use SilverStripe\ORM\DataObject;
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Forms\GridField\GridFieldImportButton;

class ReportDataAdmin extends ModelAdmin
{
    private static $managed_models = [
        'FeedData',
        'ReportReasonData'
    ];
    private static $menu_priority = -6;
    private static $url_segment = 'reportdata';
    private static $menu_title = 'Reported Feed';
    private static $menu_icon_class = 'fas fa-exclamation';

    function init() {
        parent::init();   
    }

    public function getList() 
    {
        $list = parent::getList();
        if($this->modelClass == 'FeedData') {
            $list = FeedData::get()->filter([
                'ReportData.Count():GreaterThan' => 0
            ]);
        }
        return $list;
    }

    function getEditForm($id = null, $fields = null) {
        $form = parent::getEditForm($id, $fields);
        $form->Fields()
            ->fieldByName($this->sanitiseClassName($this->modelClass))
            ->getConfig()
            ->removeComponentsByType(GridFieldImportButton::class);
        return $form;
    }

    
}