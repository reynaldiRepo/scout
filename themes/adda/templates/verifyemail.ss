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
                                        <h3 class="title">Email terverifikasi</h3>
                                        <br>
                                        <p>Hi $member.FirstName, Akun anda sudah aktif, silahkan untuk login dengan menekan link dibawah<br><br>    
                                        </p>
                                        <a href="{$BaseHref}member/login">Login</a>
                                        <hr>
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
</body>

</html>
