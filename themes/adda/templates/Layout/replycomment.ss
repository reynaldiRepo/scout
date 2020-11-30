<% with $CommentParent  %>
<div class="col-md-12 p-0 bg-light">
    <div class="card p-0 bg-light" style="">
        <div class="col-md-12 p-0 pl-4 pr-3 reply-container pt-3 mt-0" id="reply-container-{$ID}">
            <div class="share-box-inner pl-3 mt-0">
                <div class="share-content-box w-100">
                    <form class="share-text-box p-0 form-add-comment-reply"
                        action="{$BaseHref}feed/addcommentreply?id=$ID" method="POST" id="form-add-comment-reply"
                        method="POST">
                        <textarea id="out-input-comment" name="Content" required class="share-text-field"
                            style="height:50px;border-radius:10px;padding:10px" placeholder="Say Something"></textarea>
                        <button class="submit-btn mt-2 p-2" style="border-radius:10px" type="submit">Comment</button>
                    </form>
                </div>
            </div>
            <div class="col-md-12 pl-3">
                <hr class="mb-2">
                <h6 class="mt-0 mb-2">Komentar Lainnya</h6>
                <hr class="mt-2">
            </div>
            <% if $Top.Comment %>
            <% loop $Top.Comment %>
            <div class="share-text-box pt-2 pb-2 pl-4 pr-0">
                <div class="share-text-field bg-white p-3" style="border-radius:10px; height:unset">
                    <div class="d-flex">
                        <div class="profile-thumb">
                            <a target="_blank" href="$MemberData.Link">
                                <figure class="profile-thumb-middle bg-dark mr-2" style="width:32px;height:32px">
                                    <img src="$MemberData.getPhotoProfile.Fill(80,80).URL" alt="profile picture">
                                </figure>
                            </a>
                        </div>
                        <b>$MemberData.FirstName $MemberData.Surname</b>
                    </div>
                    <hr class="m-0 mt-2 mb-2">
                    <p>$Content</p>
                    <hr>
                    <div class="col-md-12 p-1 w-100">
                        <span>
                            <i class="fa fa-calendar mr-2"></i> $Created.Format("dd-MM-YYYY")
                            <i class="fa fa-clock-o ml-2 mr-2"></i>$Created.Format("HH:mm")
                        </span>
                        <% if $Up.CurrentMember.ID == $MemberData.ID %>
                        <button class="float-right del-comment" data-id="$ID"
                            data-url="{$BaseHref}feed/deletecomment?FeedDataID=$Top.CommentParent.FeedDataID&ID=$ID">
                            <i style="font-size:18px" class="fa fa-trash"></i>
                        </button>
                        <% end_if %>
                    </div>
                </div>
            </div>
            <% end_loop %>
            
            <div class="col-lg-12 text-center mt-3 mb-2">
                <div>
                    <% if $Top.Comment.MoreThanOnePage %>
                    <% if $Top.Comment.NotFirstPage %>
                    <a class="prev btn-page p-1 pl-3 pr-3 bg-white btn" href="$Top.Comment.PrevLink"><i
                            class="fa fa-caret-left"></i><i class="fa fa-caret-left"></i></a>
                    <% end_if %>
                    <% loop $Top.Comment.PaginationSummary %>
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
                    <% if $Top.Comment.NotLastPage %>
                    <a class="next btn-page p-1 pl-3 pr-3 bg-white btn" href="$Comment.NextLink"><i
                            class="fa fa-caret-right"></i><i class="fa fa-caret-right"></i></a>
                    <% end_if %>
                    <% end_if %>
                </div>
            </div>

            <% else %>
                <div class="alert">Belum ada data</div>
            <% end_if %>

            
        </div>
    </div>
</div>
<% end_with %>


<script>
    
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
                    parent.updateCommentNum("#num-comment-{$CommentParent.ID}" , "$CommentParent.ID")
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

    $(".form-add-comment-reply").submit(function (e) {
        e.preventDefault();
        var formData = new FormData(this);
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
                parent.updateCommentNum("#num-comment-{$CommentParent.ID}" , "$CommentParent.ID")
                location.reload();
            } else {
                alertWarning(data.msg);
            }
        })
    })

</script>