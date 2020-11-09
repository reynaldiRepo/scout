<?php

use SilverStripe\Security\Member;
use SilverStripe\Control\Director;
use SilverStripe\ORM\DataObject;
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\View\Requirements;
use SilverStripe\Forms\GridField\GridFieldImportButton;


class MemberDataAdmin extends ModelAdmin{
    private static $managed_models = [
        'MemberData'
    ];
    private static $url_segment = 'Member';
    private static $menu_title = 'Member';
    private static $menu_icon_class = 'fas fa-users';
    
    function init() {
        parent::init();   
    }


    public function getList() 
    {
        $list = parent::getList();
        if($this->modelClass == 'MemberData') {
            $member = Member::currentUser();
            if ($member->inGroup(CT::getGroupID("admin-cabang"))) {
                $list = $list->filter(['KwarcabID'=>$member->KwarcabID]);
            }
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