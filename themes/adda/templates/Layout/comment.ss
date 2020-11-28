<div class="col-md-12 p-0">
    <div class="card" style="height:650px !important">
        <h4 class="widget-title mt-0 mb-4">$CurrentMember.FirstName $CurrentMember.Surname Post Komentar anda</h4>
        <div class="share-box-inner mt-2">
            <div class="profile-thumb">
                <a href="$CurrentMember.Link" target="_parent"> 
                    <figure class="profile-thumb-middle bg-dark">
                        <img src="$CurrentMember.getPhotoProfile.Fill(80,80).URL" alt="profile picture">
                    </figure>
                </a>
            </div>
            <div class="share-content-box w-100">
                <form class="share-text-box" action="{$BaseHref}feed/addcomment?id=$FeedDataID" method="POST"
                    id="form-add-comment" method="POST">
                    <textarea id="out-input-comment" name="Content" required class="share-text-field"
                        style="height:100px;border-radius:10px;padding:10px" placeholder="Say Something"></textarea>
                    <button class="submit-btn mt-2 p-2" style="border-radius:10px" type="submit">Comment</button>
                </form>
            </div>
        </div>
        <hr>
        <div class="h-100 w-100 mt-2 p-0 p-2" style="position: relative; overflow-y:scroll">
            <h4 class="widget-title mt-0 mb-4">Komentar Lainnya</h4>
            <% if $Comment %>
                <% loop $Comment %>
                    <div class="post-desc  mt-2">
                        <div class="share-box-inner">
                            <div class="profile-thumb">
                                <a href="$MemberData.Link">
                                    <figure class="profile-thumb-middle bg-dark">
                                        <img src="$MemberData.getPhotoProfile.Fill(80,80).URL" alt="profile picture">
                                    </figure>
                                </a>
                            </div>
                            <div class="share-content-box w-100">
                                <div class="share-text-box">
                                    <div class="share-text-field bg-white p-3" style="border-radius:10px; height:unset">
                                        <b>$MemberData.FirstName $MemberData.Surname</b>
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
                                                data-url="{$BaseHref}feed/deletecomment?FeedDataID=$Top.FeedDataID&ID=$ID">
                                                <i style="font-size:18px" class="fa fa-trash"></i>
                                            </button>
                                            <% end_if %>
                                        </div>
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
                    <% if $Comment.MoreThanOnePage %>
                    <% if $Comment.NotFirstPage %>
                    <a class="prev btn-page p-1 pl-3 pr-3 bg-white btn" href="$Comment.PrevLink"><i
                            class="fa fa-caret-left"></i><i class="fa fa-caret-left"></i></a>
                    <% end_if %>
                    <% loop $Comment.PaginationSummary %>
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
                    <% if $Comment.NotLastPage %>
                    <a class="next btn-page p-1 pl-3 pr-3 bg-white btn" href="$Comment.NextLink"><i
                            class="fa fa-caret-right"></i><i class="fa fa-caret-right"></i></a>
                    <% end_if %>
                    <% end_if %>
                </div>
            </div>

        </div>

    </div>
</div>


<script>

    var parenttrigger = window.parent.$("#num-comment-{$FeedDataID}");
    var numcomment = parseInt(parenttrigger.text())
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
                parenttrigger.text(numcomment+1)
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
                    parenttrigger.text(numcomment-1)
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

</script>