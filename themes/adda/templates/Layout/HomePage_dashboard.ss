<div class="col-lg-6 order-1 order-lg-2">
    
    
    <div class="col-lg-12 pl-0 pr-0">
        <% if not $CurrentMember.HideWelcome %>
        <div class="alert alert-info mb-3" id="alert-welcome">
            <button type="button" class="close close-div" data-target ="#alert-welcome" data-process="1" title="Hide"
                data-url="{$BaseHref}home/hidemsg">
                <span aria-hidden="true">&times;</span>
            </button>
            $SiteConfig.WelcomeMsg.RAW
        </div>
        <% end_if %>
        <% if $MemberWarning %>
            <% loop $MemberWarning %>
            <div class="alert alert-warning" id ="alert-warning">
                <button type="button" class="close close-div" data-target ="#alert-warning" data-process="0" title="Hide">
                    <span aria-hidden="true">&times;</span>
                </button>
                $Title.RAW
            </div>
            <% end_loop %>
        <% end_if %>
    </div>


    <div class="col-lg-12 d-flex p-0 text-center mb-3 shadowed">
        <button class="submit-btn m-0 bg-dark btn-href" href="{$BaseHref}home/feed">Feed Anggota</button>
        <button class="submit-btn m-0 btn-href" href="{$BaseHref}home/dashboard">Event</button>
    </div>

    <% loop Events %>
    <div class="card">
        <div class="post-title d-flex align-items-center">
            <div class="posted-author m-0">
                <h6 class="author"><a href="$Link" style="font-size: 22px;">$Title</a></h6>
                <span class="post-time mt-1" style="opacity:0.8">
                    <i class="fa fa-calendar mr-1"></i>
                    $Mulai.Format("dd-MM-YYYY")
                    <i class="ml-2 mr-1 fa fa-clock-o"></i>
                    $Mulai.Format("hh.mm")
                </span>
            </div>
            <div class="post-settings-bar">
                <span></span>
                <span></span>
                <span></span>
                <div class="post-settings arrow-shape">
                    <ul>
                        <li><a href="$Link()" class="text-dark"><i class="fa fa-eye mr-2"></i> Detail</a></li>
                        <li><a href="$Link()" class="text-dark"><i class="fa fa-sign-in mr-2"></i> Ikuti Event</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="post-content">
            <div class="ml-auto" style="width: fit-content;">
                <% if $SakaData %>
                <i class="fa fa-building"></i>
                $SakaData.Title
                <% end_if %>
                <% if $KategoriEventData %>
                <i class="ml-2 mr-1 fa fa-folder"></i>
                $KategoriEventData.Title
                <% end_if %>
            </div>
            <hr class="mt-1">

            <p class="post-desc prev-content">
                $Content.LimitWordCount(26,'...')
                <a href="{$BaseHref}event/v/$ID-$getURLSegment">Read More</a>
            </p>
            <% if $Image %>
            <div class="post-thumb-gallery">
                <figure class="post-thumb img-popup">
                    <a href="$getImageEvent.URL">
                        <img src="$getImageEvent.URL" alt="post image">
                    </a>
                </figure>
            </div>
            <% end_if %>
            <div class="post-meta">
                <ul class="comment-share-meta">
                    <li>
                        <button class="post-comment">
                            <i class="fa fa-users"></i>
                            <span style="vertical-align: unset">$getJumlahParticipant</span>
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <% end_loop %>
    <div class="col-lg-12 text-center mt-3 mb-2">
        <div>
            <% if $Events.MoreThanOnePage %>
            <% if $Events.NotFirstPage %>
            <a class="prev btn-page p-1 pl-3 pr-3 bg-white btn" href="$Events.PrevLink"><i
                    class="fa fa-caret-left"></i><i class="fa fa-caret-left"></i></a>
            <% end_if %>
            <% loop $Events.PaginationSummary %>
            <% if $CurrentBool %>
            <a class="btn-page p-1 pl-3 pr-3 bg-theme text-white btn">$PageNum</a>
            <% else %>
            <% if $Link %>
            <a href="$Link" class="btn-page p-1 pl-3 pr-3 bg-white btn">$PageNum</a>
            <% else %>
            ...
            <% end_if %>
            <% end_if %>
            <% end_loop %>
            <% if $Events.NotLastPage %>
            <a class="next btn-page p-1 pl-3 pr-3 bg-white btn" href="$Events.NextLink"><i
                    class="fa fa-caret-right"></i><i class="fa fa-caret-right"></i></a>
            <% end_if %>
            <% end_if %>
        </div>
    </div>
</div>
