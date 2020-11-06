<?php
 
use SilverStripe\Security\Member;

use SilverStripe\Admin\CMSMenu;
use SilverStripe\Reports\ReportAdmin;

use SilverStripe\VersionedAdmin\ArchiveAdmin;
use SilverStripe\CampaignAdmin\CampaignAdmin;
use SilverStripe\Security\Security;
use SilverStripe\Admin\LeftAndMain;

use SilverStripe\CMS\Controllers\CMSPagesController;
use SilverStripe\AssetAdmin\Controller\AssetAdmin;
use SilverStripe\SiteConfig\SiteConfigLeftAndMain;
use SilverStripe\Admin\SecurityAdmin;

//remove menu on admin===========================
CMSMenu::remove_menu_class(ReportAdmin::class);
// CMSMenu::remove_menu_class(SecurityAdmin::class);
CMSMenu::remove_menu_class(ArchiveAdmin::class);
CMSMenu::remove_menu_class(CampaignAdmin::class);
//==================================================



Security::setDefaultAdmin("admin","admin");