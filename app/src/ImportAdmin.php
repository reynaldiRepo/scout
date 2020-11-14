<?php

use SilverStripe\SiteConfig\SiteConfig;
use SilverStripe\Security\Member;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\ReadonlyField;
use SilverStripe\ORM\DataObject;
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\FormAction;
use SilverStripe\Forms\TabSet;
use SilverStripe\Forms\Form;
use SilverStripe\Forms\LiteralField;
use SilverStripe\Admin\LeftAndMain;
use SilverStripe\Forms\FileField;
use SilverStripe\Forms\RequiredFields;
use SilverStripe\Assets\Upload_Validator;
use JamesGordo\CSV\Parser;

class ImportAdmin extends LeftAndMain {
    private static $url_segment = 'import';
    private static $menu_title = 'Import Data';
    private static $menu_icon_class = 'fas fa-upload';

    private static $allowed_actions = [
        'ImportForm'
    ];

    private $arrKelamin = [
        'Laki-laki'=>'L',
        'Perempuan'=>'P'
    ];


    public function validateCSV($type, $array){
        $member = Member::currentUser();
        if (!$member->inGroup(CT::getGroupID("admin-cabang"))) {
            $patternMember = [
                'Nama',
                'Email',
                'Saka',
                'Golongan',
                'Jenis_Kelamin'];
        }else{
            $patternMember = [
                'Nama',
                'Email',
                'Saka',
                'Golongan',
                'Jenis_Kelamin'
            ];
        }   

        $patternEvent = [
            'Title',
            'Mulai',
            'Selesai',
            'Saka',
            'KategoriEvent'];

        $arrError = [];
        $valid = true;
        if ($type == "Member"){
            foreach($patternMember as $pm){
                if (!array_key_exists($pm, $array)){
                    $valid = false;
                    array_push($arrError,"Coloumn ".$pm." is not exists");
                }
            }
        }else{
            foreach($patternEvent as $pm){
                if (!array_key_exists($pm, $array)){
                    $valid = false;
                    array_push($arrError,"Coloumn ".$pm." is not exists");
                }
            }
        }
        return ["valid"=>$valid, "error"=>$arrError];
    }

    public function writeError($array){
        $res = "";
        foreach($array as $a){
            $res .= empty($res) ? $a : "\n ".$a;
        }
        return $res;
    }

    public function ImportData($data, $form){
        $member = Member::currentUser();

        $parser = new Parser($_FILES['File']['tmp_name']);
        $array = json_decode(json_encode($parser->all()), TRUE);
        $validator = $this->validateCSV($data['Type'], $array[0]);
        if ($validator['valid']){
            $warningMsg =[];
            $IndexWarningMsg =[];
            $Count = 0;
            if ($data['Type'] == "Member"){
                //check Kwarcab
                $index = 1;
                foreach($array as $data){
                    if (isset($data['Kwarcab'])){
                        $Kwarcab = DataObject::get('KabupatenData', "Title Like '%".$data['Kwarcab']."%'");                        
                        if ($Kwarcab->count() == 0 && !$member->inGroup(CT::getGroupID("admin-cabang"))) {
                            array_push($warningMsg, "Kabupaten ".$data['Kwarcab']." Not Found ,warning at row ".$index);
                        }
                    }
                    if (isset($data['Kwarran'])) {
                        $Kwarran = DataObject::get('KecamatanData', "Title Like '%".$data['Kwarran']."%'");
                        if ($Kwarran->count() == 0){
                            array_push($warningMsg, "Kecamatan ".$data['Kwarran']." Not Found ,warning at row ".$index);
                        }
                    }
                    if (isset($data['Saka'])) {
                        $Saka = DataObject::get('SakaData', "Title Like '%".$data['Saka']."%'");
                        if ($Saka->count() == 0){
                            array_push($warningMsg, "Saka ".$data['Saka']." Not Found ,warning at row ".$index);
                        }
                    }
                    if (isset($data['Golongan'])) {
                        $Golongan = DataObject::get('GolonganData', "Title Like '%".$data['Golongan']."%'");
                        if ($Golongan->count() == 0){
                            array_push($warningMsg, "Golongan ".$data['Golongan']." Not Found,warning at row ".$index);
                        }
                    }
                    if (empty($data['Email'])){
                        array_push($warningMsg, "Email Empty ,warning at row ".$index);
                    }else{
                        if (!filter_var($data['Email'], FILTER_VALIDATE_EMAIL)) {
                            array_push($warningMsg, "Format Email ".$data['Email']." Not Correct ,warning at row ".$index);
                        }else{
                            if (MemberData::get()->filter(['Email'=>$data['Email']])->count() != 0){
                                array_push($warningMsg, "Email ".$data['Email']." is exists ,warning at row ".$index);
                            }
                        }
                    }
                    if (empty($data['Nama'])){
                        array_push($warningMsg, "Nama Empty ,warning at row ".$index);
                    }
                    if (empty($data['Jenis_Kelamin'])){
                        array_push($warningMsg, "Jenis_Kelamin Empty ,warning at row ".$index);
                    }else{
                        if (!isset($this->arrKelamin[$data['Jenis_Kelamin']])){
                            array_push($warningMsg, "Jenis_Kelamin ".$data['Jenis_Kelamin']." not found ,warning at row ".$index);
                        }
                    }
                    // var_dump($warningMsg);
                    if (count($warningMsg) !=0){
                        array_push($IndexWarningMsg, $index);
                    }else{
                        $newMember = new MemberData();
                        $newMember->update($data);
                        $nama = $data['Nama'];
                        $nama = explode(" ", $data['Nama']);
                        if (count($nama) != 1){
                            $newMember->FirstName = $nama[0];
                            $newMember->Surname = $nama[1];
                        }else{
                            $newMember->FirstName = $nama[0];
                        }
                        if (isset($data['Kwarcab'])) {
                            if (!$member->inGroup(CT::getGroupID("admin-cabang"))) {
                                $newMember->KwarcabID = $Kwarcab->first()->ID;
                            } else {
                                $newMember->KwarcabID = $member->Kwarcab()->ID;
                            }
                        }   
                        if (isset($data['Kwarran'])) {
                            $newMember->KwarranID = $Kwarran->first()->ID;
                        }
                        $newMember->SakaDataID = $Saka->first()->ID;
                        $newMember->GolonganDataID = $Golongan->first()->ID;
                        $newMember->Password = "12345678";
                        $newMember->Status = "1";
                        if (!isset($this->arrKelamin[$data['Jenis_Kelamin']])){
                            $newMember->Sex = $this->arrKelamin[$data['Jenis_Kelamin']];
                        }
                        $newMember->write();
                        $Count += 1;
                    }
                    $index+=1;
                }
                if (count($warningMsg) !=0) {
                    $msg = $this->writeError($warningMsg)." \n $Count Data Has Been Inserted";
                    $form->sessionMessage($msg, 'warning');
                    return $this->redirectBack();
                }else{
                    $msg = " All good \n $Count Data Has Been Inserted";
                    $form->sessionMessage($msg, 'good');
                    return $this->redirectBack();
                }
            }else{
                die("Event Is Future Update");
            }
        }else{
            $msg = $this->writeError($validator['error']);
            $form->sessionMessage($msg, 'bad');
            return $this->redirectBack();
        }       
    }

