<div class="col-lg-6 order-1 order-lg-2">
    <div class="ctr-banner">
        <div id="banner-user" class="col-lg-12 bg-dark banner-user"
            data-bg="$CurrentMember.getBannerImage.Fill(360,180).URL">
            <img id="pp-user" data-src="$CurrentMember.getPhotoProfile.Fill(80,80).URL"
                src="$CurrentMember.getPhotoProfile.Fill(80,80).URL" class="pp-banner pp-trigger" />
            <i class="fa fa-edit bg-dark text-white p-2 pp-trigger" style="
                position: absolute;
                top: 125px;
                padding:20px !important;
                background:rgba(0,0,0,0.2) !important;
                border-radius:50%;
                cursor:pointer"></i>
        </div>
        <form id="edit-pp" action="{$BaseHref}member/updatepp" method="POST" enctype='multipart/form-data'>
            <input id="input-pp" accept="image/*" type="file" name="PhotoProfile" hidden>
            <label for="input-pp" id="label-pp" hidden><i class="fa fa-edit"></i></label>
        </form>
        <form id="edit-banner" action="{$BaseHref}member/updatebanner" method="POST" enctype='multipart/form-data'>
            <input id="input-banner" accept="image/*" type="file" name="BannerImage" hidden>
            <label style="cursor:pointer" for="input-banner" class="edit-prof-btn text-white bg-info mt-2 pl-2 pr-2"><i
                    class="fa fa-edit"></i> Change Banner</label>
        </form>
    </div>
    <div class="card widget-item pt-0">
        <h4 class="widget-title mt-3 mb-4">Edit Data</h4>
        <div class="widget-body">
            <div class="about-author">

            </div>
        </div>
    </div>
    <div class="card widget-item">
        <h4 class="widget-title mb-4">Sosial Media $CurrentMember.FirstName $CurrentMember.Surname</h4>
        <div class="widget-body">
            <div class="about-author">
                <div class="list-group">
                    <% if $CurrentMember.SosmedData %>
                    <% loop $CurrentMember.SosmedData %>
                    <a href="$URL" class="list-group-item list-group-item-action"><i
                            class="fa-theme $SosmedCategoryData.IconCode mr-2"></i>
                        $Username
                    </a>
                    <% end_loop %>
                    <% else %>
                    <a class="alert alert-warning">
                        <i class="">Tambahkan data Sosial Media</i>
                    </a>
                    <% end_if %>
                </div>
            </div>
        </div>
    </div>
    <div class="card widget-item">
        <h4 class="widget-title mb-4">Hobi $CurrentMember.FirstName $CurrentMember.Surname</h4>
        <div class="widget-body">
            <div class="about-author">
                <div class="list-group">
                    <% if $CurrentMember.HobbyData %>
                    <% loop $CurrentMember.HobbyData %>
                    <a class="list-group-item list-group-item-action">$Title</a>
                    <% end_loop %>
                    <% else %>
                    <a class="alert alert-warning">
                        <i class="">Tambahkan data hobi</i>
                    </a>
                    <% end_if %>
                </div>
            </div>
        </div>
    </div>
    <div class="card widget-item">
        <h4 class="widget-title mb-4">Event yang pernah diikuti</h4>
        <div class="widget-body">
            <div class="about-author">
                <div class="list-group">
                    <% if $CurrentMember.EventData %>
                    <% loop $CurrentMember.EventData %>
                    <a href="$Link" class="list-group-item list-group-item-action">
                        $Title
                    </a>
                    <% end_loop %>
                    <% else %>
                    <a class="alert alert-info">
                        <i class="">Tidak ada data, silahkan mengikuti event peransaka</i>
                    </a>
                    <% end_if %>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(".banner-user").each(function () {
        $(this).css('background-image', "url(" + $(this).attr("data-bg") + ")")
    })
    var inputPP = $("#input-pp");
    var labelPP = $("#label-pp");
    var triggerPP = $(".pp-trigger");
    var targetPP = $("#pp-user");

    var inputBanner = $("input-banner");
    var targetBanner = $(".banner-user");

    triggerPP.click(function () {
        labelPP.click();
    })
    //change image pp
    inputPP.change(function () {
        if ($(this).val() != "") {
            loadInputToImage(this, targetPP)
            $("#edit-pp").submit();
        }
    })

    $("#edit-pp").submit(function (e) {
        e.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            'method': 'POST',
            'url': "{$BaseHref}member/updatepp",
            'data': formData,
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
            } else {
                alertWarning(data.msg);
            }
        }).fail(function () {
            $.unblockUI();
            alertError("ERROR");
        })
    })

</script>
