<?php 

use SilverStripe\Security\Member;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\HTTPResponse;
use SilverStripe\Control\HTTPResponse_Exception;
use SilverStripe\Assets\Upload;
use SilverStripe\ORM\PaginatedList;

class FeedDataPage extends Page{

}

class FeedDataPageController extends PageController
{

    private static $allowed_actions = [
        'comment' => true,
        'addcomment',
        'deletecomment'
    ];

    public function index(HTTPRequest $request){
        die("404/ not allowed");
    }

    // @become iframe
    public function comment(){
        $member = Member::currentUser();
        $data = [];
        if (!isset($_GET['FeedDataID'])){
            return $this->customise($data)->renderWith(array('CleanPageNoHeader' ,'nocomment'));
        }
        if (!$member){
            return $this->customise($data)->renderWith(array('CleanPageNoHeader' ,'nocomment'));
        }
        $feedID = $_GET['FeedDataID'];
        $Feed = FeedData::get()->byID($feedID);
        $data['FeedDataID'] = $feedID;
        $Comment = new PaginatedList($Feed->CommentFeedData()->sort("Created", "DESC"), $this->getRequest());
        $Comment->setPageLength(10);
        $data['Comment'] = $Comment;

        return $this->customise($data)->renderWith(array('CleanPageNoHeader' ,'comment'));
    }

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
        // id  =  id Feed
        $Feed = FeedData::get()->byID($_GET['id']);
        if ($Feed){
            $newComment = new CommentFeedData();
            $newComment->update($_POST);
            $newComment->MemberDataID = $member->ID;
            $newComment->write();
            $Feed->CommentFeedData()->add($newComment);
            echo json_encode(['status'=>200, 'msg'=>'Add Comment Success']);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
    }

    public function deletecomment(){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'session expired, please login again']);
            return;
        }

        if (!isset($_GET['FeedDataID']) || !isset($_GET['ID'])){
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
        
        $Feed = FeedData::get()->byID($_GET['FeedDataID']);
        $comment = CommentFeedData::get()->byID($_GET['ID']);
        if ($Feed && $comment){
            $Feed->CommentFeedData()->remove($comment);
            echo json_encode(['status'=>200, 'msg'=>'Delete Comment Success']);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
    }

}