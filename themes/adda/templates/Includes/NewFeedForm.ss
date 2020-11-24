<!-- share box start -->
<div class="card card-small">
    <div class="share-box-inner">
        <!-- profile picture end -->
        <div class="profile-thumb">
            <a href="$CurrentMember.Link">
                <figure class="profile-thumb-middle">
                    <img src="$CurrentMember.getPhotoProfileThumb.URL" alt="profile picture">
                </figure>
            </a>
        </div>
        <!-- profile picture end -->

        <!-- share content box start -->
        <div class="share-content-box w-100">
            <div class="share-text-box mb-2">
                <textarea name="share" class="share-text-field" aria-disabled="true" placeholder="Say Something"
                    id="input-out" data-toggle="modal" data-target="#addfeed-modal" id="email"></textarea>
                <button class="btn-share" id="out-submit" type="button">share</button>
            </div>
            <span style="cursor:pointer;text-decoration: underline;" id="n-file" class="text-danger float-right sr-only attach-count"></span>
        </div>
        <!-- share content box end -->

        <!-- Modal start -->
        <div class="modal fade" id="addfeed-modal" aria-labelledby="addfeed-modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Bagikan Ceritamu</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <form method="POST" class="sr-only" action="{$BaseHref}api-helper/uploadimage"
                        enctype='multipart/form-data' id="imageupload-form">
                        <label for="imageupload" id="uploadimage-trigger">&nbsp</label>
                        <input type="file" name="Image" id="imageupload" accept="image/*">
                        <%-- <input type="submit" value="submit"> --%>
                    </form>

                    <form action="{$BaseHref}member/addfeed" id="addfeed" method="POST">
                        <div class="modal-body custom-scroll">
                            <textarea name="Content" class="share-field-big custom-scroll" id= "input-in"
                                placeholder="Say Something"></textarea>
                            <button class="col-lg-12 p-0 bg-theme p-2 rounded text-white" type="button"
                                onclick="$('#uploadimage-trigger').click()">
                                <i class="fa fa-plus"></i> Tambah Image
                            </button>
                            <div class="col-lg-12 mt-2">
                                <div class="row" id="image-place">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="post-share-btn" data-dismiss="modal">cancel</button>
                            <button type="submit" class="post-share-btn">post</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <!-- Modal end -->
    </div>
</div>
<!-- share box end -->

<%-- for image upload --%>
<script>
    window.UploadStatus = false;
    window.tempIDImage = {};
    window.ctrImage = $("#image-place");
    var lgopt = {
                    selector : ".thumb-upload",
                    download: false,
                    enableDrag: true,
                    enableSwipe: true,
                    counter: false,
                    loop: false,
                    closable: false,
                    toogleThumb : false,
                    thumbnail: false
                }
    ctrImage.lightGallery(lgopt);

    function generateID(){
        var d = new Date();
        return d.getDay()+d.getMonth()+d.getFullYear()+d.getHours()+d.getMinutes()+d.getSeconds();
    }

    function renderThumb(filename, ID){
        return "<div class='col-6 border rounded thumb-container shadowed p-0 text-center mb-2 p-1' data-ID='0' id = '"+ID+"'>"+
            "<div class='img-fluid thumb-upload' id = 'thumb-upload-"+ID+"'"+
            "style='background-image:url($SiteConfig.LoadingGif.URL)'>&nbsp</div>"+
            "<div class='col-md-12 p-1 pt-2 pb-2 bg-light'>"+
            "<span class='underline filename'>"+filename+"</span>"+
            "<button type='button' onclick='deleteImage(this)' class='close'><i "+
            "class='fa fa-trash'></i></button>"+
            "</div></div>";
    }

    $("#imageupload-form").submit(function(el){
        window.UploadStatus = true
        var ID = generateID();
        el.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            url: $(this).attr("action"),
            method : "POST",
            data : formData,
            processData: false,
            contentType: false,
            beforeSend: function(){
                window.ctrImage.append(renderThumb("Uploading...", ID));
            }
        }).done(function(data){
            console.log(data)
            data =JSON.parse(data);
            if (data.status == 200){
                alertSuccess(data.msg)
                $("#thumb-upload-"+ID).css('background-image', "url('"+data.URL+"')")
                $("#"+ID).find(".filename").first().html(data.FileName)
                $("#"+ID).attr("data-ID", data.ID)
                $("#thumb-upload-"+ID).attr("data-src", data.URL)
                tempIDImage[data.ID] = data.ID;
                ctrImage.data('lightGallery').destroy(true);
                ctrImage.lightGallery(lgopt);
            }else{
                alertWarning(data.msg)
                $("#"+ID).remove()
            }
            $("#imageupload").val("")
            window.UploadStatus = false
        }).fail(function(){
            $("#"+ID).remove()
            alertError("Error");
            $("#imageupload").val("")
            window.UploadStatus = false
        })
    })


    function deleteImage(e){
        if (!UploadStatus){
            var parent = $(e).parent().parent(); 
            var id = parent.attr("data-ID");
            if(!id){
                alertWarning("Something Wrong")
                return;
            }
            $.ajax({
                url : "{$BaseHref}api-helper/deleteimage?id="+id,
                method: "GET",
                beforeSend: function(){blockUI()}
            }).done(function(data){
                data = JSON.parse(data)
                $.unblockUI()
                if (data.status == 200){
                    alertSuccess(data.msg)
                    parent.remove();
                    delete(tempIDImage[id])
                }else{
                    alertWarning(data.msg)
                }
            }).fail(function(){
                alertError("Error");
            })
        }else{
            alertWarning("Please Wait...")
        }
    }

    $("#imageupload").change(function(){
        if ($(this).val() != ""){
            if (!imgsizevalidation(1, this)) {
                return;
            }else{
                $("#imageupload-form").submit()
            }
        }
    })


    // for general purpose
    $('#addfeed-modal').on('hidden.bs.modal', function () {
        if (Object.keys(tempIDImage).length != 0 ){
                var n = Object.keys(tempIDImage).length
                $("#n-file").html("<i class='fa  fa-image mr-1'></i> "+n+" image disematkan").removeClass("sr-only")
        }else{
            $("#n-file").html("").addClass("sr-only")
        }
    })

    $("#input-in").change(function(){
        $("#input-out").val($("#input-in").val())
    })

    $("#input-out").change(function(){
        $("#input-in").val($("#input-out").val())
    })
</script>