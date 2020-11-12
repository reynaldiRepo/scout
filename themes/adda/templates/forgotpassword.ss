<html>

<head>
    <% base_tag %>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title><% if $MetaTitle %>$MetaTitle<% else %>$Title<% end_if %> &raquo; $SiteConfig.Title</title>
    <meta name="robots" content="noindex, follow" />
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <% include Resource %>

    <style>
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

<body class="bg-transparent">

    <main>
        <div class="main-wrapper pb-0 mb-3">
            <div class="timeline-wrapper">
                <div class="timeline-header">
                    <div class="container-fluid p-0">
                        <div class="row no-gutters align-items-center">
                            <div class="col-lg-3 mb-4"></div>
                            <div class="col-lg-6 mb-4 mt-3">
                                <div class="timeline-logo-area d-flex align-items-center">
                                    <div class="timeline-logo">
                                        <a href="$BaseHref">
                                            <img src="$SiteConfig.WebLogo.ScaleHeight(50).URL" alt="timeline logo">
                                        </a>
                                    </div>
                                    <div class="timeline-tagline">
                                        <h6 class="tagline">Kwartir Daerah Gerakan Pramuka Jawa Timur 2020</h6>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 mb-4"></div>
                        </div>
                    </div>
                </div>
                <div class="timeline-page-wrapper">
                    <div class="container-fluid p-0">
                        <div class="row no-gutters">
                            <div class="col-lg-3"></div>    
                            <div class="col-lg-6">
                                <div class="signup-form-wrapper">
                                    <div class="signup-inner text-center">
                                        <h3 class="title">RECOVERY PASSWORD</h3>
                                        <form class="signup-inner--form" id="form-recover" action ="{$Link}dosendlinkpwd" method="POST">
                                            <div class="row">
                                                <div class="p-1 col-12">
                                                    <input type="email" required name="Email" class="form-control"
                                                        placeholder="Email">
                                                </div>
                                                <div class="p-1 col-12">
                                                    <button class="submit-btn">Submit</button>
                                                </div>
                                            </div>
                                            <h6 class="terms-condition">We will send you email to recover your password</a></h6>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3"></div>    
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <!-- Main JS -->
    <script src="$ThemeDir/javascript/main.js"></script>

    <script>
        $(".slim-select").each(function () {
            new SlimSelect({
                select: this
            })
        })
    </script>

    <script>
        $("#form-recover").submit(function(e){
            e.preventDefault();
            var formData = new FormData(this)
            $.ajax({
                url: $(this).attr('action'),
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                beforeSend:function(){
                    blockUI();
                }
            }).done(function(data){
                $.unblockUI();
                console.log(data);
                data = JSON.parse(data)
                if (data.status == 200){
                    alertSuccess(data.msg);
                    setTimeout(function(){ location.href = "{$BaseHref}" }, 3000);
                }else{
                    alertWarning(data.msg);
                }
            }).fail(function(){
                alertError("ERROR");
            })
        })
    </script>
</body>

</html>
