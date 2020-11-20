
<div class="col-lg-3 order-2 order-lg-1">
    <% if $CurrentMember %>
    <% include ProfileCard %>
    <% end_if %>
    <% if $CurrentMember %>
    <% include RecentEvent %>
    <% end_if %>
</div>
<div class="col-lg-9 order-1 order-lg-2">
    <div class="col-lg-12 bg-light p-0 d-flex"
        style="-webkit-box-shadow: 0px 1px 15px 0px rgba(51, 51, 51, 0.2);box-shadow: 0px 1px 15px 0px rgba(51, 51, 51, 0.2);">
        <button class="submit-btn mt-0 bg-theme" id="info-tab">
            Informasi
        </button>
        <button class="submit-btn mt-0 bg-dark" id="participant-tab">
            Peserta
        </button>
    </div>
    <% with Event %>
    <div class="card">
        <div class="post-title d-flex align-items-center">
            <div class="posted-author m-0">
                <h6 class="author w-100"><a href="$Link" style="font-size: 22px;">$Title</a>
                </h6>
            </div>
        </div>
        <div class="post-content" id="participant">
            <hr>
            <h4>Daftar Peserta</h4>
            <hr>
            <div class="col-md-12 table-responsive">
                <table class="table table-striped" id="table-peserta">
                    <thead>
                        <tr>
                            <th>Nama</th>
                            <th>Email</th>
                            <th>Saka</th>
                            <th>Kwarcab</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% loop MemberData %>
                        <tr>
                            <td>$FirstName $Surname</td>
                            <td>$Email</td>
                            <td>$SakaData.Title</td>
                            <td>$Kwarcab.Title</td>
                        </tr>
                        <% end_loop %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="post-content" id="informasi">
            <div class="mr-auto" style="width: fit-content;">
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
            <% if $Image %>
            <div class="post-thumb-gallery">
                <figure class="post-thumb img-popup">
                    <a href="$getImageEvent.URL">
                        <img src="$getImageEvent.URL" alt="post image">
                    </a>
                </figure>
            </div>
            <% end_if %>
            <div class="post-desc table-responsive">
                $Content.RAW
                <hr>
                <table class="table table-striped mt-2">
                    <thead>
                        <tr>
                            <th colspan="2" class="text-center ">
                                INFORMASI TAMBAHAN
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>
                                Mulai
                            </th>
                            <td>
                                <span class="post-time mt-1" style="opacity:0.8">
                                    <i class="fa fa-calendar mr-1"></i>
                                    $Mulai.Format("dd-MM-YYYY")
                                    <i class="ml-2 mr-1 fa fa-clock-o"></i>
                                    $Mulai.Format("hh.mm")
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Selesai
                            </th>
                            <td>
                                <span class="post-time mt-1" style="opacity:0.8">
                                    <i class="fa fa-calendar mr-1"></i>
                                    $Selesai.Format("dd-MM-YYYY")
                                    <i class="ml-2 mr-1 fa fa-clock-o"></i>
                                    $Selesai.Format("hh.mm")
                                </span>
                            </td>
                        </tr>
                        <% if $WebinarURL %>
                        <% if $isJoin %>
                        <tr>
                            <th>
                                Link Online Meeting
                            </th>
                            <td>
                                <a href="$WebinarURL">Join Meeting</a>
                            </td>
                        </tr>
                        <% else %>
                        <tr>
                            <th>
                                Link Online Meeting
                            </th>
                            <td>
                                <i> <i class="fa fa-info mr-2"></i> Join Event untuk melihat </i>
                            </td>
                        </tr>
                        <% end_if %>
                        <% end_if %>
                        <% if $isStillOpen %>
                        <% if $isJoin %>
                        <tr>
                            <td colspan="2">
                                <button class="btn btn-dark bg-secondary text-white btn-block pt-2 pb-2 btn-unjoin"
                                    data-id="$ID" data-url="{$BaseHref}event/unjoin?id=$ID">Sudah Terdaftar, Klik Untuk
                                    Cancel</button>
                            </td>
                        </tr>
                        <% else %>
                        <tr>
                            <td colspan="2">
                                <button class="btn btn-dark bg-theme text-white btn-block pt-2 pb-2 btn-join"
                                    data-id="$ID" data-url="{$BaseHref}event/join?id=$ID"><i
                                        class="fa fa-sign-in mr-2"></i> Join</button>
                            </td>
                        </tr>
                        <% end_if %>
                        <% else %>
                        <tr>
                            <td colspan="2">
                                <button disabled class="btn btn-secondary bg-secondary btn-block pt-2 pb-2"
                                    style="cursor:not-allowed"> Tanggal Event sudah terlewat</button>
                            </td>
                        </tr>
                        <% end_if %>
                    </tbody>
                </table>
            </div>
            <hr>
            <div class="post-meta">
                <ul class="comment-share-meta">
                    <li>
                        <a href="#comment" class="post-comment mr-3">
                            <i class="fa fa-comment"></i>
                            <span style="vertical-align: unset">$getCommentCount</span>
                        </a>
                        <button class="post-comment">
                            <i class="fa fa-users"></i>
                            <span style="vertical-align: unset">$getJumlahParticipant</span>
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <% end_with %>

    <%-- comment place --%>
    <div class="card widget-item mb-3" id="comment">
        <h4 class="widget-title mt-3 mb-4">$CurrentMember.FirstName $CurrentMember.Surname Post Komentar anda</h4>
        <div class="post-desc mt-3">
            <div class="share-box-inner mt-2">
                <div class="profile-thumb">
                    <a href="$CurrentMember.Link">
                        <figure class="profile-thumb-middle bg-dark">
                            <img src="$CurrentMember.getPhotoProfile.Fill(80,80).URL" alt="profile picture">
                        </figure>
                    </a>
                </div>
                <div class="share-content-box w-100">
                    <form class="share-text-box" action="{$BaseHref}event/addcomment?id=$Event.ID" id="form-add-comment-out" method="POST">
                        <textarea id="out-input-comment" name="Content" class="share-text-field" aria-disabled="true"
                            placeholder="Say Something" data-toggle="modal" data-target="#comment-box"></textarea>
                        <button class="btn-share" type="submit">Comment</button>
                    </form>
                </div>
                <div class="modal fade" id="comment-box" aria-labelledby="comment-box" aria-hidden="true"
                    style="display: none;">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Berikan Commentar Anda</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body custom-scroll ps">
                                <form id="form-add-comment" method="POST"
                                    action="{$BaseHref}event/addcomment?id=$Event.ID">
                                    <textarea id="in-input-comment" name="Content"
                                        class="share-field-big custom-scroll ps" placeholder="Say Something"></textarea>
                                    <div class="modal-footer">
                                        <button id="cancel-comment-btn" class="post-share-btn" data-dismiss="modal">cancel</button>
                                        <button type="submit" class="post-share-btn">post</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <h4 class="widget-title mt-3 mb-4">Komentar Lainnya</h4>
        <% if Comments %>
        <% loop Comments %>
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
                                    data-url="{$BaseHref}event/deletecomment?idevent=$EventData.ID&idcomment=$ID">
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
        <div class="mt-2">
            <i>0 - Comment</i>
        </div>
        <% end_if %>

        <div class="col-lg-12 text-center mt-3 mb-2">
            <div>
                <% if $Comments.MoreThanOnePage %>
                <% if $Comments.NotFirstPage %>
                <a class="prev btn-page p-1 pl-3 pr-3 bg-white btn" href="$Comments.PrevLink"><i
                        class="fa fa-caret-left"></i><i class="fa fa-caret-left"></i></a>
                <% end_if %>
                <% loop $Comments.PaginationSummary %>
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
                <% if $Comments.NotLastPage %>
                <a class="next btn-page p-1 pl-3 pr-3 bg-white btn" href="$Comments.NextLink"><i
                        class="fa fa-caret-right"></i><i class="fa fa-caret-right"></i></a>
                <% end_if %>
                <% end_if %>
            </div>
        </div>

    </div>
