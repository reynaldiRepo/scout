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
        <div class="main-wrapper pb-0 mb-0">
            <div class="timeline-wrapper">
                <div class="timeline-header">
                    <div class="container-fluid p-0">
                        <div class="row no-gutters align-items-center">
                            <div class="col-lg-6">
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
                            <div class="col-lg-6">
                                <div class="login-area">
                                    <form action="{$Link}dologin" id="form-login" method="POST">
                                        <div class="row align-items-center">
                                            <div class="col-12 col-sm">
                                                <input type="email" name="Email" required placeholder="Email" class="form-control">
                                            </div>
                                            <div class="col-12 col-sm">
                                                <input type="password" name="Password" required placeholder="Password" class="form-control">
                                            </div>
                                            <div class="col-12 col-sm-auto">
                                                <button class="login-btn" type="submit">Login</button>
                                            </div>
                                            <div class="col-12 col-sm-auto">
                                                <a href="{$BaseHref}member/forgotpassword" class="text-white"
                                                    style="text-decoration: revert;">Lupa Password ?</a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="timeline-page-wrapper">
                    <div class="container-fluid p-0">
                        <div class="row no-gutters">
                            <div class="col-lg-6 order-2 order-lg-1">
                                <div class="timeline-bg-content bg-img"
                                    data-bg="https://dkdjatim.or.id/wp-content/uploads/2020/11/MG_3358_copy-1140x570.jpg">
                                    <h3 style="background: rgba(255,0,0,0.5);padding: 10px;" class="timeline-bg-title">
                                        Kwartir Daerah Gerakan Pramuka Jawa Timur 2020</h3>
                                </div>
                            </div>
                            <div class="col-lg-6 order-1 order-lg-2 d-flex align-items-center justify-content-center">
                                <div class="signup-form-wrapper">
                                    <div class="signup-inner text-center">
                                        <h3 class="title">DAFTAR PERANSAKA DKDJATIM</h3>
                                        <form class="signup-inner--form" id="form-register" action ="{$Link}doregister" method="POST">
                                            <div class="row">
                                                <div class="p-2 col-12">
                                                    <input type="email" required name="Email" class="form-control"
                                                        placeholder="Email">
                                                </div>
                                                <div class="p-2 col-md-6">
                                                    <input type="text" required name="FirstName" class="form-control"
                                                        placeholder="First Name">
                                                </div>
                                                <div class="p-2 col-md-6">
                                                    <input type="text" required name="Surname" class="form-control"
                                                        placeholder="Last Name">
                                                </div>
                                                <div class="p-2 col-12">
                                                    <input type="password" required name="Password" class="form-control"
                                                        placeholder="Password">
                                                </div>
                                                <div class="p-2 col-md-6">
                                                    <select class="slim-select" required name="SakaDataID">
                                                        <option value="">Pilih Saka</option>
                                                        <% loop $getSaka %>
                                                        <option value="$ID">$Title</option>
                                                        <% end_loop %>
                                                    </select>
                                                </div>
                                                <div class="p-2 col-md-6">
                                                    <select class="slim-select" required name="KwarcabID">
                                                        <option value="">Pilih Kwarcab</option>
                                                        <% loop $getKabupatenJatim %>
                                                        <option value="$ID">$Title</option>
                                                        <% end_loop %>
                                                    </select>
                                                </div>
                                                
                                                <div class="p-2 col-md-6">
                                                    <select class="slim-select" required name="GolonganDataID">
                                                        <option value="">Pilih Golongan</option>
                                                        <% loop $getGolongan %>
                                                        <option value="$ID">$Title</option>
                                                        <% end_loop %>
                                                    </select>
                                                </div>

                                                <div class="p-2 col-6">
                                                    <input type="text" required name="NTA_SIPA" class="form-control"
                                                        placeholder="NTA SIPA">
                                                </div>
                                                
                                                <div class="p-2 col-12">
                                                    <button class="submit-btn">Submit</button>
                                                </div>
                                            </div>
                                            <h6 class="terms-condition">I have read & accepted the <a href="#">terms of
                                                    use</a></h6>
                                        </form>
                                    </div>
                                </div>
                            </div>
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
        $("#form-login").submit(function(e){
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
                    alertSuccess("Login Success");
                    location.href = "{$BaseHref}"
                }else{
                    alertWarning(data.msg);
                }
            }).fail(function(){
                alertError("ERROR");
            })
        })

        $("#form-register").submit(function(e){
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
                    setTimeout(function(){ location.reload() }, 7000);
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
