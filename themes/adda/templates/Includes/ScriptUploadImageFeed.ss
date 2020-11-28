<script>
    window.UploadStatus = false;
    window.tempIDImage = {};
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
        $("#char-counter").text($(this).val().length)
    })

    $("#input-out").change(function(){
        $("#input-in").val($("#input-out").val())
        $("#char-counter").text($(this).val().length)
    })

    $("#input-out, #input-in").on('change keyup paste', function() {
        $("#char-counter").text($(this).val().length);
    });
</script>