<div class="modal fade" id="editfeed-modal" aria-labelledby="editfeed-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Feed</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <form method="POST" class="sr-only" action="{$BaseHref}api-helper/uploadimage" enctype='multipart/form-data'
                id="imageupload-form">
                <label for="imageupload" id="uploadimage-trigger">&nbsp</label>
                <input type="file" name="Image" id="imageupload" accept="image/*">
                <%-- <input type="submit" value="submit"> --%>
            </form>

            <form action="{$BaseHref}member/editfeed" id="addfeed" method="POST">
                <div class="modal-body custom-scroll">
                    <div class="alert alert-info">Perubahan akan dilakukan saat anda menekan tombol "Update"</div>
                    <div class="col-lg-12">
                        <label><span id="char-counter">$lenContent</span> / 320 Karakter</label>
                    </div>
                    <input type="text" readonly name="ID" value="$ID" hidden class="sr-only">
                    <textarea maxlength="320" name="Content" class="share-field-big custom-scroll" id="input-in"
                        placeholder="Say Something">$Content.RAW</textarea>
                    <button class="col-lg-12 p-0 bg-info p-2 rounded text-white" type="button"
                        onclick="$('#uploadimage-trigger').click()">Tambah Image <i class="ml-2 fa fa-image"></i>
                    </button>
                    <div class="col-lg-12 mt-2">
                        <div class="row" id="image-place">
                        <% if $Image %>
                        <% loop $Image %>
                            <div class='col-6 border rounded thumb-container shadowed p-0 text-center mb-2 p-1' data-ID='$ID' id= '$ID'>
                                <div class='img-fluid thumb-upload' id= 'thumb-upload-{$ID}' style='background-image:url($URL)'>&nbsp</div>
                                    <div class='col-md-12 p-1 pt-2 pb-2 bg-light'>
                                    <span class='underline filename'>Image Has Uploaded</span>
                                    <button type='button' onclick='deleteImage(this)' class='close'><i class='fa fa-trash'></i></button>
                                </div>
                            </div>
                        <% end_loop %>
                        <% end_if %>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="post-share-btn" data-dismiss="modal">cancel</button>
                    <button type="submit" class="post-share-btn">Update</button>
                </div>
            </form>

        </div>
    </div>
</div>


<%-- for image upload --%>

<script>
    window.tempIDImage = {};
    <% if $Image %>
    <% loop $Image %>
        window.tempIDImage['$ID'] = "$ID";
    <% end_loop %>
    <% end_if %>
</script>


<script>
    window.UploadStatus = false;
    window.ctrImage = $("#image-place");
    window.counterchar = 0;
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
            Question(function () {
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
            }, "Bila anda menghapus image, Image tersebut hilang dari Postingan anda ! ")
        }else{
            alertWarning("Please Wait...")
        }
    }

    $("#imageupload").change(function(){
        if ($(this).val() != ""){
            if (Object.keys(tempIDImage).length == 5){
                alertWarning("Jumlah Image tidak boleh lebih dari 5");
                return;
            }
            if (!imgsizevalidation(1, this)) {
                return;
            }else{
                $("#imageupload-form").submit()
            }
        }
    })
</script>

<script>
    $("#addfeed").submit(function (e) {
        e.preventDefault();
        var formData = new FormData(this);
        var imageData = Object.keys(tempIDImage)
        if (imageData.length == 0 && $("#input-in").val() == "") {
            alertWarning("Tambahkan data Teks / Image");
            return;
        }
        if (imageData.length != 0) {
            imageData.forEach((data) => {
                formData.append("Images[]", data)
            })
        }
        $.ajax({
            url: $(this).attr("action"),
            data: formData,
            method: "POST",
            processData: false,
            contentType: false,
            beforeSend: function () {
                blockUI();
            }
        }).done(function (data) {
            console.log(data);
            data = JSON.parse(data);
            if (data.status == 200) {
                alertSuccess(data.msg);
                location.reload();
            } else {
                alertWarning(data.msg);
                location.reload();
            }
        }).fail(function () {
            alertError("ERROR");
            location.reload();
        })
    })

</script>
