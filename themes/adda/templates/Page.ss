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
            $(".close-div").click(function(){
                var process = $(this).attr("data-process");
                var div = $($(this).attr("data-target"))
                div.hide();
                if (process == 1){
                    var url = $(this).attr("data-url");
                    $.ajax({
                        url: url,
                        method: "GET"
                    }).done(function(data){
                        console.log(data)
                    }).fail(()=>{
                        console.log("Error")
                    })
                }
            })
            $(".btn-href").click(function(e){
                e.preventDefault();
                blockUI();
                location.href = $(this).attr("href")
            })
        });


      window.owl =  $(".owl-carousel").owlCarousel({
            dots: true,
            responsiveClass: true,
            responsive: {
                0: {
                    items: 1
                },
                600: {
                    items: 3
                },
                1000: {
                    items: 3
                }
            }
        });
        
    </script>
</body>

</html>
