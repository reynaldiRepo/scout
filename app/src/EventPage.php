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

class EventPage extends Page {
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeByName([
            'Content'
        ]);
        return $fields;
    }
}

class EventPageController extends PageController
{

    

    private static $allowed_actions = [
        'index',
        'v',
        'join',
        'unjoin',
        'addcomment',
        'deletecomment'
    ];

    protected function init()
    {
        parent::init();
        $member = Member::currentUser();
        if (!$member){
            $this->redirect("member/login");
            return;
        }
        $adminCabangGroup = CT::getGroupID("admin-cabang");
        $admin = CT::getGroupID("administrators");
        if ($member->inGroup($admin->ID) || $member->inGroup($adminCabangGroup->ID)){
            $this->redirect("admin");
            return;
        }
    }

    public function arrSoort(){
        $res = new ArrayList();
        $arr = [
            'Created-DESC'=>'Terbaru',
            'Created-ASC'=>'Terlama',
            'Title-ASC'=>'A - Z',
            'Title-DESC'=>'Z - A',
        ];
        foreach($arr as $k=>$v){
            $res->push(['q'=>$k, 'Title'=>$v]);
        }
        return $res;
    }

    public function index(HTTPRequest $request){
        $member = Member::currentUser();
        if (!$member){
            $this->redirect("member/login");
            return;
        }

        $arrayFilter = [];
        $sort = "Created-DESC";
        if (!empty($_GET)) {
            if (isset($_GET['SakaDataID'])) {
                if (!empty($_GET['SakaDataID'])) {
                    $arrayFilter['SakaDataID'] = $_GET['SakaDataID'];
                }
            }
            if (isset($_GET['KategoriEventDataID'])) {
                if (!empty($_GET['KategoriEventDataID'])) {
                    $arrayFilter['KategoriEventDataID'] = $_GET['KategoriEventDataID'];
                }
            }
            if (isset($_GET['Title'])) {
                if (!empty($_GET['Title'])) {
                    $arrayFilter['Title:PartialMatch'] = $_GET['Title'];
                }
            }
        }

        if (!empty($arrayFilter)){
            $Event = EventData::get()->filter($arrayFilter);
            foreach($arrayFilter as $k=>$v){
                if ($k != "Title:PartialMatch") {
                    $data[$k] = $v;
                }else{
                    $data['TitleSearch'] = $v;
                }
            }
        }else{
            $Event = EventData::get();
        }


        $arrSort = [
            'Created-DESC'=>'Terbaru',
            'Created-ASC'=>'Terlama',
            'Title-ASC'=>'A - Z',
            'Title-DESC'=>'Z - A',
        ];
        if (isset($_GET['Sort'])) {
            if (!empty($_GET['Sort']) && isset($arrSort[$_GET['Sort']])) {
                $sort = $_GET['Sort'];
            }
        }
        $sort = explode("-", $sort);
        $Event = $Event->sort($sort[0], $sort[1]);
        $Event = new PaginatedList($Event, $this->getRequest());
        $Event->setPageLength(4);
        $data['Events'] = $Event;
        $sort = implode("-", $sort);
        $data['Sort'] = $sort;
        $data['Title'] = "Event Peransaka";
        return $this->customise($data)->renderWith(array('CleanPage', 'EventPage'));
    }

    public function v(){
        $member = Member::currentUser();
        if (!$member){
            $this->redirect("member/login");
            return;
        }
        if (!$this->getRequest()->param('ID')){
            die("404/ not found");
            return;
        }
        $id = $this->getRequest()->param('ID');
        $id = explode("-", $id);
        $id = $id[0];
        $Event = EventData::get()->byID($id);
        if ($Event){
            $data['Title'] = $Event->Title;
            $data['Event'] = $Event;
            $Comment = new PaginatedList($Event->CommentEventData()->sort("Created", "DESC"), $this->getRequest());
            $Comment->setPageLength(CT::$PageSize);
            $data['Comments'] = $Comment;
        }else{
            die("404/ not found");
            return;
        }
        return $this->customise($data)->renderWith(array('CleanPage', 'EventPage_v'));
    }

    public function join(){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'session expired, please login again']);
            return;
        }

        if (!isset($_GET['id'])){
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }

        $event = EventData::get()->byID($_GET['id']);
        if ($event){
            $event->MemberData()->add($member);
            echo json_encode(['status'=>200, 'msg'=>'Registrasi event success']);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
    }

    public function unjoin(){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'session expired, please login again']);
            return;
        }

        if (!isset($_GET['id'])){
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }

        $event = EventData::get()->byID($_GET['id']);
        if ($event){
            $event->MemberData()->remove($member);
            echo json_encode(['status'=>200, 'msg'=>'Unregistrasi event success']);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
    }

    // 'addcomment',
    // 'deletecomment'

    public function addcomment($data){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'session expired, please login again']);
            return;
        }

        if (!isset($_GET['id'])){
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
        // id  =  id event
        $event = EventData::get()->byID($_GET['id']);
        if ($event){
            $newComment = new CommentEventData();
            $newComment->update($_POST);
            $newComment->MemberDataID = $member->ID;
            $newComment->write();
            $event->CommentEventData()->add($newComment);
            foreach ($event->MemberData() as $m){
                if ($m->ID != $member->ID) {
                    $newNotif = NotificationData::writenotif(1, $newComment, $m);
                }
            }
            echo json_encode(['status'=>200, 'msg'=>'Add Comment Success']);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }

        
    }


    public function deletecomment($data){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'session expired, please login again']);
            return;
        }

        if (!isset($_GET['idevent']) || !isset($_GET['idcomment'])){
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
        
        $event = EventData::get()->byID($_GET['idevent']);
        $comment = CommentEventData::get()->byID($_GET['idcomment']);
        if ($event && $comment){
            $event->CommentEventData()->remove($comment);
            echo json_encode(['status'=>200, 'msg'=>'Delete Comment Success']);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }

        
    }
}