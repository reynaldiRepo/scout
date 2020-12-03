<div class="col-lg-6 order-1 order-lg-2">
    <div class="card widget-item">
        <h4 class="widget-title mb-4">Notifikasi <i class="fa fa-bell-o"></i></h4>
        <div class="widget-body">
            <% loop $notif %>

            <div class="alert border d-flex">
                <a href="$MemberOnNotif.Link">
                    <figure class="profile-thumb-small mr-2">
                        <img src="$MemberOnNotif.getPhotoProfile.URL" alt="profile picture">
                    </figure>
                </a>
                <div>
                    <h6><a href="$MemberOnNotif.Link" class="text-dark"><b>$MemberOnNotif.FirstName $MemberOnNotif.Surname</b></a></h6>
                    <p>
                        $Content.RAW <a href="$Link">Read More</a>
                    </p>
                    <em><i class="fa fa-calendar mr-2"></i> $Created</em>
                </div>
            </div>
            <% end_loop %>
        </div>
    </div>
</div>

<div class="col-lg-12 text-center mt-3 mb-2">
    <div>
        <% if $notif.MoreThanOnePage %>
        <% if $notif.NotFirstPage %>
        <a class="prev btn-page p-1 pl-3 pr-3 bg-white btn" href="$notif.PrevLink"><i
                class="fa fa-caret-left"></i><i class="fa fa-caret-left"></i></a>
        <% end_if %>
        <% loop $notif.PaginationSummary %>
        <% if $CurrentBool %>
        <a class="btn-page p-1 pl-3 pr-3 bg-theme text-white btn">$PageNum</a>
        <% else %>
        <% if $Link %>
        <a href="$Link" class="btn-page p-1 pl-3 pr-3 bg-white btn">$PageNum</a>
        <% else %>
        ...
        <% end_if %>
        <% end_if %>
        <% end_loop %>
        <% if $notif.NotLastPage %>
        <a class="next btn-page p-1 pl-3 pr-3 bg-white btn" href="$notif.NextLink"><i
                class="fa fa-caret-right"></i><i class="fa fa-caret-right"></i></a>
        <% end_if %>
        <% end_if %>
    </div>
</div>
