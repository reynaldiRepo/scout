<?php

use SilverStripe\SiteConfig\SiteConfig;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\TextareaField;
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;
use SilverStripe\Security\Permission;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TabSet;


class SosmedData extends DataObject{
    private static $db = [
        'URL' => 'Varchar(255)',
        'Username' => 'Varchar(255)',
    ];

    private static $singular_name = "Data Sosial Media";
    private static $plural_name = "List Data Sosial Media";

    private static $has_one = [
        'SosmedCategoryData' => SosmedCategoryData::class,
        'MemberData'=> MemberData::class,
        'SiteConfig'=> SiteConfig::class
    ];

    private static $summary_fields = [
        'SosmedCategoryData.Title' => 'Sosial Media',
        'Username',
        'URL'
    ];

    public function toJsonArray(){
        $res = [];
        $res['ID'] = $this->ID;
        $res['Username'] = $this->Username;
        $res['URL'] = $this->URL;
        $res['SosmedCategoryData'] = $this->SosmedCategoryData()->toJsonArray();
        return $res;
    }


    public function getCMSFields()
    {
        $fields = new FieldList();
        $fields->add(new TabSet("Root"));
        
        $fields->addFieldToTab(
            'Root.Data',
            DropdownField::create(
                'SosmedCategoryDataID',
                'Jenis Sosial Media',
                SosmedCategoryData::get()->map("ID", "Title")
            )
        );

        
        
        $fields->addFieldToTab(
            'Root.Data',
            TextField::create(
            'URL',
            'URL'
            )
        );

        $fields->addFieldToTab(
            'Root.Data',
            TextField::create(
                'Username',
                'Username'
            )
        );
        return $fields;
    }
}

class SosmedCategoryData extends DataObject{
    private static $db = [
        'Title' => 'Varchar(255)',
        'IconCode' => 'Varchar(255)',
    ];

    private static $singular_name = "Jenis Sosial Media";
    private static $plural_name = "Jenis Sosial Media";
    
    public function toJsonArray(){
        $res = [];
        $res['ID'] = $this->ID;
        $res['Title'] = $this->Title;
        $res['IconCode'] = $this->IconCode;
        return $res;
    }

