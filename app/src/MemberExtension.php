<?php 
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Security\Permission;
use SilverStripe\ORM\DataExtension;
use SilverStripe\Forms\FieldList;



class MemberExtension extends DataExtension 
{   
    private static $has_one = [
        'Kwarcab' => KabupatenData::class,
        'Kwarran' => KecamatanData::class,
        'PhotoProfile' => Image::class,
    ];
    
    public function updateCMSFields(FieldList $fields) 
    {
        $fields->removeByName([
            'Locale',
            'FailedLoginCount',
            'FirstName',
            'Surname',
            'PhotoProfile'
        ]);
        $Kwarcab = CustomDropdown::create(
            'KwarcabID',
            'Kwarcab',
            KabupatenData::get()->filter(['ProvinsiDataID'=>ProvinsiData::getJatim()->ID])->sort("Title", "ASC")->map("ID", "Title")
        )->setEmptyString('Plih Kabupaten Kwarcab');
        if ($this->KwarranID != 0){
            $Kwarcab->setValue($this->Kwarran()->KabupatenDataID);
            $Kwarran = DropdownField::create(
                'KwarranID',
                'Kwarran',
                KecamatanData::get()->filter(['KabupatenDataID'=>$this->Kwarran()->KabupatenDataID])->sort("Title", "ASC")->map("ID", "Title")
            )->setEmptyString('Pilih Kecamatan Kwarran')->setHasEmptyDefault(true);
        }else{
            $Kwarran = CustomDropdown::create(
                'KwarranID',
                'Kwarran',
                array()
            )->setEmptyString('Pilih Kecamatan Kwarran')->setHasEmptyDefault(true);
        }

        $fields->insertBefore('Email', UploadField::create(
            'PhotoProfile',
            'Photo Profile'
        ));
        $fields->insertBefore('Email', TextField::create(
            'FirstName',
            'Nama Depan'
        ));
        $fields->insertBefore('Email', TextField::create(
            'Surname',
            'Nama Belakang'
        ));
        $fields->addFieldsToTab(
            'Root.Main',
            [
                $Kwarcab,
                $Kwarran
            ]
        );
    }
}