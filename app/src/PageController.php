<?php

namespace {

use SilverStripe\Control\Director;
use SilverStripe\SiteConfig\SiteConfig;
use SilverStripe\Security\Member;
use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;
use SilverStripe\ORM\ArrayList;

use SilverStripe\View\ArrayData;
use SilverStripe\Security\MemberPassword;

    class PageController extends ContentController
    {
        /**
         * An array of actions that can be accessed via a request. Each array element should be an action name, and the
         * permissions or conditions required to allow the user to access it.
         *
         * <code>
         * [
         *     'action', // anyone can access this action
         *     'action' => true, // same as above
         *     'action' => 'ADMIN', // you must have ADMIN permissions to access this action
         *     'action' => '->checkAction' // you can only access this action if $this->checkAction() returns true
         * ];
         * </code>
         *
         * @var array
         */
        private static $allowed_actions = [];

        protected function init()
        {
            parent::init();
            // $member = Member::currentUser();
            // $from = SiteConfig::current_site_config()->EmailInfo;
            // $subject = "Registrasi Berhasil";
            // $to = "reynald.gresik@gmail.com";
            // $body = "Terimakasih untuk mendaftar pada Peransaka Jawa Timur, 
            // silahkan lakukan validasi email dengan menekan link dibawah <br>";
            // CT::sendmail($from, $subject, $to, $body, $member);
            // die("mail");
            //check login state;
            // make feed
            // DB::query("truncate table FeedData");
            // $member = MemberData::get()->limit(10);
            // $sc =  SiteConfig::current_site_config();
            // $arrImage = [$sc->WebLogo(), $sc->DefaultPhotoMember(), $sc->DefaultPhoto(), $sc->ImageOnLoginPage()];
            // $indexPost = 1;
            // foreach($member as $m){
            //     $randIndexImage = rand(2, 4);
            //     $newFeed = new FeedData();
            //     $newFeed->MemberDataID = $m->ID;
            //     $newFeed->Content = "Post ke-$indexPost Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500";
            //     $newFeed->write();
            //     $indexPost ++;
            // }
            // die("success");

            // foreach (FeedData::get() as $f){
            //     foreach ($f->Image() as $img){
            //         $f->Image()->remove($img);
            //     }
            // }
        }

        public function MemberWarning(){
            $member = Member::currentUser();
            if (!$member){
                return null;
            }
            $res = new ArrayList();
            
            //check password
            $pwdlog = MemberPassword::get()->filter(['MemberID'=>$member->ID]);        
            $pwdlog = $pwdlog->count();
            if ($member->NoNeedChangePassword){
                return null;
            }
            if ($pwdlog <= 1){
                $url = Director::absoluteBaseURL()."member/edit";
                $res->push(['Title'=>"Harap untuk ganti password anda <a href='$url'>disini</a>"]);
                return $res;
            }else{
                return null;
            }
        }

        public function getResourceV(){
            return date("Ymdhis");
        }

        public function getUpcommingEvent($limit = 5){
            $data = DataObject::get("EventData", "Mulai > '".date("Y-m-d H:i:s")."'"
            ,"Mulai Desc","", "$limit");
            return $data;
        }

        public function getRecentEvent($limit = 5){
            $data = DataObject::get("EventData", ""
            ,"Mulai Desc","", "$limit");
            return $data;
        }

        public function getRandomMember($limit = 5){
            $member = Member::currentUser();
            return DataObject::get("MemberData", "Status = 1 AND MemberData.ID != '".$member->ID."'", "RAND()","", "$limit");
        }

        public function getSaka(){
            return SakaData::get();
        }

        public function getGolongan(){
            return GolonganData::get();
        }

        public function getKabupaten(){
            return KabupatenData::get();
        }

        public function getKabupatenJatim(){
            return KabupatenData::get()->filter(['ProvinsiDataID'=>ProvinsiData::getJatim()->ID])->sort("Title", "ASC");
        }

        public function getKecamatanbyKab($kabID){
            return KecamatanData::get()->filter(['KabupatenDataID'=>$kabID])->sort("Title", "ASC");
        }

        public function getSosmedCategoryData(){
            return SosmedCategoryData::get();
        }

        public function getKategoriEventData(){
            return KategoriEventData::get();
        }

        public function getArrSex(){
            $arrKelamin = [
                'L'=>'Laki - Laki',
                'P'=>'Perempuan'
            ];
            $data = new ArrayList();
            foreach($arrKelamin as $k=>$ak){
                $data->push(['Sex'=>$k, 'Title'=>$ak]);
            }
            return $data;
        }

        public function getArrAgama(){
            $arrAgama = [
                'Islam' => 'Islam',
                'Kristen' => 'Kristen',
                'Protestan' => 'Protestan',
                'Katolik' => 'Katolik',
                'Hindu' => 'Hindu',
                'Buddha' => 'Buddha',
                'Khonghucu' => 'Khonghucu'
            ];
            $data = new ArrayList();
            foreach($arrAgama as $k=>$ak){
                $data->push(['Agama'=>$k, 'Title'=>$ak]);
            }
            return $data;
        }

        public function getReasonReport(){
            return ReportReasonData::get();
        }

        public function numberNotif(){
            $member = Member::currentUser();
            if (!$member){
                return 0;
            }else{
                return NotificationData::get()->filter(['OwnerNotifID'=>$member->ID, 'hasSeen'=>'0'])->count();
            }
        }

        public function getNotif($limit = 4){
            $member = Member::currentUser();
            if (!$member){
                return null;
            }else{
                return NotificationData::get()->filter(['OwnerNotifID'=>$member->ID, 'hasSeen'=>'0'])->sort('Created', 'Desc')->limit($limit);
            }
        }

    }
}
