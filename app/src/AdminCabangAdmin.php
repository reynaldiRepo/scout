<?php

use SilverStripe\ORM\DataObject;
use SilverStripe\Admin\ModelAdmin;
class AdminCabangAdmin extends ModelAdmin
{
    private static $managed_models = [
        'AdminCabangData'
    ];
    private static $url_segment = 'admindata';
    private static $menu_title = 'Admin';
    private static $menu_icon_class = 'fas fa-user-shield';
}