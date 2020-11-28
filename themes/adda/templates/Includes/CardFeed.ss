<div class="card">
    <!-- post title start -->
    <div class="post-title d-flex align-items-center">
        <!-- profile picture end -->
        <div class="profile-thumb">
            <a href="$MemberData.Link">
                <figure class="profile-thumb-middle">
                    <img src="$MemberData.getPhotoProfileThumb.URL" alt="profile picture">
                </figure>
            </a>
        </div>
        <!-- profile picture end -->

        <div class="posted-author">
            <h6 class="author"><a href="$MemberData.Link">$MemberData.FirstName $MemberData.Surname</a></h6>
            <span class="post-time"><i class="fa fa-calendar mr-1"></i> $Created.Format('dd/MM/YYYY')
                <i class="fa fa-clock-o mr-1 ml-1"></i> $Created.Format('HH:mm')</span>
        </div>

        <div class="post-settings-bar">
            <span></span>
            <span></span>
            <span></span>
            <div class="post-settings arrow-shape">
                <ul>
                    <li><button>report</button></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- post title start -->
    <div class="post-content">
        <p class="post-desc">
            $Content.RAW
        </p>

        <% if $Image && $Image.count == 1 %>
        <% loop $Image %>
        <div class="post-thumb-gallery">
            <figure class="post-thumb img-popup bg-dark">
                <a href="$URL">
                    <img src="$Fill(320, 270).URL" alt="Posted by $Up.MemberData.FirstName ">
                </a>
            </figure>
        </div>
        <% end_loop %>
        <% else %>
        <% if $Image && $Image.count > 1 %>
        <div class="row owl-carousel owl-theme img-popup-{$ID} text-center">
            <% loop $Image %>
            <div class="p-0 p-1" data-src="$URL">
                <div class="post-thumb-gallery ">
                    <figure class="post-thumb bg-dark">
                        <a href="$URL">
                            <img src="$Fill(320, 270).URL" alt="Posted by $Up.MemberData.FirstName ">
                        </a>
                    </figure>
                </div>
            </div>
            <% end_loop %>
        </div>
        <script>
            $(".img-popup-{$ID}").lightGallery();

        </script>
        <% end_if %>
        <% end_if %>

        <div class="post-meta">
            <% if $isLike %>
            <button class="post-meta-like like-btn" data-ID="$ID">
                <i class="fa fa-heart color-theme" id="icon-like-{$ID}"></i>
                <span id="num-like-{$ID}">$LikeData.count</span>
            </button>
            <% else %>
            <button class="post-meta-like like-btn" data-ID="$ID">
                <i class="fa fa-heart-o color-theme" id="icon-like-{$ID}"></i>
                <span id="num-like-{$ID}">$LikeData.count</span>
            </button>
            <% end_if %>
            <ul class="comment-share-meta">
                <li>
                    <button class="post-comment comment-btn" data-ID="$ID">
                        <i class="bi bi-chat-bubble"></i>
                        <span>$CommentFeedData.count()</span>
                    </button>
                </li>
            </ul>
        </div>
    </div>
</div>
