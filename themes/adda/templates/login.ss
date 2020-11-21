<html>

<head>
    <% base_tag %>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title><% if $MetaTitle %>$MetaTitle<% else %>$Title<% end_if %> &raquo; $SiteConfig.Title</title>
    <meta name="robots" content="noindex, follow" />
    <% include MetaTag %>
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

        .timeline-page-wrapper {
            background: #fff
        }

        .title-login {
            display: unset !important
        }

        .btn-mobile-login {
            display: none !important
        }

        @media (max-width: 767.98px) {
            .timeline-page-wrapper {
                background-image: url("$SiteConfig.ImageOnLoginPage.URL");
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                height: 100% !important;
                overflow-y: scroll !important
            }

            .title-login {
                display: none !important
            }

            .btn-mobile-login {
                display: flex !important
            }
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
                                    <div class="timeline-logo timeline-logo-big">
                                        <a href="$BaseHref">
                                            <img src="$SiteConfig.WebLogo.ScaleHeight(50).URL" alt="timeline logo">
                                        </a>
                                    </div>
                                    <div class="timeline-logo timeline-logo-small">
                                        <a href="$BaseHref">
                                            <img src="$SiteConfig.SmallWebLogo.ScaleHeight(50).URL" alt="timeline logo">
                                        </a>
                                    </div>
                                    <div class="timeline-tagline">
                                        <h6 class="tagline">Kwartir Daerah Gerakan Pramuka Jawa Timur 2020</h6>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 login-ctr">
                                <div class="login-area">
                                    <form action="{$Link}dologin" id="form-login" method="POST">
                                        <div class="row align-items-center">
                                            <div class="col-12 col-sm p-0 pl-2 pt-2">
                                                <input type="email" name="Email" required placeholder="Email"
                                                    class="form-control">
                                            </div>
                                            <div class="col-12 col-sm p-0 pl-2 pt-2">
                                                <input type="password" name="Password" required placeholder="Password"
                                                    class="form-control">
                                            </div>
                                            <div class="col-12 col-sm-auto p-0 pl-2 pt-2">
                                                <button class="login-btn" type="submit">Login</button>
                                            </div>
                                            <div class="col-12 col-sm-auto p-0 pl-2 pt-2">
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
                            <div class="col-lg-6 order-2 order-lg-1 bg-theme">
                                <div class="timeline-bg-content bg-img" data-bg="$SiteConfig.ImageOnLoginPage.URL">
                                    <h3 style="background: rgba(255,0,0,0.5);padding: 10px;" class="timeline-bg-title">
                                        Kwartir Daerah Gerakan Pramuka Jawa Timur 2020</h3>
                                </div>
                            </div>
                            <div class="col-lg-6 order-1 order-lg-2 d-flex align-items-center justify-content-center">
                                <div class="signup-form-wrapper mt-3">
                                    <div class="signup-inner bg-white">
                                        <div class="col-md-12 p-0 m-0 d-flex btn-mobile-login">
                                            <button class="submit-btn bg-theme m-0" id="btn-login2">Login</button>
                                            <button class="submit-btn bg-dark m-0" id="btn-register">Registrasi</button>
                                        </div>
                                        <div class="text-center title-login">
                                            <h3 class="title">DAFTAR PERANSAKA DKDJATIM</h3>
                                        </div>

                                        <form class="p-3 pl-5 pr-5 pb-4" id="form-register" action="{$Link}doregister"
                                            method="POST">
                                            <div class="row">
                                                <div class="p-1 col-12">
                                                    <label>Email</label>
                                                    <input type="email" required name="Email" class="form-control"
                                                        placeholder="Email">
                                                </div>
                                                <div class="p-1 col-md-6">
                                                    <label>Nama Depan</label>
                                                    <input type="text" required name="FirstName" class="form-control"
                                                        placeholder="First Name">
                                                </div>
                                                <div class="p-1 col-md-6">
                                                    <label>Nama Belakang</label>
                                                    <input type="text" required name="Surname" class="form-control"
                                                        placeholder="Last Name">
                                                </div>
                                                <div class="p-1 col-12">
                                                    <label>Password</label>
                                                    <input type="password" required name="Password" class="form-control"
                                                        placeholder="Password">
                                                </div>
                                                <div class="p-1 col-12">
                                                    <label>Konfirmasi Password</label>
                                                    <input type="password" required name="Password2"
                                                        class="form-control" placeholder="Konfirmasi Password">
                                                </div>
                                                <div class="p-1 col-md-6">
                                                    <label>Saka</label>
                                                    <select class="slim-select" required name="SakaDataID">
                                                        <% loop $getSaka %>
                                                        <option value="$ID">$Title</option>
                                                        <% end_loop %>
                                                    </select>
                                                </div>
                                                <div class="p-1 col-md-6">
                                                    <label>Kwarcab</label>
                                                    <select class="slim-select" required name="KwarcabID">
                                                        <% loop $getKabupatenJatim %>
                                                        <option value="$ID">$Title</option>
                                                        <% end_loop %>
                                                    </select>
                                                </div>

                                                <div class="p-1 col-md-6">
                                                    <label>Golongan</label>
                                                    <select class="slim-select" required name="GolonganDataID">
                                                        <% loop $getGolongan %>
                                                        <option value="$ID">$Title</option>
                                                        <% end_loop %>
                                                    </select>
                                                </div>

                                                <div class="p-1 col-md-6">
                                                    <label>NTA SIPA</label>
                                                    <input type="text" required name="NTA_SIPA" class="form-control"
                                                        placeholder="NTA SIPA">
                                                </div>

                                                <div class="p-0 m-0 col-12">
                                                    <button class="submit-btn">Registrasi</button>
                                                </div>
                                            </div>
                                        </form>

                                        <form class="p-3 pl-5 pr-5 pb-4" id="form-login2" action="{$Link}dologin"
                                            method="POST">
                                            <div class="row">
                                                <div class="col-12 p-1">
                                                    <label>Email</label>
                                                    <input type="email" name="Email" required placeholder="Email"
                                                        class="form-control">
                                                </div>
                                                <div class="col-12 p-1">
                                                    <label>Password</label>
                                                    <input type="password" name="Password" required
                                                        placeholder="Password" class="form-control">
                                                </div>
                                                <div class="col-12 p-1">
                                                    <button class="submit-btn mb-2" type="submit">Login</button>
                                                    <a href="{$BaseHref}member/forgotpassword" class="text-dark mt-2"
                                                        style="text-decoration: revert;">Lupa Password ?</a>
                                                </div>
                                            </div>
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
        $("#form-login, #form-login2").submit(function (e) {
            e.preventDefault();
            var formData = new FormData(this)
            $.ajax({
                url: $(this).attr('action'),
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                beforeSend: function () {
                    blockUI();
                }
            }).done(function (data) {
                $.unblockUI();
                console.log(data);
                data = JSON.parse(data)
                if (data.status == 200) {
                    alertSuccess("Login Success");
                    location.reload();
                } else {
                    alertWarning(data.msg);
                }
            }).fail(function () {
                alertError("ERROR");
            })
        })

        $("#form-register").submit(function (e) {
            e.preventDefault();
            var formData = new FormData(this)
            $.ajax({
                url: $(this).attr('action'),
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                beforeSend: function () {
                    blockUI();
                }
            }).done(function (data) {
                $.unblockUI();
                console.log(data);
                data = JSON.parse(data)
                if (data.status == 200) {
                    alertSuccess(data.msg);
                    $('input').val('');
                    $('option').attr('selected', false);
                } else {
                    alertWarning(data.msg);
                }
            }).fail(function () {
                $.unblockUI();
                alertError("ERROR");
            })
        })

    </script>

    <script>
        var formlogin2 = $("#form-login2");
        var formregister = $("#form-register");
        var btnregister = $("#btn-register");
        var btnlogin2 = $("#btn-login2");
        if ($(window).width() <= 767.98) {
            if (btnlogin2.hasClass("bg-theme")) {
                formregister.hide();
                formlogin2.show();
            }
        } else {
            formlogin2.hide();
            formregister.show();
        }
        $(window).resize(function () {
            if ($(window).width() <= 767.98) {
                if (btnlogin2.hasClass("bg-theme")) {
                    formregister.hide()
                    formlogin2.show();
                }
            } else {
                formlogin2.hide();
                formregister.show();
            }
        })
        btnregister.click(function () {
            formlogin2.hide()
            formregister.show()
            btnregister.addClass("bg-theme").removeClass("bg-dark")
            btnlogin2.addClass("bg-dark").removeClass("bg-theme")
        })
        btnlogin2.click(function () {
            formlogin2.show()
            formregister.hide()
            btnregister.addClass("bg-dark").removeClass("bg-theme")
            btnlogin2.addClass("bg-theme").removeClass("bg-dark")
        })

    </script>

</body>

</html>
