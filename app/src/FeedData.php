<?php

use SilverStripe\Control\Director;
use SilverStripe\SiteConfig\SiteConfig;
use SilverStripe\Security\Member;
use SilverStripe\Forms\GridField\GridFieldConfig_RelationEditor;
use SilverStripe\Forms\LabelField;
use SilverStripe\Forms\NumericField_Readonly;
use SilverStripe\Forms\ReadonlyField;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\TextareaField;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Forms\HTMLEditor\HtmlEditorField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TabSet;
use SilverStripe\ORM\DataObject;
use SilverStripe\Forms\GridField\GridFieldAddNewButton;
use SilverStripe\Forms\GridField\GridFieldExportButton;
use SilverStripe\Forms\GridField\GridFieldPrintButton;
use SilverStripe\Forms\RequiredFields;

class FeedData extends DataObject{
    /**
     * Database fields
     * @var array
     */
    private static $db = [
        'Content' => 'HTMLText',
    ];

    private static $has_one = [
        'MemberData' => MemberData::class,
    ];

    private static $has_many = [
        'Image' => CustomImage::class,
        'CommentFeedData' => CommentFeedData::class,
        'LikeData' => LikeData::class
    ];

    private static $singular_name = 'Feed Anggota';
    private static $plural_name = 'List Feed Anggota';

    private static $summary_fields = [
        'Created' => 'Date Post',
        'MemberData.FirstName' => 'User',
        'Content',
        'CountLike' => 'Like',
        'CountComment' => 'Comment'
    ];

    public function CountLike(){
        return $this->LikeData()->count();
    }

    public function CountComment(){
        return $this->CommentFeedData()->count();
    }

    public function toJsonArray(){
        $res = [];
        $date = DateTime::createFromFormat("Y-m-d H:i:s", $this->Created);

        $res['ID'] = $this->ID;
        $res['Content'] = $this->Content;
        $res['Created'] = $date->format("Y-m-d H:i");
        $res['MemberData'] = $this->MemberData()->toJsonArrayMin();
        $res['CountLike'] = $this->CountLike();
        $res['CountComment'] = $this->CountComment();
        $res['cardAdda'] = $this->renderCardThemeAdda();
        return $res;
    }

    public function Link(){
        return Director::absoluteBaseURL()."member/post/".$this->ID;
    }

    public function canCreate($member = null, $context = [])
    {
        return false;
    }

    public function canEdit($member = null)
    {
        return false;
    }

    public function isLike(){
        $member = Member::currentUser();
        $like = LikeData::get()->filter(['MemberDataID'=>$member->ID, 'FeedDataID'=>$this->ID]);
        if ($like->count() != 0){
            return true;
        }else{
            return false;
        }
    }


