<header>
    <div class="header-top sticky bg-white d-none d-lg-block">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-5">
                    <!-- header top navigation start -->
                    <div class="header-top-navigation">
                        <nav>
                            <ul>
                                <li class=""><a href="{$BaseHref}home/feed">Home</a></li>
                                <li class=""><a href="{$BaseHref}event/">Event</a></li>
                                <li class=""><a href="{$BaseHref}member/all">Anggota</a></li>
                            </ul>
                        </nav>
                    </div>
                    <!-- header top navigation start -->
                </div>

                <div class="col-md-2">
                    <div class="brand-logo text-center">
                        <a href="{$BaseHref}home/feed">
                            <img src="$SiteConfig.WebLogo.URL" alt="brand logo">
                        </a>
                    </div>
                </div>

                <div class="col-md-5">
                    <div class="header-top-right d-flex align-items-center justify-content-end">
						
						<% if $CurrentMember %>
						<div class="profile-setting-box mr-2">
                            <a href="javascript:void(0)" class="notif-triger text-dark" style="background:unset">
								<i class="fa fa-bell-o color-theme" style="font-size:24px"></i><span class="bg-warning" 
									style="color: #fff;
                                    padding: 3px 5px;
                                    border-radius: 50%;
                                    width: 20px;
                                    height: 20px;
                                    line-height: 20px;
                                    font-size: 12px;
                                    position: relative;
                                    right: 8px;
                                    bottom: -4px;">$numberNotif</span>
                            </a>
                            <div class="notif-dropdown">
                                <div class="dropdown-title p-3">
									<p class="recent-msg">Notification <i class="fa fa-bell-o"></i> ($numberNotif)</p>
								</div>
                                <ul class="dropdown-msg-list pr-3 pl-3">
                                    <% if getNotif %>
                                    <% loop $getNotif %>
									<li class="msg-list-item d-flex justify-content-between">
                                        <div class="profile-thumb">
                                            <a href="$MemberOnNotif.Link">
                                                <figure class="profile-thumb-middle">
                                                    <img src="$MemberOnNotif.getPhotoProfile.URL" alt="profile picture">
                                                </figure>
                                            </a>
										</div>
                                        <div class="msg-content notification-content">
                                            <a href="{$BaseHref}api-helper/seenotif?ID=$ID">
                                                $MemberOnNotif.FirstName $MemberOnNotif.Surname
                                                <p>$Content.RAW</p>
                                            </a>
										</div>
										<div class="msg-time">
											<p>$Created.Format("dd-MM-YYYY")</p>
										</div>
                                    </li>
                                    <% end_loop %>
                                    <% else %>
                                    <li class="msg-list-item d-flex justify-content-between">
                                        <div class="msg-content notification-content">
                                            <p>Tidak ada notifikasi untuk anda</p>
                                        </div>
                                    </li>
                                    <% end_if %>
								</ul>
								<div class="msg-dropdown-footer  pl-3 pr-3 pt-0 pb-3">
									<button>See all notification</button>
								</div>
                            </div>
                        </div>

                        
                        <div class="profile-setting-box">
                            <div class="profile-thumb-small">
                                <a href="javascript:void(0)" class="profile-triger">
                                    <figure>
                                        <img src="$CurrentMember.getPhotoProfileThumb.URL" alt="profile picture">
                                    </figure>
                                </a>
                                <div class="profile-dropdown">
                                    <div class="profile-head">
                                        <h5 class="name"><a href="{$BaseHref}member">$CurrentMember.FirstName
                                                $CurrentMember.Surname</a></h5>
                                        <a class="mail" href="{$BaseHref}member"><i class="flaticon-message"></i>
                                            $CurrentMember.Email</a>
                                    </div>
                                    <div class="profile-body">
                                        <ul>
                                            <li><a href="{$BaseHref}member"><i class="flaticon-user"></i>Profile</a>
                                            </li>
                                            <%-- <li><a href="{$BaseHref}member/activity"><i class="flaticon-document"></i>Activity</a></li> --%>
                                        </ul>
                                        <ul>
                                            <li><a href="{$BaseHref}member/logout"><i class="flaticon-unlock"></i>Sing
                                                    out</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% end_if %>
                        <!-- profile picture end -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
