<?php
use SilverStripe\ORM\DataObject;
use SilverStripe\Admin\ModelAdmin;
class LokasiAdmin extends ModelAdmin{
    private static $managed_models = [
        'ProvinsiData',
        'KabupatenData',
        'KecamatanData'
    ];
    private static $url_segment = 'lokasi';
    private static $menu_title = 'Data Lokasi';
    private static $menu_icon_class = 'fas fa-map';
}