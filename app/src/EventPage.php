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
        'v'
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
        die("/404 - Future Update");
        return;
    }

    public function v(){
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
        }else{
            die("404/ not found");
            return;
        }
        return $this->customise($data)->renderWith(array('CleanPage', 'EventPage_v'));
    }
}