<?php 
use SilverStripe\Forms\EmailField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\DateField;
use SilverStripe\Security\Permission;
use SilverStripe\ORM\DataExtension;
use SilverStripe\Forms\FieldList;

class MemberExtension extends DataExtension 
{
    private static $db = [
        'NTA_SIPA'=> 'Varchar(255)',
        'Sex' => 'Varchar(255)',
        'TglLahir' => 'Date',
        'Agama' => 'Varchar(255)',
        'PhoneNumber' => 'Varchar(255)',
        'Address' => 'Text',
        'Bio' => 'HTMLText',
    ];

    private static $has_one = [
        'KabupatenLahir' => KabupatenData::class,
        'Kecamatan' => KecamatanData::class,
    ];

    private $arrKelamin = [
        'L'=>'Laki - Laki',
        'P'=>'Perempuan'
    ];
    
    private $arrAgama = [
        'Islam' => 'Islam',
        'Kristen' => 'Kristen',
        'Protestan' => 'Protestan',
        'Katolik' => 'Katolik',
        'Hindu' => 'Hindu',
        'Buddha' => 'Buddha',
        'Khonghucu' => 'Khonghucu'
    ];

    public function updateCMSFields(FieldList $currentFields) 
    {
        $currentFields->removeByName([
            'Sex',
            'Agama',
            'Locale',
            'FailedLoginCount',
            'NTA_SIPA',
            'Sex' ,
            'TglLahir',
            'Agama' ,
            'Address',
            'Bio',
            'PhoneNumber',
            'FirstName',
            'Surname',
            'Email',
            'KabupatenLahirID',
            'KecamatanID',
        ]);
        $currentFields->addFieldToTab(
            'Root.Main',
            TextField::create(
                'NTA_SIPA',
                'NTA SIPA (Nomoe Tanda Anggota)'
            ),
            'Password'
        );
        $currentFields->insertBefore('NTA_SIPA', EmailField::create(
            'Email',
            'Email'
        ));
        $currentFields->insertAfter('NTA_SIPA', TextField::create(
            'FirstName',
            'Nama Depan'
        ));
        $currentFields->insertAfter('FirstName', TextField::create(
            'Surname',
            'Nama Belakang'
        ));
        $currentFields->insertAfter('Surname', DropdownField::create(
            'Sex',
            'Gender',
            $this->arrKelamin
        ));
        $currentFields->insertAfter('Sex', DropdownField::create(
            'Agama',
            'Agama',
            $this->arrAgama
        ));
        $currentFields->insertAfter('Agama', DateField::create(
            'TglLahir',
            'Tanggal Lahir'
        ));
    }
}