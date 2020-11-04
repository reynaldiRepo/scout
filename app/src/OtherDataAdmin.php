<?php 

use SilverStripe\ORM\DataObject;
use SilverStripe\Admin\ModelAdmin;
class OtherAdmin extends ModelAdmin {
    private static $managed_models = [
        'GolonganData',
        'SakaData',
        'SosmedCategoryData'
    ];
    private static $url_segment = 'other';
    private static $menu_title = 'Other';
    private static $menu_icon_class = 'fas fa-table';
}