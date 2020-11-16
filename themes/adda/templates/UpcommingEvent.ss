<div class="card widget-item">
    <h4 class="widget-title">Upcomming Event</h4>
    <div class="widget-body">
        <ul class="like-page-list-wrapper">
            <% if getUpcommingEvent %>
            <% loop getUpcommingEvent %>
            <li class="unorder-list mb-3">
            <div class="unorder-list-info p-0">
                    <h3 class="list-title"><a href="{$BaseHref}event/v/$ID-$getURLSegment">$Title</a></h3>
                    <p class="list-subtitle"><i class="fa fa-calendar-alt mr-1"></i> $Mulai.Format('d-M-Y')</p>
                </div>
            </li>
            <% end_loop %>
            <% end_if %>
        </ul>
        <% if getUpcommingEvent  %>
        <hr>
        <a href="{$BaseHref}event/all" class="text-dark">Lihat Lainnya...</a>
        <% else %>
        <a class="text-dark">Tidak Ada Data</a>
        <% end_if %>
    </div>
</div>