    private $fontIconCode = [
        "fa fa-500px",
        "fa fa-amazon",
        "fa fa-adn",
        "fa fa-android",
        "fa fa-angellist",
        "fa fa-apple",
        "fa fa-bandcamp",
        "fa fa-behance",
        "fa fa-behance-square",
        "fa fa-bitbucket",
        "fa fa-bitbucket-square",
        "fa fa-bitcoin",
        "fa fa-black-tie",
        "fa fa-bluetooth",
        "fa fa-bluetooth-b",
        "fa fa-btc",
        "fa fa-buysellads",
        "fa fa-cc-amex",
        "fa fa-cc-diners-club",
        "fa fa-cc-mastercard",
        "fa fa-cc-paypal",
        "fa fa-cc-stripe",
        "fa fa-cc-visa",
        "fa fa-chrome",
        "fa fa-codepen",
        "fa fa-codiepie",
        "fa fa-connectdevelop",
        "fa fa-contao",
        "fa fa-css3",
        "fa fa-dashcube",
        "fa fa-delicious",
        "fa fa-deviantart",
        "fa fa-digg",
        "fa fa-dribbble",
        "fa fa-dropbox",
        "fa fa-drupal",
        "fa fa-edge",
        "fa fa-eercast",
        "fa fa-empire",
        "fa fa-envira",
        "fa fa-etsy",
        "fa fa-expeditedssl",
        "fa fa-fa",
        "fa fa-facebook",
        "fa fa-facebook-f",
        "fa fa-facebook-official",
        "fa fa-facebook-square",
        "fa fa-firefox",
        "fa fa-first-order",
        "fa fa-flickr",
        "fa fa-fonticons",
        "fa fa-font-awesome",
        "fa fa-fort-awesome",
        "fa fa-forumbee",
        "fa fa-foursquare",
        "fa fa-free-code-camp",
        "fa fa-ge",
        "fa fa-get-pocket",
        "fa fa-gg",
        "fa fa-gg-circle",
        "fa fa-git",
        "fa fa-git-square",
        "fa fa-github",
        "fa fa-github-alt",
        "fa fa-github-square",
        "fa fa-gitlab",
        "fa fa-gittip",
        "fa fa-glide",
        "fa fa-glide-g",
        "fa fa-google",
        "fa fa-google-plus",
        "fa fa-google-plus-circle",
        "fa fa-google-plus-official",
        "fa fa-google-plus-square",
        "fa fa-google-wallet",
        "fa fa-gratipay",
        "fa fa-grav",
        "fa fa-hacker-news",
        "fa fa-houzz",
        "fa fa-html5",
        "fa fa-imdb",
        "fa fa-instagram",
        "fa fa-internet-explorer",
        "fa fa-ioxhost",
        "fa fa-joomla",
        "fa fa-jsfiddle",
        "fa fa-lastfm",
        "fa fa-lastfm-square",
        "fa fa-leanpub",
        "fa fa-linkedin",
        "fa fa-linkedin-square",
        "fa fa-linode",
        "fa fa-linux",
        "fa fa-maxcdn",
        "fa fa-meanpath",
        "fa fa-medium",
        "fa fa-meetup",
        "fa fa-mixcloud",
        "fa fa-modx",
        "fa fa-odnoklassniki",
        "fa fa-odnoklassniki-square",
        "fa fa-opencart",
        "fa fa-openid",
        "fa fa-opera",
        "fa fa-optin-monster",
        "fa fa-pagelines",
        "fa fa-paypal",
        "fa fa-pied-piper",
        "fa fa-pied-piper-alt",
        "fa fa-pinterest",
        "fa fa-pinterest-p",
        "fa fa-pinterest-square",
        "fa fa-product-hunt",
        "fa fa-qq",
        "fa fa-quora",
        "fa fa-ra",
        "fa fa-ravelry",
        "fa fa-rebel",
        "fa fa-reddit",
        "fa fa-reddit-alien",
        "fa fa-reddit-square",
        "fa fa-renren",
        "fa fa-safari",
        "fa fa-scribd",
        "fa fa-sellsy",
        "fa fa-share-alt",
        "fa fa-share-alt-square",
        "fa fa-shirtsinbulk",
        "fa fa-snapchat",
        "fa fa-snapchat-square",
        "fa fa-simplybuilt",
        "fa fa-skyatlas",
        "fa fa-skype",
        "fa fa-slack",
        "fa fa-slideshare",
        "fa fa-soundcloud",
        "fa fa-spotify",
        "fa fa-stack-exchange",
        "fa fa-stack-overflow",
        "fa fa-steam",
        "fa fa-steam-square",
        "fa fa-stumbleupon",
        "fa fa-stumbleupon-circle",
        "fa fa-superpowers",
        "fa fa-telegram",
        "fa fa-tencent-weibo",
        "fa fa-themeisle",
        "fa fa-trello",
        "fa fa-tripadvisor",
        "fa fa-tumblr",
        "fa fa-tumblr-square",
        "fa fa-twitch",
        "fa fa-twitter",
        "fa fa-twitter-square",
        "fa fa-usb",
        "fa fa-viacoin",
        "fa fa-viadeo",
        "fa fa-viadeo-square",
        "fa fa-vimeo",
        "fa fa-vimeo-square",
        "fa fa-vine",
        "fa fa-vk",
        "fa fa-wechat",
        "fa fa-weibo",
        "fa fa-weixin",
        "fa fa-whatsapp",
        "fa fa-wikipedia-w",
        "fa fa-windows",
        "fa fa-wordpress",
        "fa fa-wpbeginner",
        "fa fa-wpexplorer",
        "fa fa-wpforms",
        "fa fa-xing",
        "fa fa-xing-square",
        "fa fa-y-combinator",
        "fa fa-yahoo",
        "fa fa-yelp",
        "fa fa-yc",
        "fa fa-yoast",
        "fa fa-youtube",
        "fa fa-youtube-play",
        "fa fa-youtube-square",
    ];

    private function makeIconCodeArr(){
        $res = [];
        foreach($this->fontIconCode as $fic){
            $res[$fic] = $fic;
        }
        return $res;
    }

    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeByName([
            'Font Icon Code'
        ]);
        $fields->addFieldToTab(
            'Root.Main',
            DropdownField::create(
                'IconCode',
                'IconCode',
                $this->makeIconCodeArr()
            )
        );
        return $fields;
    }

}