    public function ImportForm(){

        $member = Member::currentUser();

        $tabset = TabSet::create('Root')->setTemplate('SilverStripe\\Forms\\CMSTabSet');
        $fields = new FieldList($tabset);

        // csv field

        $csvField = new FileField(
            'File',
            'CSV File');
        $file_validator = new Upload_Validator();
        $file_validator->setAllowedMaxFileSize(1024 * 1024);
        $file_validator->setAllowedExtensions(array(
            'csv'
        ));
        $csvField->setValidator($file_validator);

        if (!$member->inGroup(CT::getGroupID("admin-cabang"))){
            $file = SiteConfig::current_site_config()->FormatCSVMemberCabang()->URL;
            $desc = LiteralField::create('Title', '
            <div class="alert alert-info" role="alert">
            Halaman Untuk Import, Untuk melakukan import data diperlukan file berformat <b>.csv</b> dengan 
            spesifikasi kolom sebgai berikut : <br>
            <hr>
            <h2><b>Member</b></h2>
            <div class="pl-3 pr-3">
            <table class="table table-bordered bg-light" style="margin-bottom:12px">
                <tr>
                    <td>Nama</td>
                    <td>*Email</td>
                    <td>*Saka</td>
                    <td>*Golongan</td>
                    <td>*Jenis_Kelamin</td>
                    <td>Kwarcab</td>
                    <td>Kwarran</td>
                    <td>NTA_SIPA</td>
                    <td>Address</td>
                </tr>
            </table>
            </div>
            <p>NB : Kolom(*) Bersifat Wajib, namun tidak perlu dicantumkan pada header csv<br>
            Password Default untuk member baru 12345678
            </p>
            <hr>
            <p>Anda dapat mengunduh format file csv untuk import data Member  dengan menekan tombol download dibawah ini.</p>
            <a href="'.$file.'" class="btn btn-info text-white">Format CSV</a>
            </div>');
        }else{
            $file = SiteConfig::current_site_config()->FormatCSVMember()->URL;
            $desc = LiteralField::create('Title', '
            <div class="alert alert-info" role="alert">
            Halaman Untuk Import, Untuk melakukan import data diperlukan file berformat <b>.csv</b> dengan 
            spesifikasi kolom sebgai berikut : <br>
            <hr>
            <h2><b>Member</b></h2>
            <div class="pl-3 pr-3">
            <table class="table table-bordered bg-light" style="margin-bottom:12px">
                <tr>
                    <td>*Nama</td>
                    <td>*Email</td>
                    <td>*Saka</td>
                    <td>*Golongan</td>
                    <td>*Jenis_Kelamin</td>
                </tr>
            </table>
            </div>
            <p>NB : Kolom(*) Bersifat Wajib, namun tidak perlu dicantumkan pada header csv<br>
            Password Default untuk member baru 12345678
            </p>
            <hr>
            <p>Anda dapat mengunduh format file csv untuk import data Member  dengan menekan tombol download dibawah ini.</p>
            <a href="'.$file.'" class="btn btn-info text-white">Format CSV</a>
            </div>
            ');
        }

        $fields->addFieldsToTab(
            'Root.Main',
            [
                $desc,
                DropdownField::create(
                    'Type',
                    'Type',
                    // ['Member'=>'Member', 'Event'=>'Event']
                    ['Member'=>'Member']
                ),
                $csvField
                
            ]
        );


        $actions = new FieldList(
            FormAction::create('ImportData')->setTitle('Import')->addExtraClass('btn btn-success')
        );
        $form = new Form($this, 'ImportForm', $fields, $actions, new RequiredFields('File'));
        $form->addExtraClass('cms-content');
        $form->setTemplate($this->getTemplatesWithSuffix('_EditForm'));
        $form->addExtraClass('ss-tabset cms-tabset ' . $this->BaseCSSClasses());
        return $form;
    }

    public function getEditForm($id = null, $fields = null)
    {
        return $this->ImportForm();
    }

    
}