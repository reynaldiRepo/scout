<?php

namespace {

use SilverStripe\SiteConfig\SiteConfig;
use SilverStripe\Security\Member;
use SilverStripe\CMS\Controllers\ContentController;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;
use SilverStripe\ORM\ArrayList;

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
    }
}
