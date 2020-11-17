<div class="col-lg-3 order-2 order-lg-1">
    <% if $CurrentMember %>
    <% include ProfileCard %>
    <% end_if %>
    <% if $CurrentMember %>
    <% include RecentEvent %>
    <% end_if %>
</div>
<div class="col-lg-9 order-1 order-lg-2">
    <% with Event %>
    <div class="card">
        <div class="post-title d-flex align-items-center">
            <div class="posted-author m-0">
                <h6 class="author w-100"><a href="$Link" style="font-size: 22px;">$Title</a>
                </h6>
            </div>
        </div>
        <div class="post-content">
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
            <div class="post-desc">
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
                        <tr>
                            <th>
                               Link Online Meeting
                            </th>
                            <td>
                                    <a href="$WebinarURL">Join Meeting</a>
                            </td>
                        </tr>
                        <% end_if %>
                        <tr>
                            <td colspan="2">
                                <a class="btn btn-info bg-info btn-block pt-2 pb-2"  href="{$BaseHref}event"><i class="fa fa-sign-in"></i> Join</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <hr>
            <div class="post-meta">
                <ul class="comment-share-meta">
                    <li>
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
</div>

<script>
    $("table").each(function () {
        if (!$(this).hasClass("table")) {
            $(this).width("100%")
            $(this).addClass("table table-bordered")
        }
    })

</script>
