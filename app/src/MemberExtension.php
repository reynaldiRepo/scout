<?php 
use SilverStripe\SiteConfig\SiteConfig;
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
        'PhotoProfile' => CustomImage::class,
    ];

    
    public function onAfterWrite()
    {
        parent::onAfterWrite();
        if ($this->owner->ClassName == 'SilverStripe\Security\Member'){
            $this->owner->addToGroupByCode("administrators"); 
        }
        
    }

    
    private static $summary_fields = [
        'getPhotoProfileThumb' => 'Photo',
        'FirstName' => 'Firstname',
        'Surname' => 'Surname',
    ];

    public function getGroupName(){
        return $this->owner->Groups()->first();
    }

    public function getFullName(){
        return $this->owner->FirstName." ".$this->owner->Surname;
    }

    public function getPhotoProfileThumb(){
        if ($this->owner->PhotoProfileID != 0 && $this->owner->PhotoProfile()->exists()){
            return $this->owner->PhotoProfile()->Fill(32,32);
        }else{
            $sc = SiteConfig::current_site_config();
            return $sc->DefaultPhotoMember()->Fill(32,32);
        }
    }
    
    public function updateCMSFields(FieldList $fields) 
    {
        $fields->removeByName([
            'Locale',
            'FailedLoginCount',
            'FirstName',
            'Surname',
            'PhotoProfile',
            'DirectGroups'
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
            'Firstname'
        ));
        $fields->insertBefore('Email', TextField::create(
            'Surname',
            'Surname'
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