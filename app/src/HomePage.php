<?php 

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\Control\HTTPResponse_Exception;

use SilverStripe\Security\Member;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;
use SilverStripe\ORM\PaginatedList;



class HomePage extends Page{

    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeByName([
            'Content'
        ]);
        return $fields;
    }
} 

class HomePageController extends PageController{
    private static $allowed_actions = [
        'index',
        'dashboard',
        'feed',
        'hidemsg'
    ];

    
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

    public function index(HTTPRequest $request){
        $data['Title'] = "Selamat Datang di peransaka";
        return $this->customise($data)->renderWith(array('Peransaka'));
    }

    public function dashboard(){
        $member = Member::currentUser();
        if (!$member){
            $this->redirect("member/login");
        }
        $data['Title'] = "Peransaka Home";
        $pages = new PaginatedList(EventData::get(), $this->getRequest());
        $pages->setPageLength(5);
        $data['Events'] = $pages;
        return $data;
    }

    public function feed(){
        $member = Member::currentUser();
        if (!$member){
            $this->redirect("member/login");
        }

        $start = isset($_GET['Start']) ? $_GET['Start'] : 0;
        $count = isset($_GET['Count']) ? $_GET['Count'] : 10;
        // var_dump($start, $count);
        // die();
        $data['Title'] = "Feed Anggota Peransaka";
        $Feed = DataObject::get("FeedData", "isHide = '0' ","ID Desc","", "$start, $count");
        $data['Feed'] = $Feed;

        //check future page for 3 ajax load
        if ($count != 10){
            $data['startPage'] = $count;    
        }
        $data['startPage'] = $start  + $count;
        return $data;
    }

    public function getYear(){
        return date("Y");
    }

    public function hidemsg(){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'Session expired please login']);
            return;       
        }
        $member->HideWelcome = "1";
        $member->write();
        echo json_encode(['status'=>500, 'msg'=>'Good']);
        return;       
    }

    
}