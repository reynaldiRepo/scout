<div class="card card-profile widget-item p-0 xs-hidden">
    <div class="profile-banner">
        <figure class="profile-banner-small">
            <a href="{$BaseHref}member">
                <% if $CurrentMember.BannerImage %>
                <img src="$CurrentMember.getBannerImage().Fill(800,420).URL" alt="">
                <% else %>
                <img src="$SiteConfig.DefaultPhotoBannerMember.Fill(800,420).URL" alt="">
                <% end_if %>
            </a>
            
            <a href="{$BaseHref}member" class="profile-thumb-2 bg-dark mt-0" style="bottom:5px">
                <img src="$CurrentMember.getPhotoProfile.Fill(80,80).URL" alt="">
            </a>
            
        </figure>
        <div class="profile-desc p-0 m-0">
            <div class="list-group">
                <a href="{$BaseHref}member" class="list-group-item list-group-item-action text-center" style="text-transform:uppercase">
                    <b>$CurrentMember.FirstName $CurrentMember.Surname</b>
                </a>
                <% if $CurrentMember.SakaData %>
                <a href="{$BaseHref}member" class="list-group-item list-group-item-action"><i class="fa-theme fa fa-building mr-2"></i> $CurrentMember.SakaData.Title</a>
                <% end_if %>
                <% if $CurrentMember.GolonganData %>
                <a href="{$BaseHref}member" class="list-group-item list-group-item-action"><i class="fa-theme fa fa-star mr-2"></i> $CurrentMember.GolonganData.Title</a>
                <% end_if %>
                <% if $CurrentMember.Kwarcab.Title %>
                <a href="{$BaseHref}member" class="list-group-item list-group-item-action"><i class="fa-theme fa fa-home mr-2"></i> Kwarcab $CurrentMember.Kwarcab.getTitleShort()</a>
                <% end_if %>
              </div>
        </div>
    </div>
</div>
