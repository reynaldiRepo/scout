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
<% ScriptUploadImageFeed  %>