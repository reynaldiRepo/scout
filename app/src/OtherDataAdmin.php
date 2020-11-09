<?php 

use SilverStripe\ORM\DataObject;
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Forms\GridField\GridFieldImportButton;

class OtherAdmin extends ModelAdmin {
    private static $managed_models = [
        'GolonganData',
        'SakaData',
        'SosmedCategoryData'
    ];
    private static $url_segment = 'other';
    private static $menu_title = 'Data Lainnya';
    private static $menu_icon_class = 'fas fa-table';

    function getEditForm($id = null, $fields = null) {
        $form = parent::getEditForm($id, $fields);
        $form->Fields()
            ->fieldByName($this->sanitiseClassName($this->modelClass))
            ->getConfig()
            ->removeComponentsByType(GridFieldImportButton::class);
        return $form;
    }
}