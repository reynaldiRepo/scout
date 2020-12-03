<div class="col-md-12 p-0">
    <div class="card" style="">
        <div class="share-box-inner mt-2 pr-2 pl-2">
            <div class="profile-thumb d-flex">
                <a href="$CurrentMember.Link" target="_parent"> 
                    <figure class="profile-thumb-middle bg-dark mr-2 mt-2" style="width:32px;height:32px">
                        <img src="$CurrentMember.getPhotoProfile.Fill(80,80).URL" alt="profile picture">
                    </figure>
                </a>
            </div>
            <div class="share-content-box w-100">
                <form class="share-text-box p-0" action="{$BaseHref}feed/addcomment?id=$FeedDataID" method="POST"
                    id="form-add-comment" method="POST">
                    <textarea id="out-input-comment" name="Content" required class="share-text-field border"
                        style="height:100px;border-radius:10px;padding:10px" placeholder="Say Something"></textarea>
                    <button class="btn btn-danger bg-theme pl-3 pr-3 pt-1 pb-1 mt-2 rounded" type="submit">Comment</button>
                </form>
            </div>
        </div>
        <div class="h-100 w-100 mt-2 p-0 p-2" style="position: relative;">
            <h4 class="widget-title mt-0 mb-4">Komentar Lainnya</h4>
            <% if $Comment %>
                <% loop $Comment %>
                    <div class="post-desc  mt-2">
                        <div class="share-box-inner">
                            <div class="profile-thumb">
                                <a target="_parent" href="$MemberData.Link">
                                    <figure class="profile-thumb-middle bg-dark mr-2 mt-1" style="width:32px;height:32px">
                                        <img src="$MemberData.getPhotoProfile.Fill(100,100).URL" alt="profile picture" style="width:32px;height:32px">
                                    </figure>
                                </a>
                            </div>
                            <div class="share-content-box w-100 p-0">
                                <div class="share-text-box p-0">
                                    <div class="share-text-field bg-white p-0" style="border-radius:10px; height:unset">
                                        <div class="d-flex">
                                            <b>$MemberData.FirstName $MemberData.Surname</b>
                                        </div>
                                        <p class="mb-0">$Content</p>
                                        <div class="col-md-12 p-0 w-100">
                                            <span>
                                                <i class="fa fa-calendar mr-1"></i> $Created.Format("dd-MM-YYYY") 
                                                <i class="fa fa-clock-o ml-2 mr-2"></i>$Created.Format("HH:mm")
                                                <% if $CountComment == 0 %>
                                                <button class="ml-2 reply" id="num-comment-{$ID}" data-ID="$ID" onclick="togglecomment(this)"
                                                data-frame-open="0"><i class="fa fa-reply mr-2"></i>Balas ($CountComment)</button>
                                                <% else %>
                                                <button class="ml-2 reply" id="num-comment-{$ID}" data-ID="$ID" onclick="togglecomment(this)"
                                                data-frame-open="1"><i class="fa fa-reply mr-2"></i>Balas ($CountComment)</button>
                                                <% end_if %>
                                            </span>
                                            <% if $Up.CurrentMember.ID == $MemberData.ID %>
                                            <button class="ml-3 del-comment" data-id="$ID"
                                                data-url="{$BaseHref}feed/deletecomment?FeedDataID=$Top.FeedDataID&ID=$ID">
                                                <i style="font-size:18px" class="fa fa-trash color-theme"></i>
                                            </button>
                                            <% end_if %>
                                        </div>
                                        <% if $CountComment == 0 %>
                                            <div class="frame-content mt-2" id="comment-frame-{$ID}">
                                            </div>
                                        <% else %>
                                            <div class="frame-content mt-2" id="comment-frame-{$ID}">
                                                <iframe src='{$BaseHref}feed/commentreply?CommentFeedDataID={$ID}' width='100%' height='300' frameBorder='0'></iframe>
                                            </div>
                                        <% end_if %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                <% end_loop %>
            <% else %>
                <div class="alert "> Belum ada comment </div>
            <% end_if %>

            <div class="col-lg-12 text-center mt-3 mb-2">
                <div>                
                    <% if $LoadMore %>
                        <a class="next btn-page p-1 pl-3 pr-3 bg-white btn" href="$LoadMore">Load More</a>
                    <% end_if %>
                </div>
            </div>

        </div>

    </div>
</div>


<script>


    $(document).ready(function(){
        blockUI();
    })
    window.onload = function() {
        var param = new URLSearchParams(window.location.search)
        if (param.get("Count") != null && param.get("Count") != "10"){
            window.scrollTo(0,document.body.scrollHeight - 30);
        }
        $.unblockUI();
    }

    parenttrigger = parent.updateNumComment("#num-comment-{$FeedDataID}", "$FeedDataID");

 

    window.updateCommentNum = function(target, id){
        $.ajax({
            url:"{$BaseHref}feed/numreplycomment?id="+id,
        }).done(function(data){
            data = JSON.parse(data)
            if (data.status == 200){
                $(target).html("<i class='bi bi-chat-bubble mr-2'></i>" + data.data)
                parent.updateNumComment("#num-comment-{$FeedDataID}", "$FeedDataID");
            }
        })
    }

    $("#form-add-comment").submit(function (e) {
        e.preventDefault();
        var formData = new FormData(this)
        $.ajax({
            url: $(this).attr('action'),
            method: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            beforeSend: function () {
                blockUI();
            }
        }).done(function (data) {
            $.unblockUI();
            console.log(data);
            data = JSON.parse(data)
            if (data.status == 200) {
                alertSuccess(data.msg);
                parenttrigger;
                location.reload();
            } else {
                alertWarning(data.msg);
            }
        }).fail(function () {
            $.unblockUI();
            alertError("ERROR");
        })
    })

    $(".del-comment").click(function (e) {
        var button = $(this);
        console.log(button)
        Question(function () {
            var ID = button.attr("data-id")
            var URL = button.attr("data-url")
            if (ID == null || URL == null) {
                alertWarning("Something Wrong")
                return
            }
            $.ajax({
                'url': URL,
                'method': "GET",
                processData: false,
                contentType: false,
                beforeSend: function () {
                    blockUI();
                }
            }).done(function (data) {
                $.unblockUI();
                data = JSON.parse(data);
                if (data.status == 200) {
                    alertSuccess(data.msg);
                    parenttrigger;
                    location.reload();
                    location.reload();
                } else {
                    alertWarning(data.msg);
                }
            }).fail(function () {
                $.unblockUI();
                alertError("ERROR");
            })
        }, "Anda yakin menghapus comment ini ? ")
    })

    function togglecomment(e){
        var id = $(e).attr("data-ID")
        var ctr = $("#comment-frame-"+id)
        var isopen = $(e).attr("data-frame-open");
        if (isopen == "0"){
            $(e).attr("data-frame-open", "1");
            ctr.append("<iframe src='{$BaseHref}feed/commentreply?CommentFeedDataID="+id+"' width='100%' height='300' frameBorder='0'></iframe>")
        }else{
            $(e).attr("data-frame-open", "0");
            ctr.find("iframe").first().remove();
        }
    }

</script>