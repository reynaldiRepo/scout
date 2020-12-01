<div class="col-lg-3 order-2 order-lg-1">
    <% if $CurrentMember %>
    <% include ProfileCard %>
    <% end_if %>
    <% if $CurrentMember %>
    <% include RecentEvent %>
    <% end_if %>
</div>
<div class="col-lg-9 order-1 order-lg-2">
    <div class="card widget-item">
        <% with $Feed %>
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
            <button class="edit-feed btn btn-info float-right">Edit</button>
            <div class="post-settings-bar">
                <span></span>
                <span></span>
                <span></span>
                <div class="post-settings arrow-shape">
                    <ul>
                        <% if $Top.CurrentMember.ID == $MemberData.ID %>
                        <li><button data-toggle="modal" data-target="#editfeed-modal"  class="edit-feed-btn" data-id="$ID">Edit</button>
                        <li><button class="delete-feed-btn" onclick="deletefeed(this)" data-id="$ID">Delete</button>
                        </li>
                        <% end_if %>
                        
                        <% if $Top.CurrentMember.ID != $MemberData.ID %>
                            <li><button class="report-btn" onclick="doreport(this)" data-id="$ID">Report</button></li>
                        <% end_if %>

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
                <figure class="post-thumb img-popup bg-dark text-center">
                    <a href="$URL">
                        <img src="$Fill(640, 520).URL" alt="Posted by $Up.MemberData.FirstName " style="width:100%">
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
                        <button class="post-comment comment-btn" data-ID="$ID" data-frame-open="0">
                            <i class="bi bi-chat-bubble"></i>
                            <span id="num-comment-{$ID}">$CountComment</span>
                        </button>
                    </li>
                </ul>
            </div>
            <hr>
            <div class="frame-content mt-2" id="comment-frame-{$ID}">
                <iframe src='{$BaseHref}feed/comment?FeedDataID={$ID}' width='100%' height='500'
                    frameBorder='0'></iframe>
            </div>
            <% end_with %>
        </div>
    </div>
</div>

<% with $Feed %>
<% include EditFeedForm %>
<% end_with %>

<script>
    $(".like-btn").click(function () {
        var id = $(this).attr("data-ID")
        var numcomment = parseInt($("#num-like-" + id).text());
        var icon = $("#icon-like-" + id);
        $.ajax({
            url: "{$BaseHref}api-helper/likefeed",
            data: {
                'FeedDataID': id
            }
        }).done(function (data) {
            data = JSON.parse(data)
            if (data.status == 200) {
                //success like
                icon.attr('class', 'fa fa-heart color-theme');
                numcomment += 1;
                $("#num-like-" + id).text(numcomment);
            } else if (data.status == 205) {
                icon.attr('class', 'fa fa-heart-o color-theme');
                numcomment -= 1;
                $("#num-like-" + id).text(numcomment);
            } else {
                console.log(data);
            }
        }).fail(function () {
            console.log(data);
        })
    })

    function likefeed(e) {
        var id = $(e).attr("data-ID")
        var numcomment = parseInt($("#num-like-" + id).text());
        var icon = $("#icon-like-" + id);
        $.ajax({
            url: "{$BaseHref}api-helper/likefeed",
            data: {
                'FeedDataID': id
            }
        }).done(function (data) {
            data = JSON.parse(data)
            if (data.status == 200) {
                //success like
                icon.attr('class', 'fa fa-heart color-theme');
                numcomment += 1;
                $("#num-like-" + id).text(numcomment);
            } else if (data.status == 205) {
                icon.attr('class', 'fa fa-heart-o color-theme');
                numcomment -= 1;
                $("#num-like-" + id).text(numcomment);
            } else {
                console.log(data);
            }
        }).fail(function () {
            console.log(data);
        })
    }

    window.updateNumComment = function (target, id) {
        $.ajax({
            url: "{$BaseHref}feed/updatenumcomment?id=" + id,
        }).done(function (data) {
            data = JSON.parse(data)
            if (data.status == 200) {
                $(target).text(data.data)
            }
        })
    }

</script>


<script>
    $(document).ready(function () {
        $(".lightgallery").lightGallery();
        $(".slim-select").each(function () {
            new SlimSelect({
                select: this
            })
        })
        $(".prev-content").each(function () {
            $(this).find("br").each(function () {
                console.log("aa")
                $(this).remove();
            })
        })
        $(".close-div").click(function () {
            var process = $(this).attr("data-process");
            var div = $($(this).attr("data-target"))
            div.hide();
            if (process == 1) {
                var url = $(this).attr("data-url");
                $.ajax({
                    url: url,
                    method: "GET"
                }).done(function (data) {
                    console.log(data)
                }).fail(() => {
                    console.log("Error")
                })
            }
        })
        $(".btn-href").click(function (e) {
            e.preventDefault();
            blockUI();
            location.href = $(this).attr("href")
        })
    });


    window.owl = $(".owl-carousel").owlCarousel({
        dots: true,
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            600: {
                items: 3
            },
            1000: {
                items: 3
            }
        }
    });

    function deletefeed(e) {
        var id = $(e).attr("data-id");
        Question(function () {
            $.ajax({
                url: "{$BaseHref}feed/deletefeed?id=" + id,
                beforeSend: function () {
                    blockUI()
                }
            }).done(function (data) {
                $.unblockUI()
                data = JSON.parse(data);
                if (data.status == 200) {
                    alertSuccess(data.msg)
                    location.href="{$BaseHref}member/feed";
                } else {
                    alertWarning(data.msg)
                }
            }).fail(function () {
                $.unblockUI()
                alertError("ERROR !!!")
            })
        }, "Anda yakin menghapus data ini ? ")
    }

</script>
