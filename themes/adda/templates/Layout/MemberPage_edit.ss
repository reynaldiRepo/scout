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
                <form id="form-doupdate" action="{$BaseHref}member/doupdate" method="POST">
                    <div class="row">
                        <div class="p-2 col-12">
                            <label>Email</label>
                            <input type="email" required name="Email" class="form-control" placeholder="Email"
                                value="$CurrentMember.Email">
                        </div>
                        <div class="p-2 col-md-6">
                            <label>Nama Depan</label>
                            <input type="text" required name="FirstName" class="form-control" placeholder="First Name"
                                value="$CurrentMember.FirstName">
                        </div>
                        <div class="p-2 col-md-6">
                            <label>Nama Belakang</label>
                            <input type="text" required name="Surname" class="form-control" placeholder="Last Name"
                                value="$CurrentMember.Surname">
                        </div>
                        <div class="p-2 col-12">
                            <label>NTA SIPA</label>
                            <input type="text" required name="NTA_SIPA" class="form-control" placeholder="NTA SIPA"
                                value="$CurrentMember.NTA_SIPA">
                        </div>

                        <div class="p-2 col-6">
                            <label>Kota Lahir</label>
                            <select class="slim-select" name="KabupatenLahirID">
                                <option value="">Pilih Kota Kelahiran</option>
                                <% loop $getKabupaten %>
                                <option value="$ID" <% if $Up.CurrentMember.KabupatenLahirID == $ID %> selected
                                    <% end_if %>>$Title</option>
                                <% end_loop %>
                            </select>
                        </div>

                        <div class="p-2 col-6">
                            <label>Tgl Lahir</label>
                            <input type="date" name="TglLahir" class="form-control" placeholder="Tanggal Lahir"
                                value="$CurrentMember.TglLahir.Format('Y-MM-dd')">
                        </div>

                        <div class="p-2 col-md-6">
                            <label>Gender</label>
                            <select class="slim-select" required name="Sex">
                                <% loop $getArrSex %>
                                <option value="$Sex" <% if $Up.CurrentMember.Sex == $Sex %> selected <% end_if %>>$Title
                                </option>
                                <% end_loop %>
                            </select>
                        </div>

                        <div class="p-2 col-md-6">
                            <label>Agama</label>
                            <select class="slim-select" required name="Agama">
                                <% loop $getArrAgama %>
                                <option value="$Agama" <% if $Up.CurrentMember.Agama == $Agama %> selected <% end_if %>>
                                    $Title</option>
                                <% end_loop %>
                            </select>
                        </div>

                        <div class="p-2 col-md-6">
                            <label>Kabupaten Domisili</label>
                            <select class="slim-select" name="Kabupaten" id="kabupaten-select">
                                <option value=""> Kabupaten Domisili</option>
                                <% if $CurrentMember.Kecamatan %>
                                <% loop $getKabupaten %>
                                <option value="$ID" <% if $Up.CurrentMember.Kecamatan.KabupatenDataID == $ID %> selected
                                    <% end_if %>>$Title</option>
                                <% end_loop %>
                                <% else %>
                                <% loop $getKabupaten %>
                                <option value="$ID">$Title</option>
                                <% end_loop %>
                                <% end_if %>
                            </select>
                        </div>

                        <div class="p-2 col-md-6">
                            <label>Kecamatan Domisili</label>
                            <select name="KecamatanID" id="kecamatan-select">
                                <option value=""> Kecamatan Domisili</option>
                                <% if $CurrentMember.Kecamatan %>
                                <% loop $getKecamatanbyKab($CurrentMember.Kecamatan.KabupatenDataID) %>
                                <option value="$ID" <% if $Up.CurrentMember.KecamatanID == $ID %> selected <% end_if %>>
                                    $Title</option>
                                <% end_loop %>
                                <% end_if %>
                            </select>
                        </div>

                        <div class="p-2 col-md-12">
                            <label>Alamat</label>
                            <Textarea name="Address" class="form-control"
                                placeholder="Alamat">$CurrentMember.Address</Textarea>
                        </div>

                        <div class="p-2 col-md-6">
                            <label>Saka</label>
                            <select class="slim-select" required name="SakaDataID">
                                <% loop $getSaka %>
                                <option value="$ID" <% if $Up.CurrentMember.SakaDataID == $ID %> selected <% end_if %>>
                                    $Title</option>
                                <% end_loop %>
                            </select>
                        </div>
                        <div class="p-2 col-md-6">
                            <label>Golongan</label>
                            <select class="slim-select" required name="GolonganDataID">
                                <% loop $getGolongan %>
                                <option value="$ID" <option value="$ID" <% if $Up.CurrentMember.GolonganDataID == $ID %>
                                    selected <% end_if %>>$Title</option>
                                <% end_loop %>
                            </select>
                        </div>
                        <div class="p-2 col-md-6">
                            <label>Kabupaten Kwarcab</label>
                            <select class="slim-select" required name="KwarcabID" id="kwarcab-select">
                                <% loop $getKabupatenJatim %>
                                <option value="$ID" <% if $Up.CurrentMember.KwarcabID == $ID %> selected <% end_if %>>
                                    $Title</option>
                                <% end_loop %>
                            </select>
                        </div>
                        <div class="p-2 col-md-6">
                            <label>Kabupaten Kwarran</label>
                            <select id="kwarran-select" name="KwarranID">
                                <option value="">Pilih Kwarran</option>
                                <% if $CurrentMember.Kwarran %>
                                <% loop $getKecamatanbyKab($CurrentMember.Kwarran.KabupatenDataID) %>
                                <option value="$ID" <% if $Up.CurrentMember.KwarranID == $ID %> selected <% end_if %>>
                                    $Title</option>
                                <% end_loop %>
                                <% end_if %>
                            </select>
                        </div>
                        <div class="p-2 col-md-12">
                            <label>Bio</label>
                            <Textarea name="Bio" class="form-control" placeholder="Bio"
                                rows="7">$CurrentMember.Bio.RAW</Textarea>
                        </div>
                        <div class="p-2 col-12">
                            <button class="submit-btn">Submit</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="card widget-item">
        <h4 class="widget-title mb-4">Sosial Media</h4>
        <div class="widget-body">
            <div class="about-author">
                <button data-toggle="modal" data-target="#modalsosmed"
                    class="btn btn-info bg-theme mt-2 mb-2 p-1 pl-2 pr-2"><i class="fa fa-plus"></i> Data</button>
                <div class="list-group" id="sosmed-place">
                    <% if $CurrentMember.SosmedData %>
                    <% loop $CurrentMember.SosmedData %>
                    <li class="list-group-item list-group-item-action"><i
                            class="fa-theme $SosmedCategoryData.IconCode mr-2"></i>
                        <a class='text-dark' href="$URL">$Username</a>
                        <button class="delete-btn del-sosmed" data-id="$ID" title="Delete">
                            <span aria-hidden="true"><i class="fa fa-trash"></i></span>
                        </button>
                    </li>
                    <% end_loop %>
                    <% end_if %>
                </div>
            </div>
        </div>
    </div>
    <div class="card widget-item">
        <h4 class="widget-title mb-4">Hobi</h4>
        <div class="widget-body">
            <div class="about-author">
                <button data-toggle="modal" data-target="#modalhobi"
                class="btn btn-info bg-theme mt-2 mb-2 p-1 pl-2 pr-2"><i class="fa fa-plus"></i> Data</button>
                <div class="list-group" id="hobi-place">
                    <% if $CurrentMember.HobbyData %>
                    <% loop $CurrentMember.HobbyData %>
                    <li class="list-group-item list-group-item-action">
                        $Title
                        <button class="delete-btn del-hobby" data-id="$ID" title="Delete">
                            <span aria-hidden="true"><i class="fa fa-trash"></i></span>
                        </button>
                    </li>
                    <% end_loop %>
                    <% end_if %>
                </div>
            </div>
        </div>
    </div>
