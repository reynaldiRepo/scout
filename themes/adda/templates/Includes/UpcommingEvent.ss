<div class="card widget-item xs-hidden">
    <h4 class="widget-title">Upcomming Event <i class="fa fa-bell-o ml-2"></i></h4>
    <div class="widget-body">
        <ul class="like-page-list-wrapper">
            <% if getUpcommingEvent %>
            <% loop getUpcommingEvent %>
            <li class="unorder-list mb-3">
            <div class="unorder-list-info p-0">
                    <h3 class="list-title"><a href="$Link">$Title</a></h3>
                    <p class="list-subtitle"><i class="fa fa-calendar mr-1"></i> $Mulai.Format('dd-M-Y')</p>
                </div>
            </li>
            <% end_loop %>
            <% end_if %>
        </ul>
        <% if getUpcommingEvent  %>
        <hr>
        <a href="{$BaseHref}event/" class="text-dark">Lihat Lainnya...</a>
        <% else %>
        <a class="text-dark">Tidak Ada Data</a>
        <% end_if %>
    </div>
</div>