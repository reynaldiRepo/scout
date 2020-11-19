<div class="col-lg-6 order-1 order-lg-2">
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
                        <li><button><i class="fa fa-sign-in mr-2"></i> Ikuti Event</button></li>
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

            <p class="post-desc">
                $Content.LimitCharacters(320,'...')
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