</div>


<%-- modal add sosmed --%>
<!-- Modal -->
<div class="modal fade" id="modalsosmed" tabindex="-1" role="dialog" aria-labelledby="modalsosmedLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-theme">
                <h5 class="modal-title text-white" id="modalsosmedLabel">Add Sosmed</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form class="form-group" id="form-add-sosmed" action="{$BaseHref}member/addsosmed" method="POST">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12 p-2 pl-3 pr-3">
                            <label>jenis Sosial Media</label>
                            <select class="slim-select" name="SosmedCategoryData">
                                <% loop getSosmedCategoryData %>
                                    <option value="$ID" >
                                        <i class="$IconCode"></i> $Title
                                    </option>
                                <% end_loop %>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 p-2 pl-3 pr-3">
                            <label>Username</label>
                            <input class="form-control" name="Username" required placeholder="Username">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 p-2 pl-3 pr-3">
                            <label>URL</label>
                            <input class="form-control" name="URL" required placeholder="URL">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="submit-btn">Add Data</button>
                </div>
            </form>
        </div>
    </div>
</div>


<%-- modal add hobi --%>
<!-- Modal -->
<div class="modal fade" id="modalhobi" tabindex="-1" role="dialog" aria-labelledby="modalhobiLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-theme">
                <h5 class="modal-title text-white" id="modalhobiLabel">Add Hobi</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form class="form-group" id="form-add-hobi" action="{$BaseHref}member/addhobby" method="POST">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12 p-2 pl-3 pr-3">
                            <label>Keterangan Hobi</label>
                            <input class="form-control" name="Title" required placeholder="Hobi Anda ? ">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="submit-btn">Add Data</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    CKEDITOR.replace('Bio');
