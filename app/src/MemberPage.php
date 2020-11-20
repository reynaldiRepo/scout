<?php

use SilverStripe\SiteConfig\SiteConfig;
use SilverStripe\Control\Director;
use SilverStripe\Security\Member;
use SilverStripe\View\ArrayData;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\Control\HTTPResponse_Exception;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;
use SilverStripe\Assets\Upload;
use SilverStripe\ORM\PaginatedList;

class MemberPage extends Page {
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeByName([
            'Content'
        ]);
        return $fields;
    }
}

class MemberPageController extends PageController{

    protected function init()
    {
        parent::init();

        $member = Member::currentUser();
        if ($member) {
            $adminCabangGroup = CT::getGroupID("admin-cabang");
            $admin = CT::getGroupID("administrators");
            if ($member->inGroup($admin->ID) || $member->inGroup($adminCabangGroup->ID)) {
                $this->redirect("admin");
                return ;
            }
        }
    }

    private static $allowed_actions = [
        'login',
        'dologin',
        'logout',
        'doregister',
        'forgotpassword',
        'dosendlinkpwd',
        'resetpassword',
        'newpassword',
        'verifyemail',
        'edit',
        'updatebanner',
        'updatepp',
        'doupdate',
        'addsosmed',
        'deletesosmed',
        'addhobby',
        'deletehobby',
        'v',
        'all'
    ];

    /**
     * Defines URL patterns.
     * @var array
     */
    private static $url_handlers = [
        'v/$ID' => 'v'
    ];

    public function all(){
        $member = Member::currentUser();
        if (!$member){
            return $this->redirect('member/login');
        }
        $data['Title'] = "Member Peransaka";
        $arrayFilter = [];
        $arrayNama = [];
        if (!empty($_GET)) {
            if (isset($_GET['SakaDataID'])) {
                if (!empty($_GET['SakaDataID'])) {
                    $arrayFilter['SakaDataID'] = $_GET['SakaDataID'];
                }
            }
            if (isset($_GET['GolonganDataID'])) {
                if (!empty($_GET['GolonganDataID'])) {
                    $arrayFilter['GolonganDataID'] = $_GET['GolonganDataID'];
                }
            }
            if (isset($_GET['KwarcabID'])) {
                if (!empty($_GET['KwarcabID'])) {
                    $arrayFilter['KwarcabID'] = $_GET['KwarcabID'];
                }
            }
            if (isset($_GET['Nama'])) {
                if (!empty($_GET['Nama'])) {
                    $nama = explode(" ", $_GET['Nama']);
                    foreach ($nama as $s) {
                        $arrayNama['FirstName:PartialMatch'] = $s;
                        $arrayNama['Surname:PartialMatch'] = $s;
                    }
                }
            }
        }
        if (empty($arrayFilter) && empty($arrayNama)){
            $members = MemberData::get();
        }elseif(!empty($arrayFilter) && empty($arrayNama)){
            $members = MemberData::get()->filter($arrayFilter);
        }elseif(empty($arrayFilter) && !empty($arrayNama)){
            $members = MemberData::get()->filterAny($arrayNama);
        }elseif(!empty($arrayFilter) && !empty($arrayNama)){
            $members = MemberData::get()->filter($arrayFilter)->filterAny($arrayNama);
        }
        $pages = new PaginatedList($members, $this->getRequest());
        $pages->setPageLength(24);
        $data['Members'] = $pages;
        if (!empty($arrayFilter)){
            foreach($arrayFilter as $k=>$v){
                $data[$k]=$v;
            }
        }
        if (!empty($arrayNama)){
            $data['Nama'] = $_GET['Nama'];
        }
        return $this->customise($data)->renderWith(array('CleanPage', 'MemberAll'));
    }

    public function v(){
        $member = Member::currentUser();
        if (!$member){
            return $this->redirect('member/login');
        }
        if (!$this->getRequest()->param('ID')){
            die("404/ not found");
            return;
        }
        $id = $this->getRequest()->param('ID');
        $id = explode("-", $id);
        $id = $id[0];
        if ($id == $member->ID){
            return $this->redirect("member/");
        }
        $member = MemberData::get()->byID($id);
        $data ['Title'] = "Profile ".$member->FirstName;
        $data['Member'] = $member;
        return $data;
    }

    public function index(HTTPRequest $request){
        $member = Member::currentUser();
        if ($member) {
            $data['Title'] = $member->FirstName." Profile";
            return $data;
        }else{
            $this->redirect('member/login');
        }
    }

    public function edit(){
        $member = Member::currentUser();
        if ($member) {
            $data['Title'] = "Edit Profile ".$member->FirstName;
            $url = Director::absoluteBaseURL()."member/resetpassword";
            $encrypt = CT::encryptCT($member->ID."xax".date("Ymdhis")."xax".$member->FirstName);
            $url .= "?key=".$encrypt;
            $data['URL_PWD'] = $url;
            return $data;
        }else{
            $this->redirect('member/login');
        }
    }

