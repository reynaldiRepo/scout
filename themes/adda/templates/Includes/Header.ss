<header>
	<div class="header-top sticky bg-white d-none d-lg-block">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-md-5">
					<!-- header top navigation start -->
					<div class="header-top-navigation">
						<nav>
							<ul>
								<li class="active"><a href="$BaseHref">Home</a></li>
								<li class="{$BaseHref}event/"><a href="$BaseHref">Event</a></li>
								<li class="{$BaseHref}member/all"><a href="$BaseHref">Anggota</a></li>
								<li class="{$BaseHref}news/"><a href="$BaseHref">News</a></li>
							</ul>
						</nav>
					</div>
					<!-- header top navigation start -->
				</div>

				<div class="col-md-2">
					<div class="brand-logo text-center">
						<a href="$BaseHref">
							<img src="$SiteConfig.WebLogo.ScaleHeight(42).Link" alt="brand logo">
						</a>
					</div>
				</div>

				<div class="col-md-5">
					<div class="header-top-right d-flex align-items-center justify-content-end">
						<!-- header top search start -->
						<div class="header-top-search">
							<form class="top-search-box" action="{$BaseHref}home/search">
								<input type="text" placeholder="Search" name="Key" class="top-search-field">
								<button class="top-search-btn" type="submit"><i class="flaticon-search"></i></button>
							</form>
						</div>
						
						<div class="profile-setting-box">
							<div class="profile-thumb-small">
								<a href="javascript:void(0)" class="profile-triger">
									<figure>
										<img src="$CurrentMember.getPhotoProfileThumb.URL"
											alt="profile picture">
									</figure>
								</a>
								<div class="profile-dropdown">
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
						</div>
						<!-- profile picture end -->
					</div>
				</div>
			</div>
		</div>
	</div>
</header>