</div>

<script>
    $("table").each(function () {
        if (!$(this).hasClass("table")) {
            $(this).width("100%")
            $(this).addClass("table table-bordered")
        }
    })
    $('#table-peserta').DataTable();

    var tabInfoBtn = $("#info-tab")
    var tabPesertaBtn = $("#participant-tab")
    var tabInfo = $("#informasi")
    var tabPeserta = $("#participant");
    tabPeserta.hide();
    tabInfoBtn.click(function(){
        $(this).addClass("bg-theme").removeClass("bg-dark")
        tabPesertaBtn.addClass("bg-dark").removeClass("bg-theme")
        tabInfo.show();
        tabPeserta.hide();
    })
    tabPesertaBtn.click(function(){
        $(this).addClass("bg-theme").removeClass("bg-dark")
        tabInfoBtn.addClass("bg-dark").removeClass("bg-theme")        
        tabInfo.hide();
        tabPeserta.show();
    })
</script>

<script>
    $(".btn-join").click(function (e) {
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
                    location.reload();
                } else {
                    alertWarning(data.msg);
                }
            }).fail(function () {
                $.unblockUI();
                alertError("ERROR");
            })
        }, "Anda yakin mengikuti event ini ? ")
    })



    $(".btn-unjoin").click(function (e) {
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
                    location.reload();
                } else {
                    alertWarning(data.msg);
                }
            }).fail(function () {
                $.unblockUI();
                alertError("ERROR");
            })
        }, "Anda yakin keluar dari event ini ? ")
    })

</script>


<script>
    var outcomment = $("#out-input-comment");
    var incomment = $("#in-input-comment");
    var cancelcomment = $("#cancel-comment-btn");
    outcomment.change(function(){
        incomment.val($(this).val())
    })

    incomment.change(function(){
        outcomment.val($(this).val())
    })

    cancelcomment.click(function(){
        outcomment.val(incomment.val())
    })




    $("#form-add-comment, #form-add-comment-out").submit(function (e) {
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