    public function doupdate($data){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'Session expired please login']);
            return;       
        }
        

        //chcek email
        if ($data['Email'] != $member->Email){
            $other = DataObject::get('MemberData', "Email='".$data['Email']."'");
            if ($other->count() > 0){
                echo json_encode(['status'=>500, 'msg'=>'Email telah digunakan']);
                return;       
            }
        }

        $member->update($_POST);  
        $valid = $member->validate();
        if ($valid->isValid()){
            $member->write();
            echo json_encode(['status'=>200, 'msg'=>'Update Success']);
            return;       
        }else{
            echo json_encode(['status'=>200, 'msg'=>'Something Wrong !!!']);
            return;     
        }
    }

    
    public function updatebanner($data){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'Session expired please login']);
            return;       
        }
        $newImage = new CustomImage();
        $upl = new Upload();
        $upl->loadIntoFile($data['BannerImage'], $newImage, "/Uploads"); 
        if ($newImage->ID != 0) {
            $member->BannerImageID = $newImage->ID;
            $member->write();
            echo json_encode(['status'=>200, 'msg'=>'Success']);
            return;       
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Sistem Error']);
            return;       
        }
    }

    public function updatepp($data){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'Session expired please login']);
            return;       
        }
        $newImage = new CustomImage();
        $upl = new Upload();
        $upl->loadIntoFile($data['PhotoProfile'], $newImage, "/Uploads"); 
        if ($newImage->ID != 0) {
            $member->PhotoProfileID = $newImage->ID;
            $member->write();
            echo json_encode(['status'=>200, 'msg'=>'Success']);
            return;       
        }else{
            echo json_encode(['status'=>500, 'msg'=>'System Error']);
            return;       
        }
    }


    // 'addsosmed',
    // 'deletesosmed',
    // 'addhobby',
    // 'deletehobby'

    public function addsosmed($data){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'Session expired please login']);
            return;       
        }
        $newSosmed = new SosmedData();
        $newSosmed->update($_POST);
        $id = $newSosmed->write();
        if ($id) {
            $member->SosmedData()->add($newSosmed);
            echo json_encode(['status'=>200, 'msg'=>'Add Data Success', 'data'=>
            $newSosmed->toJsonArray()]);
            return;       
        }else{
            echo json_encode(['status'=>500, 'msg'=>'System Error']);
        }
    }

    public function deletesosmed(){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'Session expired please login']);
            return;       
        }
        if (!isset($_GET['id'])){
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong']);
            return;       
        }
        $sosmed = SosmedData::get()->byID($_GET['id']);
        if ($sosmed) {
            $sosmed->delete();
            echo json_encode(['status'=>200, 'msg'=>'Delete Data Success']);
            return;       
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Maybe this data has been deleted']);
        }
    }


    public function addhobby($data){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'Session expired please login']);
            return;       
        }
        $newHobby = new HobbyData();
        $newHobby->update($_POST);
        $id = $newHobby->write();
        if ($id) {
            $member->HobbyData()->add($newHobby);
            echo json_encode(['status'=>200, 'msg'=>'Add Data Success', 'data'=>
            $newHobby->toJsonArray()]);
            return;       
        }else{
            echo json_encode(['status'=>500, 'msg'=>'System Error']);
        }
    }

    public function deletehobby(){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'Session expired please login']);
            return;       
        }
        if (!isset($_GET['id'])){
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong']);
            return;       
        }
        $hobby = HobbyData::get()->byID($_GET['id']);
        if ($hobby) {
            $hobby->delete();
            echo json_encode(['status'=>200, 'msg'=>'Delete Data Success']);
            return;       
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Maybe this data has been deleted']);
        }
    }

    public function login(){
        $member = Member::currentUser();
        if ($member){
            return $this->redirect('home/dashboard');
        }
        return $this->renderWith(array('login'));
    }

    public function dologin($data){        
        $login = CT::login($_REQUEST, $data);
        if ($member = $login[0]){
            if ($member->Status == '0'){
                echo json_encode(['status'=>500, 'msg'=>'Account is not active']);
                return;    
            }
            elseif($member->inGroup(CT::getGroupID('administrators')) || $member->inGroup(CT::getGroupID('admin-cabang'))){
                echo json_encode(['status'=>500, 'msg'=>'Admin Cant login on this page']);
                return;    
            }else{
                echo json_encode(['status'=>200]);
                return;
            }
        }else{
            $msg = $login[1]->getMessages();
            echo json_encode(['status'=>500, 'msg'=>$msg[0]['message']]);
            return;
        }
    }

    public function logout(){
        CT::logout();
        session_destroy();
        return $this->redirect("member/login");
    }


    public function sendverify($member){
        $key = CT::encryptCT($member->ID."xxxverifikasiemail".date("Ymdhis"));
        $url = Director::absoluteBaseURL()."member/verifyemail?key=".$key;
        $from = SiteConfig::current_site_config()->EmailInfo;
        $subject = "Registrasi Berhasil";
        $to = $member->Email;
        $body = "Terimakasih untuk mendaftar pada Peransaka Jawa Timur, 
        silahkan lakukan validasi email dengan menekan link dibawah <br>
        <a href='$url'>Verifikasi Email</a>";
        CT::sendmail($from, $subject, $to, $body, $member);
    }

    public function doregister($data){
        
        $member = DataObject::get('MemberData', "Email = '".$data['Email']."'");
        // $member = DataObject::get('MemberData', "Email = '".$data['Email']."' OR NTA_SIPA = '".$data['NTA_SIPA']."'");
        $allMember = Member::get()->filter(['Email'=>$data['Email']]);
        if ($member->count() != 0 || $allMember->count() != 0){
            echo json_encode(['status'=>500, 'msg'=>'Email sudah terdaftar']);
            // echo json_encode(['status'=>500, 'msg'=>'Email / NTA_SIPA sudah terdaftar']);
            return;
        }else{
            if ($data['Password'] != $data['Password2']){
                echo json_encode(['status'=>500, 'msg'=>'Password dan Konfirmasi Password Tidak Sama']);
                return;
            }
            $newMember = new MemberData();
            $newMember->update($_POST);
            $newMember->Status = "0";
            $newMember->NoNeedChangePassword = "1";
            $newMember->write();
            if ($newMember) {
                $this->sendverify($newMember);
            }
            echo json_encode(['status'=>200, 'msg'=>'Registrasi Sukses, Silahkan verifikasi check inbox email anda']);
            return;
        }
    }

    public function forgotpassword(){
        $member = Member::currentUser();
        if ($member){
            return $this->redirect('member/login');
        }
        return $this->renderWith(array('forgotpassword'));
    }

    public function dosendlinkpwd($data){
        $member = MemberData::get()->filter(['Email'=>$data['Email']])->first();
        if ($member){
            
            $url = Director::absoluteBaseURL()."member/resetpassword";
            $encrypt = CT::encryptCT($member->ID."xax".date("Ymdhis")."xax".$member->FirstName);
            $url .= "?key=".$encrypt;
            
            $from = SiteConfig::current_site_config()->EmailInfo;
            $subject = "Reset Password Akun Peransaka Jatim";
            $to = $member->Email;
            $body = "Berikut link untuk melakukan reset password, jangan berikan link tersebut kepada orang lain <br>
                    <a href='$url'>Klik Disini</a>";
            CT::sendmail($from, $subject, $to, $body, $member);
            echo json_encode(['status'=>200, 'msg'=>'Silahkan cek email anda']);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Email Not Found']);
            return;
        }
    }

    public function resetpassword(){
        if (!isset($_GET['key'])){
            die('Not Allowed');
        }else{
            $key = $_GET['key'];
            $key = CT::decryptCT($key);
            $idMember = explode('xax', $key)[0];
            if ($idMember){
                return $this->customise(array(
                    'key'=>$_GET['key']
                ))->renderWith(array('resetpassword'));
            }else{
                die('Not Allowed');
            }   
        }
    }

    public function newpassword($data){
        if (!isset($_GET['key'])){
            echo json_encode(['status'=>500, 'msg'=>'Something wrong, contact Web admin']);
            return;    
        }else{
            $key = $_GET['key'];
            $key = CT::decryptCT($key);
            $idMember = explode('xax', $key)[0];
            if ($idMember){
                if ($_POST['Password'] != $_POST['PasswordCon']){
                    echo json_encode(['status'=>500, 'msg'=>'Password Tidak Sama']);
                    return;
                }
                $member = MemberData::get()->byID($idMember);
                if ($member){
                    $member->Password = $_POST['Password'];
                    $val = $member->validate();
                    if ($val->isValid()) {
                       $member->write();
                       echo json_encode(['status'=>200, 'msg'=>'Proses Sukses ,Silahkan Login']);
                       return;    
                    }else{
                        // var_dump($val);
                        $msg = $val->getMessages();
                        $msgStr = "";
                        foreach($msg as $m){
                            $msgStr .= $m['message']." ";
                        }
                        echo json_encode(['status'=>500, 'msg'=>$msgStr]);
                        return;    
                    }
                }else{
                    echo json_encode(['status'=>500, 'msg'=>'Something wrong, contact Web admin']);
                    return;    
                }
                
            }else{
                echo json_encode(['status'=>500, 'msg'=>'Something wrong, contact Web admin']);
                return;
            }   
        }
    }

    public function verifyemail(){
        if (!isset($_GET['key'])){
            die("/404 not allowed");
            return;
        }

        $dec = CT::decryptCT($_GET['key']);
        $dec = explode("xxx", $dec);
        $member = MemberData::get()->byID($dec[0]);
        if ($member){
            $member->Status = '1';
            $member->write();
            return $this->customise(array(
                'member'=> $member
            ))->renderWith(array('verifyemail'));
        }else{
            die("/404 not allowed");
            return;
        }

        
    }

}