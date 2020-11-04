<?php

use SilverStripe\Control\Director;
use SilverStripe\ORM\DataObject;
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\View\Requirements;

class MemberDataAdmin extends ModelAdmin{
    private static $managed_models = [
        'MemberData'
    ];
    private static $url_segment = 'Member';
    private static $menu_title = 'Data Member';
    private static $menu_icon_class = 'fas fa-users';
    
    function init() {
        parent::init();
        // Requirements:: javascriptTemplate("public/_resources/JS/Admin.js", array(
        //     'BaseHref' => Director::absoluteBaseURL()
        // ));
        
    }
}