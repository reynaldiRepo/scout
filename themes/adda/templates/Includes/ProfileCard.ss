<div class="card card-profile widget-item p-0">
    <div class="profile-banner">
        <figure class="profile-banner-small">
            <a href="{$BaseHref}member">
                <% if $CurrentMember.BannerImage %>
                <img src="$CurrentMember.getBannerImage().Fill(800,300).URL" alt="">
                <% else %>
                <img src="$SiteConfig.DefaultPhotoBannerMember.Fill(800,300).URL" alt="">
                <% end_if %>
            </a>
            
            <a href="{$BaseHref}member" class="profile-thumb-2 bg-white">
                <img src="$CurrentMember.getPhotoProfile.Fill(80,80).URL" alt="">
            
            </a>
            
        </figure>
        <div class="profile-desc text-center">
            <h6 class="author"><a href="{$BaseHref}member">$CurrentMember.FirstName $CurrentMember.Surname </a></h6>
            <p>$CurrentMember.Bio</p>
        </div>
    </div>
</div>
