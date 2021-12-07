<?php

setlocale(LC_ALL, 'id_ID.UTF8', 'id_ID.UTF-8', 'id_ID.8859-1', 'id_ID', 'IND.UTF8', 'IND.UTF-8', 'IND.8859-1', 'IND', 'Indonesian.UTF8', 'Indonesian.UTF-8', 'Indonesian.8859-1', 'Indonesian', 'Indonesia', 'id', 'ID', 'en_US.UTF8', 'en_US.UTF-8', 'en_US.8859-1', 'en_US', 'American', 'ENG', 'English');
date_default_timezone_set('Asia/Jakarta');

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