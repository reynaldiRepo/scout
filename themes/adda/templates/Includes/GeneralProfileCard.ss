<div class="card card-profile widget-item p-0">
    <div class="profile-banner">
        <figure class="profile-banner-small">
            <a href="$Link">
                <% if $BannerImage %>
                <img src="$getBannerImage().Fill(800,420).URL" alt="">
                <% else %>
                <img src="$SiteConfig.DefaultPhotoBannerMember.Fill(800,420).URL" alt="">
                <% end_if %>
            </a>
            
            <a href="$Link" class="profile-thumb-2 bg-dark mt-0" style="bottom:5px">
                <img src="$getPhotoProfile.Fill(80,80).URL" alt="">
            </a>
            
        </figure>
        <div class="profile-desc p-0 m-0">
            <div class="list-group">
                <a href="$Link" class="list-group-item list-group-item-action text-center" style="text-transform:uppercase">
                    <b>$FirstName $Surname</b>
                </a>
                <% if $SakaData %>
                <a href="$Link" class="list-group-item list-group-item-action"><i class="fa-theme fa fa-building mr-2"></i> $SakaData.getTitleShort()</a>
                <% end_if %>
                <% if $GolonganData %>
                <a href="$Link" class="list-group-item list-group-item-action"><i class="fa-theme fa fa-star mr-2"></i> $GolonganData.Title</a>
                <% end_if %>
                <% if $Kwarcab.Title %>
                <a href="$Link" class="list-group-item list-group-item-action"><i class="fa-theme fa fa-home mr-2"></i> Kwarcab $Kwarcab.getTitleShort()</a>
                <% end_if %>
              </div>
        </div>
    </div>
</div>
