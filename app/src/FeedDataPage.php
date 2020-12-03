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

class FeedDataPage extends Page{

}

class FeedDataPageController extends PageController
{

    private static $allowed_actions = [
        'comment' => true,
        'commentreply',
        'addcomment',
        'addcommentreply',
        'deletecomment',
        'updatenumcomment',
        'numreplycomment',
        'post',
        'deletefeed'
    ];

    private static $url_handlers = [
        'post/$ID'=>'post',
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
        $Count = isset($_GET['Count']) ? $_GET['Count'] : CT::$PageSize; 
        $Comment = DataObject::get("CommentFeedData", "FeedDataID = '$feedID'", "", "","0,$Count");
        $data['Comment'] = $Comment;
        $data['FeedDataID'] = $feedID;
        
        
        //check for load more;
        $countAll = DataObject::get("CommentFeedData", "FeedDataID = '$feedID'", "", "","")->count();
        if ($countAll > $Count){
            $count = $Count+CT::$PageSize;
            $data['LoadMore'] = Director::absoluteBaseURL()."feed/comment?FeedDataID=$feedID&Count=$count";
        }

        return $this->customise($data)->renderWith(array('CleanPageNoHeader' ,'comment'));
    }

    public function commentreply(){
        $member = Member::currentUser();
        $data = [];
        if (!isset($_GET['CommentFeedDataID'])){
            return $this->customise($data)->renderWith(array('CleanPageNoHeader' ,'nocomment'));
        }
        if (!$member){
            return $this->customise($data)->renderWith(array('CleanPageNoHeader' ,'nocomment'));
        }

        $CommentParent = CommentFeedData::get()->byID($_GET['CommentFeedDataID']);
        $CommentParentID = $_GET['CommentFeedDataID'];
        $data['CommentParent'] = $CommentParent;

        $Count = isset($_GET['Count']) ? $_GET['Count'] : CT::$PageSize; 
        $Comment = DataObject::get("CommentFeedData", "CommentFeedDataID = '$CommentParentID'", "", "","0,$Count");

        $data['Comment'] = $Comment;
        //check for load more;
        $countAll = DataObject::get("CommentFeedData", "CommentFeedDataID = '$CommentParentID'", "", "","")->count();
        if ($countAll > $Count){
            $count = $Count+CT::$PageSize;
            $data['LoadMore'] = Director::absoluteBaseURL()."feed/commentreply?CommentFeedDataID=$CommentParentID&Count=$count";
        }
        
        return $this->customise($data)->renderWith(array('CleanPageNoHeader' ,'replycomment'));
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
            $newNotif = NotificationData::writenotif(2, $newComment, $Feed->MemberData());
            echo json_encode(['status'=>200, 'msg'=>'Add Comment Success']);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
    }

    public function addcommentreply($data){
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
        $CommentFeed = CommentFeedData::get()->byID($_GET['id']);
        if ($CommentFeed){
            $newComment = new CommentFeedData();
            $newComment->update($_POST);
            $newComment->MemberDataID = $member->ID;
            $newComment->CommentFeedDataID = $CommentFeed->ID;
            $newComment->write();
            
            //for get user to send notif
            $users = [];
            foreach (CommentFeedData::get()->filter([CommentFeedDataID => $CommentFeed->ID]) as $c){
                if ($c->MemberDataID != $member->ID) {
                    $users[$c->MemberDataID] = $c->MemberData();
                }
            }
            $users[$CommentFeed->MemberDataID] = $CommentFeed->MemberData();
            $users[$CommentFeed->FeedData()->MemberDataID] = $CommentFeed->FeedData()->MemberData();
            foreach($users as $k=>$v){
                if ($k == $CommentFeed->FeedData()->MemberDataID){
                    $newNotif = NotificationData::writenotif(2, $newComment, $v);
                }
                if ($member->ID != $k && $k != $CommentFeed->FeedData()->MemberDataID) {
                    $newNotif = NotificationData::writenotif(3, $newComment, $v);
                }
            }
            //==================================
            
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
            $comment->delete();
            echo json_encode(['status'=>200, 'msg'=>'Delete Comment Success']);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
    }

    public function updatenumcomment(){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'session expired, please login again']);
            return;
        }
        if (!isset($_GET['id'])){
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
        $id = $_GET['id'];
        $Feed = FeedData::get()->byID($id);
        if (!$Feed) {
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
        echo json_encode(['status'=>200, 'msg'=>'OK', 'data'=>$Feed->CountComment()]);
        return;
    }

    public function numreplycomment(){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'session expired, please login again']);
            return;
        }
        if (!isset($_GET['id'])){
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
        $id = $_GET['id'];
        $CommentFeed = CommentFeedData::get()->byID($id);
        if (!$CommentFeed) {
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
        echo json_encode(['status'=>200, 'msg'=>'OK', 'data'=>$CommentFeed->CountComment()]);
        return;
    }

    public function post(){
        $member = Member::currentUser();
        if (!$member){
            return $this->redirect('member/login');
        }
        if (!$this->getRequest()->param('ID')){
            die("404/ not found");
            return;
        }

        $id = $this->getRequest()->param('ID');
        $feed = FeedData::get()->byID($id);
        if (!$feed){
            die("404/ not found");
            return;
        }

        $data['Feed'] = $feed;
        $data['Count'] = isset($_GET['Count']) ? $_GET['Count'] : null;
        $data['CountChild'] = isset($_GET['CountChild']) ? $_GET['CountChild'] : null;
        return $this->customise($data)->renderWith(array('CleanPage', 'FeedDetail'));
    }

    public function deletefeed(){
        $member = Member::currentUser();
        if (!$member){
            echo json_encode(['status'=>500, 'msg'=>'session expired, please login again']);
            return;
        }
        if (!isset($_GET['id'])){
            echo json_encode(['status'=>500, 'msg'=>'Something Wrong, No Data !']);
            return;
        }
        $id = $_GET['id'];
        $Feed = FeedData::get()->byID($id);
        if ($Feed){
            $Feed->delete();
            echo json_encode(['status'=>200, 'msg'=>'Delelte Success']);
            return;
        }else{
            echo json_encode(['status'=>500, 'msg'=>'Delelte Failed, data has not found']);
            return;
        }
    }

}