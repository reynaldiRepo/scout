<?php

use SilverStripe\Security\Member;
use SilverStripe\ORM\DataObject;
use SilverStripe\Admin\ModelAdmin;

class AdminCabangAdmin extends ModelAdmin
{
    private static $managed_models = [
        'AdminCabangData'
    ];
    private static $menu_priority = -6;
    private static $url_segment = 'admindata';
    private static $menu_title = 'Admin Cabang';
    private static $menu_icon_class = 'fas fa-user-shield';

    function init() {
        parent::init();   
    }

    public function getList() 
    {
        $list = parent::getList();
        if($this->modelClass == 'AdminCabangData') {
            $member = Member::currentUser();
            if ($member->inGroup(CT::getGroupID("admin-cabang"))) {
                $list = $list->filter(['KwarcabID'=>$member->KwarcabID]);
            }
        }
        return $list;
    }
}