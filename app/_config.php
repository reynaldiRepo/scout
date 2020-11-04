<?php
 
use SilverStripe\Admin\CMSMenu;
use SilverStripe\Reports\ReportAdmin;
use SilverStripe\Admin\SecurityAdmin;
use SilverStripe\VersionedAdmin\ArchiveAdmin;
use SilverStripe\CampaignAdmin\CampaignAdmin;
use SilverStripe\Security\Security;
use SilverStripe\Admin\LeftAndMain;

//remove menu on admin===========================
CMSMenu::remove_menu_class(ReportAdmin::class);
// CMSMenu::remove_menu_class(SecurityAdmin::class);
CMSMenu::remove_menu_class(ArchiveAdmin::class);
CMSMenu::remove_menu_class(CampaignAdmin::class);
//==================================================

//default Admin
Security::setDefaultAdmin("admin","admin");