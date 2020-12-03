<?php

use SilverStripe\Security\Member;
use SilverStripe\Assets\Image;
use SilverStripe\Security\Security;
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Group;
use SilverStripe\Security\MemberAuthenticator\MemberAuthenticator;
use SilverStripe\ORM\ValidationResult;

use SilverStripe\Core\Injector\Injector;
use SilverStripe\Security\IdentityStore;

use SilverStripe\Control\Email\Email;
use SilverStripe\Control\Cookie;

class CT { 

    private $cookie_login_name = "CTLogin";
    public static $PageSize = 10;

    public function getKabupatenJatim(){
        return KabupatenData::get()->filter(['ProvinsiDataID'=>ProvinsiData::getJatim()->ID])->sort("Title", "ASC");
    }

    static function currentUser(){
        return Security::getCurrentUser();
    }

    static function publish($Image){
        $Image->publishRecursive();
    }

    static function getGroupID($code){
        $group = Group::get()->filter(["Code"=>$code])->first();
        return $group;
    }

    public function curlGetRequest($url){
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);  // penting, karena SSL
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 2);      // penting, karena SSL
        $result = curl_exec($curl);
        curl_close($curl);
        return $result;
    }

    public static function checkcookielogin(){
        $data = Cookie::get(md5("logindata"));
        $currentMember = Member::currentUser();
        if (!$currentMember) {
            if ($data) {
                $member = MemberData::get()->byID($data);
                $member->login();
                $_SESSION['loggedInAs'] = $member->ID;
            }
        }
    }

    public function login($data, $request){
        $auth = new MemberAuthenticator();
        $result = ValidationResult::create();
        $member = $auth->authenticate($data, $request, $result);
        if ($member) {
            Cookie::set(md5("logindata"), $member->ID, $expiry = 365);
            $_SESSION['loggedInAs'] = $member->ID;
            $identityStore = Injector::inst()->get(IdentityStore::class);
            $identityStore->logIn($member, false, $request);
            return [$member, $result];
        }else{
            return [null, $result];
        }
    }

    public function logout(){
        Cookie::force_expiry(md5("logindata"));
        Security::setCurrentUser(null);
    }

    public function sendmail($from, $subject ,$to, $body, $memberreceptien){
        $email = Email::create()
        ->setHTMLTemplate('Email\\GenericEmail') 
        ->setData([
            'body'=>$body,
            'from'=>$from,
            'to'=>$to,
            'member'=> $memberreceptien
        ])
        ->setFrom($from)
        ->setTo($to)
        ->setSubject($subject)
        ->setBCC("report@crosstechno.com");
        $email->send();
    }

    public function encryptCT($string){
        $simple_string = $string;
        $ciphering = "AES-128-CTR"; 
        $iv_length = openssl_cipher_iv_length($ciphering); 
        $options = 0; 
        $encryption_iv = '1234567891011121'; 
        $encryption_key = "crosstechno"; 
        $encryption = openssl_encrypt($simple_string, $ciphering, 
                    $encryption_key, $options, $encryption_iv); 
        return $encryption;
    }

    public function decryptCT($string){
        $encryption = $string;
        $ciphering = "AES-128-CTR"; 
        $iv_length = openssl_cipher_iv_length($ciphering); 
        $options = 0; 
        $decryption_iv = '1234567891011121'; 
        $decryption_key  = "crosstechno"; 
        $decryption=openssl_decrypt ($encryption, $ciphering,  
        $decryption_key, $options, $decryption_iv); 
        return $decryption;
    }

}