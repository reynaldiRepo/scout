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
						
						<div class="profile-setting-box mr-2">
                            <a href="javascript:void(0)" class="notif-triger text-dark" style="background:unset">
								<i class="fa fa-bell-o color-theme" style="font-size:24px"></i><span class="bg-warning" 
									style="color: #fff;
									padding: 4px 4px;
									border-radius: 50%;
									width: 10px;
									height: 10px;
									font-size: 10px;
									position: relative;
									right: 9px;">10</span>
                            </a>
                            <div class="notif-dropdown">
                                <div class="dropdown-title p-3">
									<p class="recent-msg">Notification <i class="fa fa-bell-o"></i> (10)</p>
								</div>
                                <ul class="dropdown-msg-list pr-3 pl-3">
									<li class="msg-list-item d-flex justify-content-between">
										<div class="profile-thumb">
											<figure class="profile-thumb-middle">
												<img src="$SiteConfig.SmallWebLogo.URL" alt="profile picture">
											</figure>
										</div>
										<div class="msg-content notification-content">
											<a href="profile.html">Robert Faul</a>,
											<a href="profile.html">william jhon</a>
											<p>and 35 other people reacted to your photo</p>
										</div>
										<div class="msg-time">
											<p>25 Apr 2019</p>
										</div>
									</li>
								</ul>
								<div class="msg-dropdown-footer  pl-3 pr-3 pt-0 pb-3">
									<button>See all notification</button>
								</div>
                            </div>
                        </div>

                        <% if $CurrentMember %>
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
