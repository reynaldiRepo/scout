<div class="col-lg-6 order-1 order-lg-2">


    <div class="col-lg-12 d-flex p-0 text-center mb-3 shadowed">
        <button class="submit-btn m-0 btn-href" href="{$BaseHref}home/feed">Feed Anggota</button>
        <button class="submit-btn m-0  bg-dark btn-href" href="{$BaseHref}home/dashboard">Event</button>
    </div>

    <% include NewFeedForm %>

    <!-- post status start -->
    <% if $Feed %>
    <% loop $Feed %>
    <% include CardFeed %>
    <% end_loop %>
    <% else %>

    <% end_if %>
    <!-- post status end -->
</div>

<script>
    $(".owl-carousel").owlCarousel({
        dots:true,
        responsiveClass:true,
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
