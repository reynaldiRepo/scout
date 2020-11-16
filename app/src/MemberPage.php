<?php

use SilverStripe\SiteConfig\SiteConfig;
use SilverStripe\Control\Director;
use SilverStripe\Security\Member;
use SilverStripe\View\ArrayData;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\Control\HTTPResponse_Exception;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;
use SilverStripe\Assets\Upload;

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
    ];

    public function index(HTTPRequest $request){
        $member = Member::currentUser();
        if ($member) {
            $data['Title'] = $member->FirstName." Profile";
            return $data;
        }else{
            $this->redirect(Director::baseURL());
        }
    }

    public function edit(){
        $member = Member::currentUser();
        if ($member) {
            $data['Title'] = "Edit Profile ".$member->FirstName;
            return $data;
        }else{
            $this->redirect(Director::baseURL());
        }
    }

    // 'updatebanner',
    //     'updatepp',
    // PhotoProfileID
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
            echo json_encode(['status'=>500, 'msg'=>'Sistem Error']);
            return;       
        }
    }



    public function login(){
        $member = Member::currentUser();
        if ($member){
            return $this->redirect(Director::baseURL());
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
            $newMember = new MemberData();
            $newMember->update($_POST);
            $newMember->Status = "0";
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
            return $this->redirect(Director::baseURL());
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