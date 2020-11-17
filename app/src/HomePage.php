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
    ];

    protected function init()
    {
        parent::init();
        $member = Member::currentUser();
        if (!$member){
            $this->redirect("member/login");
        }
    }

    public function index(HTTPRequest $request){
        $data['Title'] = "Homepage";
        $pages = new PaginatedList(EventData::get(), $this->getRequest());
        $pages->setPageLength(2);
        $data['Events'] = $pages;
        return $data;
    }

    
}