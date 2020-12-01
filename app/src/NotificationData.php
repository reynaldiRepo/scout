<?php

use SilverStripe\Control\Director;
use SilverStripe\Security\Member;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;

class NotificationData extends DataObject{
    private static $has_one = [
        'OwnerNotif' => MemberData::class,
        'MemberOnNotif' => MemberData::class
    ];

    private static $db = [
        'Content' => 'Varchar(255)',
        'TypeActivity' => 'Int',
        'IdTarget' => 'Int',
        'ClassTarget' => 'Varchar(255)',
        'hasSeen' => 'Boolean'
    ];

    private static $typeActivity = [
        1=>'CommentOnEvent',
        2=>'CommentOnFeed',
        3=>'CommentOnComment',
    ];

    public static function writenotif($type, $data ,$memberTarget = null){
        $member = Member::currentUser();
        $res = false;
        $newNotif = new NotificationData();
        switch ($type) {
            case 1: //coooemntOnEvent
                $newNotif->TypeActivity = 1;
                $newNotif->OwnerNotifID = $memberTarget->ID;
                $newNotif->MemberOnNotifID = $member->ID;
                $newNotif->ClassTarget = $data->ClassName;
                $newNotif->IdTarget = $data->ID;
                $newNotif->Content = $memberTarget->FirstName.' memberikan komentar "'.substr($data->Content,0, 25).'..." 
                                    Pada Event <b>'.substr($data->EventData->Title ,0, 25)."</b>.. yang anda ikuti";
                $newNotif->hasSeen = "0";
                if ($newNotif->write()){
                    $res = true;
                }else{
                    $res = false;
                }
                break;
            case 2: //Comment On Feed
                $newNotif->TypeActivity = 2;
                $newNotif->OwnerNotifID = $memberTarget->ID;
                $newNotif->MemberOnNotifID = $member->ID;
                $newNotif->ClassTarget = $data->ClassName;
                $newNotif->IdTarget = $data->ID;
                $newNotif->Content = $memberTarget->FirstName.' memberikan komentar "'.substr($data->Content,0, 25).'..." 
                                    Pada Postingan Feed Anda';
                $newNotif->hasSeen = "0";
                if ($newNotif->write()){
                    $res = true;
                }else{
                    $res = false;
                }
                break;
            case 3: //Comment On Feed
                $newNotif->TypeActivity = 3;
                $newNotif->OwnerNotifID = $memberTarget->ID;
                $newNotif->MemberOnNotifID = $member->ID;
                $newNotif->ClassTarget = $data->ClassName;
                $newNotif->IdTarget = $data->ID;
                $newNotif->Content = $memberTarget->FirstName.' memberikan komentar "'.substr($data->Content,0, 25).'..." 
                                    Pada komentar anda yang berada di Feed '.$data->CommentFeedData()->FeedData()->MemberData()->FirstName;
                $newNotif->hasSeen = "0";
                if ($newNotif->write()){
                    $res = true;
                }else{
                    $res = false;
                }
                break;
            default:
                # code...
                break;
        }
        return $res;
    }

    public function getLinkToSee(){
        switch ($this->TypeActivity) {
            case 1:
                //comment one level on event
                $comment = CommentEventData::get()->byID($this->IdTarget);
                $data = DB::query("SELECT (ROW_NUMBER() OVER (Order by Created DESC) ) as 'ROW', Created, ID  FROM CommentEventData WHERE EventDataID = '".$comment->EventDataID."'");
                if (!$data){
                    return "/Not-Found";
                }
                $find = null;
                foreach($data as $d){
                    if ($d['ID'] == $this->IdTarget){
                        $find = $d;
                        break;
                    }
                }
                $startPage = floor($find['ROW'] / CT::$PageSize);
                $link =  "event/v/".$comment->EventData()->ID.$comment->EventData()->getURLSegment()."?Start=$startPage";
                return $link;

            case 3:
                $comment = CommentEventData::get()->byID($this->IdTarget);
                $data = DB::query("SELECT (ROW_NUMBER() OVER (Order by Created DESC) ) as 'ROW', Created, ID  FROM CommentFeedData WHERE FeedDataID = '".$comment->EventDataID."'");
                var_dump($data);
                die();
            default:
                break;
        }
    }


    /**
     * DataObject create permissions
     * @param Member $member
     * @param array $context Additional context-specific data which might
     * affect whether (or where) this object could be created.
     * @return boolean
     */
    public function canCreate($member = null, $context = [])
    {
        return false;
    }

    /**
     * DataObject edit permissions
     * @param Member $member
     * @return boolean
     */
    public function canEdit($member = null)
    {
        return false;
    }
}