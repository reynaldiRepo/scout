<div class="col-lg-6 order-1 order-lg-2">


    <div class="col-lg-12 d-flex p-0 text-center mb-3 shadowed">
        <button class="submit-btn m-0 btn-href" href="{$BaseHref}home/feed">Feed Anggota</button>
        <button class="submit-btn m-0  bg-dark btn-href" href="{$BaseHref}home/dashboard">Event</button>
    </div>

    <% include NewFeedForm %>

    <!-- post status start -->

    <% if $Feed %>
    <div id="feed-ctr">
        <% loop $Feed %>
        <% include CardFeed %>
        <% end_loop %>

    </div>
    <div class="col-lg-12 text-center p-0 mt-2" id="loader-feed">
        &nbsp
    </div>
    <div class="col-lg-12 text-center alert alert-info mt-3" id="end-feed">
        End of data
    </div>

    <button class="submit-btn" id="load-more-btn" data-url=""> Load More </button>

    <% else %>
    <div class="card">
        <div class="post-title d-flex align-items-center">
            <div class="post-content">
                <div class="alert alert-warning">Feed Peransaka Masih Kosong mari bagi ceritamu kepada seluruh teman
                    peransaka</div>
                <p class="post-desc">
                    <img src="https://www.genx.ae/resources/assets/frontend/img/nodatafound.png"
                        class="img-fluid w-100">
                </p>
            </div>
        </div>
    </div>
    <% end_if %>
</div>


<script>
    window.loadmoreCtr = $("#load-more-ctr");
    window.loadmoreBtn = $("#load-more-btn");
    window.loader = $("#loader-feed")
    window.endFeed = $("#end-feed");
    window.feedCtr = $("#feed-ctr");
    window.endload = false;
    window.loadstate = false;
    window.start = $startPage

    loader.hide();
    endFeed.hide();
    loadmoreBtn.hide();



    function loadfeed(Url = null) {
        Url = Url == null ? "{$BaseHref}api-helper/getfeed"+"?start=" + start + "&count=10" : Url;
        $.ajax({
            method: "GET",
            url: Url,
            beforeSend: function () {
                loader.show();
            }
        }).done(function (data) {
            window.loadstate = false;
            try {
                data = JSON.parse(data);
                if (data.status == 200) {
                    window.start += 10;
                    window.history.pushState("", "", '{$BaseHref}home/feed?Start=0&Count=' + start);
                    realData = JSON.parse(data.data);
                    realData.forEach(data => {
                        feedCtr.append(data.cardAdda)
                    })
                    window.owl.trigger('refresh.owl.carousel');
                }
                if (data.status == 417) {
                    endload = true;
                    window.loadstate = true;
                    window.history.pushState("", "", '{$BaseHref}home/feed?Start=0&Count=' + start);
                }
            } catch (e) {
                window.loadstate = true;
                loader.hide();
                loadmoreBtn.show();
                loadmoreBtn.attr("data-url", "{$BaseHref}home/feed?Start="+ start + "&Count=10")
            }
            console.log(data)
        }).fail(function () {
            window.loadstate = true;
            loader.hide();
            loadmoreBtn.show();
            loadmoreBtn.attr("data-url", "{$BaseHref}home/feed?Start="+ start + "&Count=10")
        })
    }

    loadmoreBtn.click(function(){
        loadmoreBtn.hide();
        window.loadstate = false;
        window.scrollBy(0,-50)
        loadfeed($(this).attr("data-url"))
    })


    $(window).scroll(function () {
        if ($(window).scrollTop() + $(window).height() > $(document).height() - 30) {
            if (endload == false && loadstate == false) {
                loadstate = true;
                loadfeed();
            } else if (endload == true) {
                loader.hide();
                endFeed.show();
            }
        }
    });

</script>


<%-- for like and comment --%>
<script>
    $(".like-btn").click(function(){
        var id = $(this).attr("data-ID")
        var numcomment = parseInt($("#num-like-"+id).text());
        var icon = $("#icon-like-"+id);
        $.ajax({
            url:"{$BaseHref}api-helper/likefeed",
            data: {'FeedDataID':id}
        }).done(function(data){
            data = JSON.parse(data)
            if (data.status == 200){
                //success like
                icon.attr('class', 'fa fa-heart color-theme');
                numcomment += 1;
                $("#num-like-"+id).text(numcomment);
            }else if(data.status == 205){
                icon.attr('class', 'fa fa-heart-o color-theme');
                numcomment -= 1;
                $("#num-like-"+id).text(numcomment);
            }else{
                console.log(data);
            }
        }).fail(function(){
            console.log(data);
        })
    })


    $(".comment-btn").click(function(){
        //<iframe src="{$BaseHref}feed/comment?FeedDataID={$ID}" width="100%" height="500" frameBorder="0"></iframe>
        var id = $(this).attr("data-ID")
        var ctr = $("#comment-frame-"+id)
        var isopen = $(this).attr("data-frame-open");
        if (isopen == "0"){
            $(this).attr("data-frame-open", "1");
            ctr.append("<iframe src='{$BaseHref}feed/comment?FeedDataID="+id+"' width='100%' height='650' frameBorder='0'></iframe>")
        }else{
            $(this).attr("data-frame-open", "0");
            ctr.find("iframe").first().remove();
        }
    })
</script>