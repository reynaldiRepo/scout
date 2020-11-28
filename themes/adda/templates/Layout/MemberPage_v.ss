<div class="col-lg-6 order-1 order-lg-2">


    <div class="col-lg-12 d-flex p-0 text-center mb-3 shadowed">
        <button class="submit-btn m-0 btn-href" href="$Member.Link">Profile</button>
        <button class="submit-btn m-0 bg-dark btn-href" href="{$BaseHref}member/feed/{$Member.ID}-{$Member.getURLSegment}">Feed</button>
    </div>

    <div class="ctr-banner">
        <div class="col-lg-12 bg-dark banner-user lightgallery" data-bg="$Member.getBannerImage.Fill(360,180).URL">
            <img data-src="$Member.getPhotoProfile.URL" src="$Member.getPhotoProfile.Fill(80,80).URL"
                class="pp-banner" />\
        </div>
    </div>
    <div class="card widget-item pt-0">
        <h4 class="widget-title mt-3 mb-4">$Member.FirstName $Member.Surname</h4>
        <div class="widget-body">
            <div class="about-author">
                <% if $Member.Bio %>
                <p>$Member.Bio</p>
                <% end_if %>
                <div class="row">
                    <div class="col-md-6">
                        <ul class="author-into-list">
                            <% if $Member.SakaData %>
                            <li><a><i class="fa-theme fa fa-building mr-1"></i>$Member.SakaData.Title</a></li>
                            <% end_if %>
                            <% if $Member.GolonganData %>
                            <li><a><i class="fa-theme fa fa-star mr-1"></i>$Member.GolonganData.Title</a></li>
                            <% end_if %>
                            <% if $Member.Kwarcab %>
                            <li><a><i class="fa-theme fa fa-home mr-1"></i>Kwarcab
                                    $Member.Kwarcab.getTitleShort()</a></li>
                            <% end_if %>
                            <% if $Member.PangkalanSaka %>
                            <li><a><i class="fa-theme fa fa-flag"></i>$Member.PangkalanSaka</a></li>
                            <% end_if %>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <ul class="author-into-list">
                            <li><a><i class="fa-theme fa fa-envelope mr-1"></i>$Member.Email</a></li>
                            <% if $Member.PhoneNumber %>
                            <li><a><i class="fa-theme fa fa-phone mr-1"></i>$Member.PhoneNumber</a></li>
                            <% end_if %>
                            <% if $Member.TglLahir %>
                            <li><a><i class="fa-theme fa fa-calendar mr-1"></i>(Birthday)
                                    $Member.TglLahir.Format('dd-MM-Y')</a></li>
                            <% end_if %>
                            <% if $Member.Gugusdepan %>
                            <li><a><i class="fa-theme fa fa-graduation-cap" style="padding-right: 15px;"></i>(Gudep)
                                    $Member.Gugusdepan</a>
                            </li>
                            <% end_if %>
                        </ul>
                    </div>
                    <div class="col-md-12">
                        <ul class="author-into-list">
                            <% if $Member.Address %>
                            <li><a><i class="fa-theme fa fa-map mr-1"></i>$Member.Address</a></li>
                            <% end_if %>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card widget-item">
        <h4 class="widget-title mb-4">Sosial Media $Member.FirstName $Member.Surname</h4>
        <div class="widget-body">
            <div class="about-author">
                <div class="list-group">
                    <% if $Member.SosmedData %>
                    <% loop $Member.SosmedData %>
                    <a href="$URL" class="list-group-item list-group-item-action"><i
                            class="fa-theme $SosmedCategoryData.IconCode mr-2"></i>
                        $Username
                    </a>
                    <% end_loop %>
                    <% else %>
                    -
                    <% end_if %>
                </div>
            </div>
        </div>
    </div>
    <div class="card widget-item">
        <h4 class="widget-title mb-4">Hobi $Member.FirstName $Member.Surname</h4>
        <div class="widget-body">
            <div class="about-author">
                <div class="list-group">
                    <% if $Member.HobbyData %>
                    <% loop $Member.HobbyData %>
                    <a class="list-group-item list-group-item-action">$Title</a>
                    <% end_loop %>
                    <% else %>
                    -
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
                    <% if $Member.EventData %>
                    <% loop $Member.EventData %>
                    <a href="$Link" class="list-group-item list-group-item-action">
                        $Title
                    </a>
                    <% end_loop %>
                    -
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

</script>
