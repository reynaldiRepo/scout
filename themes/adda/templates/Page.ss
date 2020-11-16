<!doctype html>
<html class="no-js" lang="en">

<head>
    <% base_tag %>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title><% if $MetaTitle %>$MetaTitle<% else %>$Title<% end_if %> &raquo; $SiteConfig.Title</title>
    <% include MetaTag %>

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <% include Resource %>
    <style>
        .bg-theme {
            background-color: #dc4734 !important;
        }

        .banner-user {
            display: flex;
            justify-content: center;
            padding-top: 100px;
            padding-bottom: 100px;
            background-position: center;
            background-size: cover;
            background-repeat: no-repeat;
            -webkit-box-shadow: 0px 1px 15px 0px rgba(51, 51, 51, 0.2);
            box-shadow: 0px 1px 15px 0px rgba(51, 51, 51, 0.2);
        }

        .banner-user img {
            position: absolute;
            bottom: 15px;
            height: 100px;
            width: 100px;
            background: #000;
            border-radius: 50%;
            cursor: pointer;
        }

        .edit-prof-btn {
            position: absolute;
            z-index: 1;
            top: 5px;
            right: 30px;
            padding: 5px;
            -webkit-box-shadow: 0px 1px 15px 0px rgba(51, 51, 51, 0.2);
            box-shadow: 0px 1px 15px 0px rgba(51, 51, 51, 0.2);
        }

        .fa-theme {
            color: #dc4734 !important
        }

        .btn-page {
            box-shadow: 0px 1px 15px 0px rgba(51, 51, 51, 0.2);
            border-radius: 0;
            margin-right: 3px
        }

        .nav-a {
            color: #333333 !important;
            display: block;
            font-size: 16px;
            font-weight: 700;
            line-height: 1;
            padding: 11px 0;
            text-transform: capitalize;
        }

        .nav-a a {
            color: #333333 !important;
        }

        .ss-single-selected {
            height: 40px !important
        }

        .loading {
            background-image: url("$SiteConfig.LoadingGif.URL");
            height: 100px;
            background-position: center;
            background-repeat: no-repeat;
        }

        .blockPage {
            top: 346.005px !important;
        }

    </style>

</head>

<body>

    <!-- header area start -->
    <% include Header %>
    <!-- header area end -->
    <!-- header area start -->
    <% include HeaderMobile %>
    <!-- header area end -->

    <main>

        <div class="main-wrapper pt-80">

            <%-- <div class="profile-banner-large bg-img" data-bg="$CurrentMember.getBannerImage.URL"
                style="background-image: url($CurrentMember.getBannerImage.URL)">
            </div> --%>

            <div class="container">
                <div class="row">
                    <div class="col-lg-3 order-2 order-lg-1">
                        <aside class="widget-area">
                            <% if $CurrentMember %>
                            <% include ProfileCard %>
                            <% end_if %>
                            <% if $CurrentMember %>
                            <% include Poeple %>
                            <% end_if %>
                        </aside>
                    </div>

                    $Layout

                    <div class="col-lg-3 order-3">
                        <aside class="widget-area">
                            <!-- widget single item start -->
                            <% if $CurrentMember %>
                            <% include UpcommingEvent %>
                            <% end_if %>
                            <% if $CurrentMember %>
                            <% include RecentEvent %>
                            <% end_if %>
                            <!-- widget single item end -->
                        </aside>
                    </div>
                </div>
            </div>
        </div>

    </main>

    <!-- Main JS -->
    <script src="$ThemeDir/javascript/main.js"></script>
    <script>
        $(document).ready(function () {
            $(".lightgallery").lightGallery();
        });

    </script>
</body>

</html>
