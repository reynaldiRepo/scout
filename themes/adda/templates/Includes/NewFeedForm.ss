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
                <textarea readonly name="share" class="share-text-field" aria-disabled="true" placeholder="Say Something"
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
                            <button class="col-lg-12 p-0 bg-info p-2 rounded text-white" type="button"
                                onclick="$('#uploadimage-trigger').click()">Tambah Image <i class="ml-2 fa fa-image"></i>
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
<% include ScriptUploadImageFeed  %>
<script>
$("#addfeed").submit(function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var imageData = Object.keys(tempIDImage)
    if (imageData.length == 0 && $("#input-in").val()==""){
        alertWarning("Tambahkan data Teks / Image");
        return;
    }
    if (imageData.length != 0){
        imageData.forEach((data)=>{
            formData.append("Images[]", data)
        })
    }
    $.ajax({
        url : $(this).attr("action"),
        data : formData,
        method : "POST",
        processData: false,
        contentType: false,
        beforeSend: function(){
            blockUI();
        }
    }).done(function(data){
        console.log(data);
        data = JSON.parse(data);
        if (data.status == 200){
            alertSuccess(data.msg);
            location.reload();
        }else{
            alertWarning(data.msg);
            location.reload();
        }
    }).fail(function(){
        alertError("ERROR");
        location.reload();
    })
})
</script>
