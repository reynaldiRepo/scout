<?php

use SilverStripe\Forms\TextField;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
use SilverStripe\ORM\DataExtension;


class SiteConfigCustom extends DataExtension 
{
    
    private static $db = [
        'DeskripsiWeb' => 'HTMLText',
        'MetaTitle' => 'Text',
        'MetaDescription' => 'Text',
        'GoogleAnalytic' => 'Text',
        'EmailInfo' => 'Varchar(255)',
    ];

    private static $has_many = [
        'SosmedData' => SosmedData::class
    ];

    private static $has_one = [
        'WebLogo' => CustomImage::class,
        'SmallWebLogo' => CustomImage::class,
        'DefaultPhotoMember' => CustomImage::class,
        'DefaultPhotoBannerMember' => CustomImage::class,
        'DefaultPhoto' => CustomImage::class,
        'FavicoImage' => CustomImage::class,
        'LoadingGif' => CustomImage::class
    ];

    public function onAfterWrite()
    {
        parent::onAfterWrite();
    }

    public function updateCMSFields(FieldList $fields) 
    {
        $fields->addFieldsToTab(
            'Root.Web Image',
            [
                UploadField::create(
                    'WebLogo',
                    'Web Logo'
                ),
                UploadField::create(
                    'SmallWebLogo',
                    'Small Web Logo'
                ),
                UploadField::create(
                    'DefaultPhotoMember',
                    'Default Photo Member'
                ),
                UploadField::create(
                    'DefaultPhotoBannerMember',
                    'Default Photo Banner Member'
                ),
                UploadField::create(
                    'DefaultPhoto',
                    'Default Photo'
                ),
                UploadField::create(
                    'FavicoImage',
                    'Favico'
                ),
                UploadField::create(
                    'LoadingGif',
                    'Loading'
                ),
            ]
        );

        $fields->addFieldToTab("Root.Main", 
            TextareaField::create(
                'DeskripsiWeb',
                'Deskripsi Singkat'
            )
        );

        $fields->addFieldToTab("Root.Main", 
            TextareaField::create(
                'MetaTitle',
                'Meta Title (Judul General Untuk Menjelaskan Halaman Web)'
             )
        );

        $fields->addFieldToTab("Root.Main", 
            TextareaField::create(
                'MetaDescription',
                'Meta Description (Deskripsi General Untuk Menjelaskan Halaman Web)'
             )
        );

        $fields->addFieldToTab("Root.Script", 
            TextareaField::create(
                'GoogleAnalytic',
                'Google Analytic Script'
             )
        );

        $fields->addFieldsToTab(
            'Root.Email',
            [
                TextField::create(
                    'EmailInfo',
                    'Email Info, digunakan untuk email pengiriman notifikasi pada user, gunakan email dengan nama domain anda'
                )
            ]
        );
    }
}