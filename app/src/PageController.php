<?php

namespace {

use SilverStripe\Security\Member;
    use SilverStripe\CMS\Controllers\ContentController;
    use SilverStripe\ORM\DataObject;
    use SilverStripe\ORM\DB;

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
            // var_dump($_SESSION);
            // die();
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

        public function getRandomMember($limit = 7){
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
    }
}
