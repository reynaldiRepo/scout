<?php
use SilverStripe\ORM\DataObject;
use SilverStripe\Admin\ModelAdmin;

class EventAdmin extends ModelAdmin{
    private static $managed_models = [
        'EventData',
        'KategoriEventData'
    ];
    private static $url_segment = 'Event';
    private static $menu_title = 'Event';
    private static $menu_icon_class = 'fas fa-calendar-check';
}