</script>

<script>
    $(".banner-user").each(function () {
        $(this).css('background-image', "url(" + $(this).attr("data-bg") + ")")
    })
    var inputPP = $("#input-pp");
    var labelPP = $("#label-pp");
    var triggerPP = $(".pp-trigger");
    var targetPP = $("#pp-user");
    var inputBanner = $("#input-banner");
    var targetBanner = $(".banner-user");
    triggerPP.click(function () {
        labelPP.click();
    })
    //change image pp
    inputPP.change(function () {
        if ($(this).val() != "") {
            if (!imgsizevalidation(1, this)) {
                return;
            }
            loadInputToImage(this, targetPP)
            $("#edit-pp").submit();
        }
    })
    inputBanner.change(function () {
        if ($(this).val() != "") {
            if (!imgsizevalidation(1, this)) {
                return;
            }
            if (this.files && this.files[0]) {
                var reader = new FileReader();
                var file = this.files[0];
                console.log(this.files[0]);
                reader.onload = function (e) {
                    targetBanner.each(function () {
                        $(this).css("background-image", "url(" + e.target.result + ")")
                    })
                }
                reader.readAsDataURL(this.files[0]); // convert to base64 string
            }
            $("#edit-banner").submit();
        }
    })
    $("#edit-pp").submit(function (e) {
        e.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            'method': 'POST',
            'url': $(this).attr("action"),
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
                location.reload();
            } else {
                alertWarning(data.msg);
            }
        }).fail(function () {
            $.unblockUI();
            alertError("ERROR");
        })
    })
    $("#edit-banner").submit(function (e) {
        e.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            'method': 'POST',
            'url': $(this).attr("action"),
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
                location.reload();
            } else {
                alertWarning(data.msg);
            }
        }).fail(function () {
            $.unblockUI();
            alertError("ERROR");
        })
    })

</script>


<%-- for select kecamatan kabupaten --%>
<script>
    var kecamatanselect = $("#kecamatan-select")
    var kecslimselct = new SlimSelect({
        select: '#kecamatan-select'
    })
    $("#kabupaten-select").change(function () {
        if ($(this).val() != "") {
            $.ajax({
                url: "{$BaseHref}api-helper/getKecamatan?idkab=" + $(this).val(),
                method: "GET"
            }).done(function (data) {
                kecamatanselect.html("");
                kecslimselct.destroy();
                console.log(data);
                data = JSON.parse(data)
                data.forEach(e => {
                    kecamatanselect.append(
                        "<option value=" + e.ID + ">" + e.Title + "</option>"
                    )
                })
                kecslimselct = new SlimSelect({
                    select: '#kecamatan-select'
                })
            }).fail(function () {
                kecslimselct = new SlimSelect({
                    select: '#kecamatan-select'
                })
            })
        } else {
            kecamatanselect.html("");
            kecslimselct.destroy();
            kecslimselct = new SlimSelect({
                select: '#kecamatan-select'
            })
        }
    })

    var kwarranselect = $("#kwarran-select")
    var kwarslimselect = new SlimSelect({
        select: '#kwarran-select'
    })
    $("#kwarcab-select").change(function () {
        if ($(this).val() != "") {
            $.ajax({
                url: "{$BaseHref}api-helper/getKecamatan?idkab=" + $(this).val(),
                method: "GET"
            }).done(function (data) {
                kwarranselect.html("");
                kwarslimselect.destroy();
                console.log(data);
                data = JSON.parse(data)
                data.forEach(e => {
                    kwarranselect.append(
                        "<option value=" + e.ID + ">" + e.Title + "</option>"
                    )
                })
                kwarslimselect = new SlimSelect({
                    select: '#kwarran-select'
                })
            }).fail(function () {
                kwarslimselect = new SlimSelect({
                    select: '#kwarran-select'
                })
            })
        } else {
            kwarranselect.html("");
            kwarslimselect.destroy();
            kwarslimselect = new SlimSelect({
                select: '#kwarran-select'
            })
        }
    })

