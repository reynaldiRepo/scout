<?php
use SilverStripe\ORM\DataObject;
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Forms\GridField\GridFieldImportButton;

class LokasiAdmin extends ModelAdmin{
    private static $managed_models = [
        'ProvinsiData',
        'KabupatenData',
        'KecamatanData'
    ];
    private static $url_segment = 'lokasi';
    private static $menu_title = 'Lokasi';
    private static $menu_icon_class = 'fas fa-map';

    function getEditForm($id = null, $fields = null) {
        $form = parent::getEditForm($id, $fields);
        $form->Fields()
            ->fieldByName($this->sanitiseClassName($this->modelClass))
            ->getConfig()
            ->removeComponentsByType(GridFieldImportButton::class);
        return $form;
    }
}