<?php

use SilverStripe\Security\Member;
use SilverStripe\Admin\LeftAndMainExtension;

use SilverStripe\Admin\CMSMenu;
use SilverStripe\CMS\Controllers\CMSPagesController;
use SilverStripe\AssetAdmin\Controller\AssetAdmin;
use SilverStripe\SiteConfig\SiteConfigLeftAndMain;
use SilverStripe\Admin\SecurityAdmin;


class LeftAndMainExt extends LeftAndMainExtension{
    public function init(){
        $member = Member::currentUser();
        $adminCabangGroup = CT::getGroupID("admin-cabang");
        
        // handle on hide menu for user with admin cabang level
        if ($member->inGroup($adminCabangGroup->ID)){
            CMSMenu::remove_menu_class(CMSPagesController::class);
            CMSMenu::remove_menu_class(AssetAdmin::class);
            CMSMenu::remove_menu_class(SiteConfigLeftAndMain::class);
            CMSMenu::remove_menu_class(SecurityAdmin::class);
            CMSMenu::remove_menu_class(OtherAdmin::class);
            CMSMenu::remove_menu_class(LokasiAdmin::class);
            CMSMenu::remove_menu_class(AdminCabangAdmin::class);
        }   
    }
}