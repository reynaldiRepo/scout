<?php

use SilverStripe\Security\Member;
use SilverStripe\Admin\SecurityAdmin;
use SilverStripe\Admin\LeftAndMainExtension;
use SilverStripe\Forms\FieldList;


class SecurityAdminExtension extends LeftAndMainExtension{
    public function init(){
        parent::init();   
    }
}