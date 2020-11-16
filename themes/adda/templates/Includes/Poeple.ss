<div class="card widget-item">
    <h4 class="widget-title">Anggota Lainnya</h4>
    <div class="widget-body">
        <ul class="like-page-list-wrapper">
            <% if getRandomMember  %>
            <% loop getRandomMember %>
            <li class="unorder-list">
                <div class="profile-thumb">
                    <a href="$Link">
                        <figure class="profile-thumb-small">
                            <img src="$getPhotoProfileThumb.URL"
                                alt="profile picture">
                        </figure>
                    </a>
                </div>        
                <div class="unorder-list-info">
                    <h3 class="list-title"><a href="$Link">$FirstName $Surname</a></h3>
                    <p class="list-subtitle"><a href="$Link">$SakaData.Title</a></p>
                </div>
            </li>
            <% end_loop %>
            <% end_if %>
        </ul>
        <% if getRandomMember  %>
        <hr>
        <a href="{$BaseHref}member/all" class="text-dark">Lihat Lainnya...</a>
        <% else %>
        <a class="text-dark">Tidak Ada Data</a>
        <% end_if %>
    </div>
</div>
<!-- widget single item end -->
