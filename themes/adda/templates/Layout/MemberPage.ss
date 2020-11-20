<div class="col-lg-6 order-1 order-lg-2">
    <div class="ctr-banner">
        <div class="col-lg-12 bg-dark banner-user lightgallery"
            data-bg="$CurrentMember.getBannerImage.Fill(360,180).URL">
            <img data-src="$CurrentMember.getPhotoProfile.URL" src="$CurrentMember.getPhotoProfile.Fill(80,80).URL"
                class="pp-banner" />
        </div>
        <a href="{$BaseHref}member/edit" class="edit-prof-btn text-white bg-info mt-2 pl-2 pr-2"><i
                class="fa fa-edit"></i> Edit Profile</a>
    </div>
    <div class="card widget-item pt-0">
        <h4 class="widget-title mt-3 mb-4">$CurrentMember.FirstName $CurrentMember.Surname</h4>
        <div class="widget-body">
            <div class="about-author">
                <% if $CurrentMember.Bio %>
                <p>$CurrentMember.Bio</p>
                <% else %>
                <p class="alert alert-warning">isikan bio anda agar anggota lain mengerti cerita anda</p>
                <% end_if %>
                <div class="row">
                    <div class="col-md-6">
                        <ul class="author-into-list">
                            <% if $CurrentMember.SakaData %>
                            <li><a><i class="fa-theme fa fa-building"></i>$CurrentMember.SakaData.Title</a></li>
                            <% else %>
                            <li><a><i class="fa fa-exclamation-triangle"></i> Isikan data saka</a></li>
                            <% end_if %>
                            <% if $CurrentMember.GolonganData %>
                            <li><a><i class="fa-theme fa fa-star"></i>$CurrentMember.GolonganData.Title</a></li>
                            <% else %>
                            <li><a><i class="fa fa-exclamation-triangle"></i> Isikan data Golongan</a></li>
                            <% end_if %>
                            <% if $CurrentMember.Kwarcab %>
                            <li><a><i class="fa-theme fa fa-home"></i>Kwarcab $CurrentMember.Kwarcab.getTitleShort()</a></li>
                            <% else %>
                            <li><a><i class="fa fa-exclamation-triangle"></i> Isikan data Kwarcab</a></li>
                            <% end_if %>
                            <% if $CurrentMember.PangkalanSaka %>
                            <li><a><i class="fa-theme fa fa-flag"></i>$CurrentMember.PangkalanSaka</a></li>
                            <% else %>
                            <li><a><i class="fa fa-exclamation-triangle"></i> Isikan data Pangkalan Saka</a></li>
                            <% end_if %>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <ul class="author-into-list">
                            <li><a><i class="fa-theme fa fa-envelope"></i>$CurrentMember.Email</a></li>
                            <% if $CurrentMember.PhoneNumber %>
                            <li><a><i class="fa-theme fa fa-phone"></i>$CurrentMember.PhoneNumber</a></li>
                            <% else %>
                            <li><a><i class="fa fa-exclamation-triangle"></i> Isikan data Nomor Ponsel</a></li>
                            <% end_if %>
                            <% if $CurrentMember.TglLahir %>
                            <li><a><i class="fa-theme fa fa-calendar"></i>(Birthday) $CurrentMember.TglLahir.Format('dd-MM-Y')</a></li>
                            <% else %>
                            <li><a><i class="fa fa-exclamation-triangle"></i> Isikan data TGL Lahir</a></li>
                            <% end_if %>
                            <% if $CurrentMember.Gugusdepan %>
                            <li><a><i class="fa-theme fa fa-graduation-cap" style="padding-right: 15px;"></i>(Gudep) $CurrentMember.Gugusdepan</a>
                            </li>
                            <% else %>
                            <li><a><i class="fa fa-exclamation-triangle"></i> Isikan data Gugus Depan</a></li>
                            <% end_if %>

                        </ul>
                    </div>
                    <div class="col-md-12">
                        <ul class="author-into-list">
                            <% if $CurrentMember.Address %>
                            <li><a><i class="fa-theme fa fa-map"></i>$CurrentMember.Address.RAW</a></li>
                            <% else %>
                            <li><a><i class="fa fa-exclamation-triangle"></i> Isikan data Alamat</a></li>
                            <% end_if %>
                        </ul>
                    </div>
                </div>
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

</script>