</script>


<%-- for update data --%>
<script>
    $("#form-doupdate").submit(function (e) {
        for (instance in CKEDITOR.instances) {
            CKEDITOR.instances[instance].updateElement();
        }
        e.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            'method': 'POST',
            'url': $(this).attr("action"),
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
                location.reload();
            } else {
                alertWarning(data.msg);
            }
        }).fail(function () {
            $.unblockUI();
            alertError("ERROR");
        })
    })

</script>

<%-- form-add-sosmed --%>
<script>
    function rendersosmed(data){
        console.log(data);
        $("#sosmed-place").append(
        "<li class='list-group-item list-group-item-action'><i"+
        "class='fa-theme "+data.SosmedCategoryData.IconCode+"'></i>"+
        "<a class='text-dark' href='"+data.URL+"'>"+data.Username+"</a>"+
        "<button class='delete-btn del-sosmed' data-id='"+$ID+"' title='Delete'>"+
        "<span aria-hidden='true'><i class='fa fa-trash'></i></span>"+
        "</button>"+
        "</li>"       
        )
    }
    $(".del-sosmed").click(function(){
        var button = $(this);
        deleteQuestion(function(){
            var ctr = button.parent();
            console.log(ctr)
            $.ajax({
                url:"{$BaseHref}member/deletesosmed",
                data:{id:button.attr("data-id")},
                method:"GET",
                beforeSend:function(){
                    blockUI();
                }
            }).done(function(data){
                data = JSON.parse(data)
                if (data.status == 200){
                    $.unblockUI();
                    alertSuccess(data.msg)
                    ctr.hide();
                }else{
                    $.unblockUI();
                    alertWarning(data.msg)
                }
            }).fail(function(){
                $.unblockUI();
                alertError("ERROR")
            })
        }, "Anda yakin menghaups data ini");
    })
    $("#form-add-sosmed").submit(function (e) {
        for (instance in CKEDITOR.instances) {
            CKEDITOR.instances[instance].updateElement();
        }
        e.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            'method': 'POST',
            'url': $(this).attr("action"),
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
            $(".close").click();
            if (data.status == 200) {
                alertSuccess(data.msg);
                rendersosmed(data.data);
            } else {
                alertWarning(data.msg);
            }
        }).fail(function () {
            $.unblockUI();
            alertError("ERROR");
        })
    })
</script>


<%-- form-add-sosmed --%>
<script>
    function renderhobi(data){
        console.log(data);
        $("#hobi-place").append(
            "<li class='list-group-item list-group-item-action'>"+
                data.Title+
                "<button class='delete-btn del-hobby' data-id='"+data.ID+"' title='Delete'>"+
                    "<span aria-hidden='true'><i class='fa fa-trash'></i></span>"+
                "</button>"+
            "</li>"
        )
    }

    $(".del-hobby").click(function(){
        var button = $(this);
        deleteQuestion(function(){
            var ctr = button.parent();
            console.log(ctr)
            $.ajax({
                url:"{$BaseHref}member/deletehobby",
                data:{id:button.attr("data-id")},
                method:"GET",
                beforeSend:function(){
                    blockUI();
                }
            }).done(function(data){
                data = JSON.parse(data)
                if (data.status == 200){
                    $.unblockUI();
                    alertSuccess(data.msg)
                    ctr.hide();
                }else{
                    $.unblockUI();
                    alertWarning(data.msg)
                }
            }).fail(function(){
                $.unblockUI();
                alertError("ERROR")
            })
        }, "Anda yakin menghaups data ini");
    })

    $("#form-add-hobi").submit(function (e) {
        for (instance in CKEDITOR.instances) {
            CKEDITOR.instances[instance].updateElement();
        }
        e.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            'method': 'POST',
            'url': $(this).attr("action"),
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
            $(".close").click();
            if (data.status == 200) {
                alertSuccess(data.msg);
                renderhobi(data.data);
            } else {
                alertWarning(data.msg);
            }
        }).fail(function () {
            $.unblockUI();
            alertError("ERROR");
        })
    })
</script>