    public function renderCardThemeAdda(){
        $date = DateTime::createFromFormat("Y-m-d H:i:s", $this->Created);
        $member = Member::currentUser();

        $settingbar = "";
        if ($member->ID == $this->MemberData()->ID){
            $settingbar = '<li><button class="delete=feed-btn" data-id="'.$this->ID.'">Delete</button></li>';
        }

        $profileHtml = '<div class="card">
            <div class="post-title d-flex align-items-center">
                <div class="profile-thumb">
                    <a href="'.$this->MemberData()->Link().'">
                        <figure class="profile-thumb-middle">
                            <img src="'.$this->MemberData()->getPhotoProfileThumb()->URL.'" alt="profile picture">
                        </figure>
                    </a>
                </div>
                <div class="posted-author">
                    <h6 class="author"><a href="'.$this->MemberData()->Link().'">'.$this->MemberData()->FirstName.' '.$this->MemberData()->Surname.' </a></h6>
                    <span class="post-time"><i class="fa fa-calendar mr-1"></i> '.$date->format("d-m-y").'
                    <i class="fa fa-clock-o mr-1 ml-1"></i> '.$date->format("H:i").'</span>
                </div>
                <div class="post-settings-bar">
                    <span></span>
                    <span></span>
                    <span></span>
                    <div class="post-settings arrow-shape">
                        <ul>
                            <li><button class="report-btn" data-id="'.$this->ID.'">Report</button></li>
                            '.$settingbar.'
                        </ul>
                    </div>
                </div>
            </div>';
            
            $posHtml = '<div class="post-content">
                <p class="post-desc">
                    '.$this->Content.'
                </p>';

            if ($this->Image()->count() == 0){
                $ImageHtml = "";
            }
            if ($this->Image()->count() == 1) {
                $img = $this->Image()->first();
                $ImageHtml = '<div class="post-thumb-gallery">
                                <figure class="post-thumb img-popup-'.$this->ID.' bg-dark">
                                    <a href="'.$img->URL.'">
                                        <img src="'.$img->Fill(320, 270)->URL.'" alt="Posted by '.$this->MemberData()->FirstName.'">
                                    </a>
                                </figure>
                                </div>
                                <script> $(".img-popup-'.$this->ID.'").lightGallery(); </script>';
            }

            if ($this->Image()->count() > 1){
                    $imageAll = "";
                    foreach($this->Image() as $img){
                        $imageAll .= '<div class="p-0 p-1" data-src="'.$img->URL.'">
                                <div class="post-thumb-gallery ">
                                    <figure class="post-thumb bg-dark">
                                        <a href="'.$img->URL.'">
                                            <img src="'.$img->Fill(320, 270)->URL.'" alt="Posted by '.$this->MemberData()->FirstName.'">
                                        </a>
                                    </figure>
                                </div>
                            </div>';
                        $ImageHtml = '<div class="row owl-carousel owl-theme img-popup-'.$this->ID.' text-center">
                                    '.$imageAll.'
                                    </div> <script> $(".img-popup-'.$this->ID.'").lightGallery();
                                    $(".img-popup-'.$this->ID.'").owlCarousel(window.configowl);
                                    </script>';
                    }
            }

            if ($this->isLike()) {
                $LikeHtml = '<button class="post-meta-like like-btn" data-ID="'.$this->ID.'" onclick="likefeed(this)">
                        <i class="fa fa-heart color-theme" id="icon-like-'.$this->ID.'"></i>
                        <span id="num-like-'.$this->ID.'">'.$this->LikeData()->count().'</span>
                    </button>';
            }else{
                $LikeHtml =  '<button class="post-meta-like like-btn" data-ID="'.$this->ID.'" onclick="likefeed(this)">
                    <i class="fa fa-heart-o color-theme" id="icon-like-'.$this->ID.'"></i>
                    <span id="num-like-'.$this->ID.'">'.$this->LikeData()->count().'</span>
                </button>';
            }

            $CommentHtml = '<ul class="comment-share-meta">
                    <li>
                        <button class="post-comment comment-btn" data-ID="'.$this->ID.'" data-frame-open="0"  onclick="togglecomment(this)">
                            <i class="bi bi-chat-bubble"></i>
                            <span id="num-comment-'.$this->ID.'">'.$this->CommentFeedData()->count().'</span>
                        </button>
                    </li>
                </ul>';
                    
            $postMeta = 
                    '<div class="post-meta">
                            '.$LikeHtml.'
                            '.$CommentHtml.'
                        </div>
                        </div>
                        <hr>
                        <div class="frame-content mt-2" id="comment-frame-'.$this->ID.'">
                        </div>
                    </div>';

            return $profileHtml." ".$posHtml." " .$ImageHtml." ".$postMeta;
    }


    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->removeByName([
            'MemberDataID'
        ]);
        $fields->addFieldToTab(
            'Root.Main',
            CustomDropdown::create('MemberDataID', 'Member', MemberData::get()->map("ID", "FirstName"))
        );

        $gridfield = GridField::create(
            'Image',
            'Image',
            $this->Image(),
            GridFieldConfig_RecordEditor::create()  
        );
        $fields->addFieldToTab(
            'Root.Image',
            $gridfield
        );
        return $fields;
    }
}