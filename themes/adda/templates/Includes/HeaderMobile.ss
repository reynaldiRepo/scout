<header>
    <div class="mobile-header-wrapper sticky d-block d-lg-none">
        <div class="mobile-header position-relative ">
            <div class="mobile-logo bg-white">
                <a href="{$BaseHref}home/feed">
                    <img src="$SiteConfig.SmallWebLogo.ScaleHeight(42).Link" alt="logo">
                </a>
            </div>
            <div class="mobile-menu w-100">
                <ul>
                    <li class="nav-a"><a href="{$BaseHref}home/feed">Home</a></li>
                    <li class="nav-a"><a href="{$BaseHref}event/">Event</a></li>
                    <li class="nav-a"><a href="{$BaseHref}member/all">Anggota</a></li>
                    <li>
                        <button class="search-trigger sr-only">
                            <i class="search-icon flaticon-search"></i>
                            <i class="close-icon flaticon-cross-out"></i>
                        </button>
                        <div class="mob-search-box sr-only">
                            <form class="mob-search-inner" action="{$BaseHref}home/search">
                                <input type="text" placeholder="Search Here" name="Key" class="mob-search-field">
                                <button class="mob-search-btn"><i class="flaticon-search" type="submit"></i></button>
                            </form>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="mobile-header-profile bg-white">
                
                <!-- profile picture end -->
                <% if $CurrentMember %>
                <div class="profile-setting-box mr-2">
                    <a href="javascript:void(0)" class="notif-triger text-dark" style="background:unset">
                        <i class="fa fa-bell-o color-theme" style="font-size:24px"></i><span class="bg-warning" 
                            style="color: #fff;
                            padding: 4px 4px;
                            border-radius: 50%;
                            width: 20px;
                            height: 20px;
                            line-height: 12px;
                            font-size: 8px;
                            position: absolute;
                            right: 8px;
                            bottom: -4px;">$numberNotif</span>
                    </a>
                    <div class="notif-dropdown notif-dropdown-mobile">
                        <ul class="dropdown-msg-list pr-3 pl-3 pt-3">
                            <li class="msg-list-item d-flex">
                                <div class="profile-thumb  mr-2" style="width: 32px;height: 32px;">
                                    <a href="$MemberOnNotif.Link">
                                        <figure class="profile-thumb-middle" style="width: 32px;height: 32px;">
                                            <img src="$SiteConfig.SmallWebLogo.URL" alt="profile picture">
                                        </figure>
                                    </a>
                                </div>
                                <div class="notification-content text-dark">
                                    <a href="{$BaseHref}api-helper/seenotif?ID=$ID">
                                        $MemberOnNotif.FirstName $MemberOnNotif.Surname,
                                        <p>$Content.RAW</p>
                                    </a>
                                </div>
                            </li>
                        </ul>
                        <div class="msg-dropdown-footer pl-3 pr-3 pt-0 pb-3">
                            <button>See all notification</button>
                        </div>
                    </div>
                </div>
                <div class="profile-thumb profile-setting-box">
                    <a href="javascript:void(0)" class="profile-triger">
                        <figure class="profile-thumb-middle p-1 bg-dark" style="border-radius:50%">
                            <img src="$CurrentMember.getPhotoProfileThumb.URL" alt="profile picture">
                        </figure>
                    </a>
                    <div class="profile-dropdown text-left">
                        <div class="profile-head">
                            <h5 class="name"><a href="{$BaseHref}member">$CurrentMember.FirstName $CurrentMember.Surname</a></h5>
                            <a class="mail" href="{$BaseHref}member"><i class="flaticon-message"></i> $CurrentMember.Email</a>
                        </div>
                        <div class="profile-body">
                            <ul>
                                <li><a href="{$BaseHref}member"><i class="flaticon-user"></i>Profile</a></li>
                                <%-- <li><a href="{$BaseHref}member/activity"><i class="flaticon-document"></i>Activity</a></li> --%>
                            </ul>
                            <ul>
                                <li><a href="{$BaseHref}member/logout"><i class="flaticon-unlock"></i>Sing out</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <% end_if %>
                <!-- profile picture end -->
            </div>
        </div>
    </div>
</header>