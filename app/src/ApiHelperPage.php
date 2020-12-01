<?php
use SilverStripe\Control\Director;
use SilverStripe\Security\Member;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\Control\HTTPResponse_Exception;
use SilverStripe\Assets\Upload;
use SilverStripe\ORM\PaginatedList;

class ApiHelperPage extends Page{
    
}

class ApiHelperPageController extends PageController{
    /**
     * Defines methods that can be called directly
     * @var array
     */
    private static $allowed_actions = [
        'getProvinsi' => true,
        'getKabupaten' => true,
        'getKecamatan' => true,
        'uploadimage',
        'deleteimage',

        //for feed
        'getfeed' => true,
        'getfeedmember' => true,
        'likefeed' => true,

        //for report
        'doreport',

        // for notif
        'seenotif',

    ];

    
    private static $url_handlers = [
        'getfeedmember/$ID'
    ];
    
    function index(HTTPRequest $request){
        die("/404- Not Allowed");
    }

    function getProvinsi(){
        $prov = ProvinsiData::get()->sort("Title", "ASC");
        $res = [];
        foreach($prov as $p){
            array_push($res, $p->toJsonArray());
        }
        echo json_encode($res);
        return; 
    }

    function getKabupaten(){
        $idprov = isset($_GET['idprov']) ? $_GET['idprov'] : null;
        if ($idprov != null){
            $prov = KabupatenData::get()->filter(["ProvinsiDataID"=>$idprov])->sort("Title", "ASC");
        }else{
            $prov = KabupatenData::get()->sort("Title", "ASC");
        }
        $res = [];
        foreach($prov as $p){
            array_push($res, $p->toJsonArray());
        }
        echo json_encode($res);
        return; 
    }

    function getKecamatan(){
        $idkab = isset($_GET['idkab']) ? $_GET['idkab'] : null;
        if ($idkab != null){
            $prov = KecamatanData::get()->filter(["KabupatenDataID"=>$idkab])->sort("Title", "ASC");
        }else{
            $prov = KecamatanData::get()->sort("Title", "ASC");
        }
        $res = [];
        foreach($prov as $p){
            array_push($res, $p->toJsonArray());
        }
        echo json_encode($res);
        return; 
    }

    public function uploadimage($data){
        $newImage = CustomImage::create();
        $upl = new Upload();
        $upl->loadIntoFile($data['Image'], $newImage, "/Uploads");
        if ($newImage->ID != 0){
            echo json_encode(['status'=>200, 'msg'=>'Upload Success', 'ID'=>$newImage->ID, 'FileName'=>"Upload Success", 'URL'=>$newImage->URL]);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Upload Failed']);
            return;
        }
    }


    public function deleteimage(){
        if (!isset($_GET['id'])){
            echo json_encode(['status'=>500, 'msg'=>'Error Data Not found']);
            return;
        }

        $image = CustomImage::get()->byID($_GET['id']);
        if ($image){
            $image->delete();
            echo json_encode(['status'=>200, 'msg'=>'Delete Success']);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Error Data Not found']);
            return;
        }
    }

    public function getfeed(){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'Session Expired']);
            return;
        }
        if (!isset($_GET['start'])){
            echo json_encode(['status'=>500, 'msg'=>'start Required']);
            return;
        }
        if (!isset($_GET['count'])){
            echo json_encode(['status'=>500, 'msg'=>'count Required']);
            return;
        }

        $start = $_GET['start'];
        $count = $_GET['count'];
        
        $feed = DataObject::get("FeedData", "isHide='0'","ID Desc","", "$start, $count");
        // var_dump("a");
        if ($feed->count() == 0){
            echo json_encode(['status'=>417, 'msg'=>'End Of Data']);
            return;
        }

        $result = [];
        foreach($feed as $f){
            array_push($result, $f->toJsonArray());
        }
        
        echo json_encode(['status'=>200, 'msg'=>'OK', 'data'=>json_encode($result)]);
        return;
    }

    public function getfeedmember(){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'Session Expired']);
            return;
        }
        if (!isset($_GET['start'])){
            echo json_encode(['status'=>500, 'msg'=>'start Required']);
            return;
        }
        if (!isset($_GET['count'])){
            echo json_encode(['status'=>500, 'msg'=>'count Required']);
            return;
        }

        $start = $_GET['start'];
        $count = $_GET['count'];

        $data['urlstate'] = Director::absoluteBaseURL()."member/feed/";
        $data['urlfetch'] = Director::absoluteBaseURL()."api-helper/getfeedmember/".$member->ID;

        if ($this->getRequest()->param('ID') !== null) {
            $id = $this->getRequest()->param('ID');
            $membertoget =  MemberData::get()->byID($id);
        }else{
            if (!isset($_GET['count'])){
                echo json_encode(['status'=>500, 'msg'=>'No data']);
                return;
            }
        }
        
        $feed = DataObject::get("FeedData", "MemberDataID = '$id' and isHide='0'","ID Desc","", "$start, $count");
        // var_dump("a");
        if ($feed->count() == 0){
            echo json_encode(['status'=>417, 'msg'=>'End Of Data']);
            return;
        }

        $result = [];
        foreach($feed as $f){
            array_push($result, $f->toJsonArray());
        }
        
        echo json_encode(['status'=>200, 'msg'=>'OK', 'data'=>json_encode($result)]);
        return;
    }

    public function likefeed(){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'Session Expired']);
            return;
        }
        if (!isset($_GET['FeedDataID'])){
            echo json_encode(['status'=>500, 'msg'=>'FeedDataID Required']);
            return;
        }

        $feedID = $_GET['FeedDataID'];

        // check if user has been like post
        $like = LikeData::get()->filter(['MemberDataID'=>$member->ID, 'FeedDataID'=>$feedID]);
        if ($like->count() != 0){
            $like->first()->delete();
            echo json_encode(['status'=>205, 'msg'=>'Delete Success']);
            return;
        }else{
            $newLike = new LikeData();
            $newLike->MemberDataID = $member->ID;
            $newLike->FeedDataID = $feedID;
            $newLike->write();
            if ($newLike->ID == 0){
                echo json_encode(['status'=>500, 'msg'=>'Something Wrong']);
                return;    
            }
            echo json_encode(['status'=>200, 'msg'=>'Like Success']);
            return;
        }
    }

    public function doreport($data){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'Session Expired']);
            return;
        }
        if (!isset($_GET['id'])){
            echo json_encode(['status'=>500, 'msg'=>'id Required']);
            return;
        }

        $feed = FeedData::get()->byID($_GET['id']);
        if (!$feed){
            echo json_encode(['status'=>500, 'msg'=>'No data !']);
            return;
        }
        $newReport = new ReportData();
        $newReport->update($_POST);
        $newReport->FeedDataID = $feed->ID;
        $newReport->MemberDataID = $member->ID;
        $new = $newReport->write();
        if ($new){
            echo json_encode(['status'=>200, 'msg'=>'Terimkasih sudah mengirim report anda, kami akan mempelajari apa yang sedang terjadi']);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong']);
            return;
        }   
    }

    public function seenotif(){
        $member = Member::currentUser();
        if (!$member){
            return $this->redirect("member/login");
            
        }
        if (!isset($_GET['ID'])){
            die("404/ Not Found");
            return;
        }
        
        $ID = $_GET['ID'];
        $notif = NotificationData::get()->byID($ID);
        if (!$notif){
            die("404/ Not Found");
        }
        $link = $notif->getLinkToSee();
        return $this->redirect($link);
    }

}