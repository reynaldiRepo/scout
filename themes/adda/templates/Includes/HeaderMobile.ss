<header>
    <div class="mobile-header-wrapper sticky d-block d-lg-none">
        <div class="mobile-header position-relative ">
            <div class="mobile-logo bg-white">
                <a href="$BaseHref">
                    <img src="$SiteConfig.SmallWebLogo.ScaleHeight(42).Link" alt="logo">
                </a>
            </div>
            <div class="mobile-menu w-100">
                <ul>
                    <li class="nav-a"><a href="$BaseHref">Home</a></li>
                    <li class="nav-a"><a href="{$BaseHref}event/">Event</a></li>
                    <li class="nav-a"><a href="{$BaseHref}member/all">Anggota</a></li>
                    <li>
                        <button class="search-trigger">
                            <i class="search-icon flaticon-search"></i>
                            <i class="close-icon flaticon-cross-out"></i>
                        </button>
                        <div class="mob-search-box">
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
                <div class="profile-thumb profile-setting-box">
                    <a href="javascript:void(0)" class="profile-triger">
                        <figure class="profile-thumb-middle p-1">
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
                                <li><a href="{$BaseHref}member/activity"><i class="flaticon-document"></i>Activity</a></li>
                            </ul>
                            <ul>
                                <li><a href="{$BaseHref}member/logout"><i class="flaticon-unlock"></i>Sing out</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- profile picture end -->
            </div>
        </div>
    </div>
</header>