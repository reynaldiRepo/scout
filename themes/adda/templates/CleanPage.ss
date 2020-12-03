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
                    $Layout
                </div>
            </div>
        </div>

    </main>

    <!-- Main JS -->
    <script src="$ThemeDir/javascript/main.js?key=$getResourceV"></script>
    <script>
        $(document).ready(function () {
            $(".lightgallery").lightGallery();
            $(".slim-select").each(function () {
            new SlimSelect({
                    select: this
                })
            })
            $(".prev-content").each(function(){
                $(this).find("br").each(function(){
                    console.log("aa")
                    $(this).remove();
                })
            })
        });

        

    </script>
</body>

</html>
