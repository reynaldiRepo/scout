<?php
use SilverStripe\ORM\DataObject;
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Forms\GridField\GridFieldImportButton;
use SilverStripe\Forms\GridField\GridFieldEditButton;
class EventAdmin extends ModelAdmin{
    private static $managed_models = [
        'EventData',
        'KategoriEventData'
    ];
    
    private static $url_segment = 'Event';
    private static $menu_title = 'Event';
    private static $menu_icon_class = 'fas fa-calendar-check';

    private static $menu_priority = -3;


    function getEditForm($id = null, $fields = null) {
        $form = parent::getEditForm($id, $fields);
        $form->Fields()
            ->fieldByName($this->sanitiseClassName($this->modelClass))
            ->getConfig()
            ->removeComponentsByType([GridFieldImportButton::class]);

        
        return $form;
    }
}