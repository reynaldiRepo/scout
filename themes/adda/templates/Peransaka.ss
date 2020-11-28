<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="icon" href="https://cdn.dkdjatim.or.id/peran-saka-2020/png/colored/icon.png" />

    <!-- Primary Meta Tags -->
    <title>Peran SAKA Jawa Timur 2020</title>
    <meta name="title" content="Peran SAKA Jawa Timur 2020">
    <meta name="description"
        content="Official website dan Pusat Informasi Peran Saka Daerah Jawa Timur Tahun 2020 - Dikelola oleh DKD Jatim">

    <!-- Open Graph / Facebook -->
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://peransaka.dkdjatim.or.id/">
    <meta property="og:title" content="Peran SAKA Jawa Timur 2020">
    <meta property="og:description"
        content="Official website dan Pusat Informasi Peran Saka Daerah Jawa Timur Tahun 2020 - Dikelola oleh DKD Jatim">
    <meta property="og:image" content="https://cdn.dkdjatim.or.id/peran-saka-2020/png/colored/logo-horizontal.png">

    <!-- Twitter -->
    <meta property="twitter:card" content="summary_large_image">
    <meta property="twitter:url" content="https://peransaka.dkdjatim.or.id/">
    <meta property="twitter:title" content="Peran SAKA Jawa Timur 2020">
    <meta property="twitter:description"
        content="Official website dan Pusat Informasi Peran Saka Daerah Jawa Timur Tahun 2020 - Dikelola oleh DKD Jatim">
    <meta property="twitter:image" content="https://cdn.dkdjatim.or.id/peran-saka-2020/png/colored/logo-horizontal.png">

    <link href="https://fonts.googleapis.com/css2?family=Nunito&family=Poppins&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="$ThemeDir/peransaka/css/core.css">
    <link rel="stylesheet" href="$ThemeDir/peransaka/assets/modules/owl/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="$ThemeDir/peransaka/assets/modules/sweetalert/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
        integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA=="
        crossorigin="anonymous" />
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-N1CDZLLSEJ"></script>
    <script>
        window.dataLayer = window.dataLayer || [];

        function gtag() {
            dataLayer.push(arguments);
        }
        gtag('js', new Date());

        gtag('config', 'G-N1CDZLLSEJ');

    </script>
</head>

<body>
    <header id="main-header" class="pb-5">

        <nav class="navigation">
            <div class="container align-items-center">
                <div class="d-flex align-items-center justify-content-between">
                    <a href="https://www.dkdjatim.or.id" class="d-flex align-items-center">
                        <img src="https://cdn.dkdjatim.or.id/peran-saka-2020/png/colored/logo-vertical.png" class="py-2"
                            style="height: 50px!important; width: auto!important" />
                    </a>
                    <div class="btn-group btn-group-sm d-lg-none align-items-center">
                        <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#navbar-navs"
                            aria-expanded="false" aria-controls="navbar-navs">
                            <i class="fas fa-bars"></i>
                        </button>
                        <div class="btn-group none">
                            <a class="btn btn-link dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-sign-in"></i>
                            </a>

                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuLink">
                                <a class="dropdown-item" href="{$BaseHref}member/login">Masuk Anggota</a>
                                <a class="dropdown-item" href="{$BaseHref}member/login">Mendaftar</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="nav-menus collapse show" id="navbar-navs">
                    <ul class="nav float-lg-right justify-content-center">
                        <li class="nav-item">
                            <a class="nav-link active" href="{$BaseHref}home/feed"><i class="fas fa-home"></i></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#about">Satuan Karya</a>
                        </li>
                        <% if $CurrentMember %>
                        <li class="nav-item">
                            <a class="nav-link" href="{$BaseHref}home/feed">Dashboard</a>
                        </li>
                        <% else %>
                        <li class="nav-item">
                            <a class="nav-link" href="{$BaseHref}member/login">Masuk / Daftar</a>
                        </li>
                        <% end_if %>
                    </ul>
                </div>
                <% if not $CurrentMember %>
                
                <% else %>
                <div class="dropdown none d-md-none d-none d-lg-inline">
                    <a class="btn btn-link dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="mr-2">Hi $CurrentMember.FirstName</span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item" href="{$BaseHref}member/">Profile</a>
                        <a class="dropdown-item" href="{$BaseHref}member/logout">Logout</a>
                    </div>
                </div>
                <% end_if %>
            </div>
        </nav>
        <div class="container py-5" id="heading-page">
            <div class="row">
                <div class="col-md-6">
                    <h1 class="title"><span class="text-info">Peran</span> SAKA</h1>
                    <!-- <p class="overlay">Perkemahan Antar SAKA<label class="ml-2 badge badge-info">DARING</label></p> -->
                    <p class="mb-3 mb-md-5">Kwartir Daerah Gerakan Pramuka Jawa Timur 2020</p>
                    <a href="#about" class="btn btn-lg btn-primary">Selengkapnya<i
                            class="ml-3 fas fa-arrow-right"></i></a>
                </div>
                <div class="col-md-6 mt-5 mt-md-0">
                    <img src="$ThemeDir/peransaka/assets/hero-min.png" alt="" class="img-fluid" />
                </div>
            </div>
        </div>
    </header>

    <section id="about" class="my-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">

                    <img src="https://cdn.dkdjatim.or.id/peran-saka-2020/svg/colored/logo-vertical.svg"
                        class="img-thumbnail p-3 mb-3" />

                </div>
                <div class="col-md-6">
                    <h2>Apa Itu Peran SAKA?</h2>
                    <p class="lead">Peran SAKA merupakan singkatan dari Perkemahan
                        Antar Satuan Karya (SAKA) yang mana merupakan perkemahan besar
                        melibatkan semua unsur Satuan Karya yang ada di suatu wilayah.
                        Namun karena situasi pandemi yang masih mewabah, kegiatan Peran
                        SAKA kali ini dihadirkan dalam konsep yang berbeda.</p>

                    <p class="lead">Peran Saka Daerah Jatim, secara garis besar akan
                        digelar secara dalam jaringan (daring). Ada berbagai kegiatan
                        yang nantinya dapat diikuti oleh peserta, mulai dari webinar tentang
                        Kesakaan, pendalaman krida, praktik krida, lomba-lomba,
                        dan ada pertandingan E-Sport juga lho...</p>

                    <h2>Siapakan dirimu!</h2>
                </div>
            </div>
        </div>
    </section>

    <section id="list-saka" class="bg-dark mt-5 pt-5">
        <div class="container">
            <h3 class="section-header white my-5">
                <span class="text-white">Satuan Karya di Jawa Timur</span>
            </h3>

            <div class="row justify-content-center">
                <div class="col-6 col-md-3 mb-3">
                    <div class="card border-0 card-body text-center">
                        <img src="$ThemeDir/peransaka/assets/saka-bhayangkara.png" class="img-fluid"
                            alt="SAKA Bhayangkara" />
                        <button class="btn btn-primary"
                            onclick="Swal.fire({text: 'Saka Bhayangkara adalah Satuan Karya yang berada di bawah pembinaan Kepolisian Negara Republik Indonesia, Disamping itu Saka Bhayangkara merupakan Saka terbesar dan paling berkembang di Indonesia.',imageUrl: '$ThemeDir/peransaka/assets/saka-bhayangkara.png', imageAlt: 'Saka Bhayangkara', title: 'Satuan Karya Pramuka<br/>Bhayangkara',  imageHeight: 200, imageWidth: 200});">Detail</button>
                    </div>
                </div>
                <div class="col-6 col-md-3 mb-3">
                    <div class="card border-0 card-body text-center">
                        <img src="$ThemeDir/peransaka/assets/saka-dirgantara.png" class="img-fluid"
                            alt="SAKA Dirgantara" />
                        <button class="btn btn-primary"
                            onclick="Swal.fire({text: 'Satuan Karya Pramuka Dirgantara adalah wadah kegiatan untuk meningkatkan pengetahuan dan keterampilan praktis di bidang kedirgantaraan guna menumbuhkan kesadaran untuk membaktikan dirinya dalam pembangunan nasional.',imageUrl: '$ThemeDir/peransaka/assets/saka-dirgantara.png', imageAlt: 'Saka Dirgantara', title: 'Satuan Karya Pramuka<br/>Dirgantara',  imageHeight: 200, imageWidth: 200});">Detail</button>
                    </div>
                </div>
                <div class="col-6 col-md-3 mb-3">
                    <div class="card border-0 card-body text-center">
                        <img src="$ThemeDir/peransaka/assets/saka-wirakartika.png" class="img-fluid"
                            alt="SAKA Wanabakti" />
                        <button class="btn btn-primary"
                            onclick="Swal.fire({text: 'Saka atau Satuan Karya Pramuka Wira Kartika merupakan salah satu Satuan Karya Pramuka yang bersifat nasional. Saka yang dibentuk lewat kerjasama antara Kwartir Nasional dengan TNI Angkatan Darat ini bertujuan untuk mengembangkan pendidikan bela negara.',imageUrl: '$ThemeDir/peransaka/assets/saka-wirakartika.png', imageAlt: 'Saka Wira Kartika', title: 'Satuan Karya Pramuka<br/>Wira Kartika',  imageHeight: 200, imageWidth: 200});">Detail</button>
                    </div>
                </div>
                <div class="col-6 col-md-3 mb-3">
                    <div class="card border-0 card-body text-center">
                        <img src="$ThemeDir/peransaka/assets/saka-wanabakti.png" class="img-fluid"
                            alt="SAKA Wanabakti" />
                        <button class="btn btn-primary"
                            onclick="Swal.fire({text: 'Satuan Karya Pramuka (Saka) Wanabakti adalah Satuan Karya dalam Gerakan Pramuka Indonesia yang memberikan bekal pengetahuan dan ketrampilan khusus di bidang kehutanan dan lingkungan hidup serta menanamkan rasa cinta dan tanggung jawab dalam mengelola sumberdaya alam.',imageUrl: '$ThemeDir/peransaka/assets/saka-wanabakti.png', imageAlt: 'Saka Wanabakti', title: 'Satuan Karya Pramuka<br/>Wanabakti',  imageHeight: 200, imageWidth: 200});">Detail</button>
                    </div>
                </div>
                <div class="col-6 col-md-3 mb-3">
                    <div class="card border-0 card-body text-center">
                        <img src="$ThemeDir/peransaka/assets/saka-bakti-husada.png" class="img-fluid"
                            alt="SAKA Bakti Husada" />
                        <button class="btn btn-primary"
                            onclick="Swal.fire({text: 'Satuan Karya Pramuka Bakti Husada disingkat Saka Bakti Husada adalah wadah pengembangan pengetahuan, pembinaan keterampilan, penambahan pengalaman dan pemberian kesempatan untuk membaktikan dirinya kepada masyarakat dalam bidang kesehatan.',imageUrl: '$ThemeDir/peransaka/assets/saka-bakti-husada.png', imageAlt: 'Saka Bakti Husada', title: 'Satuan Karya Pramuka<br/>Bakti Husada',  imageHeight: 200, imageWidth: 200});">Detail</button>
                    </div>
                </div>
                <div class="col-6 col-md-3 mb-3">
                    <div class="card border-0 card-body text-center">
                        <img src="$ThemeDir/peransaka/assets/saka-tarunabumi.png" class="img-fluid"
                            alt="SAKA Taruna Bumi" />
                        <button class="btn btn-primary"
                            onclick="Swal.fire({text: 'Satuan Karya Pramuka Tarunabumi adalah wadah bagi para Pramuka untuk meningkatkan dan mengembangkan kepemimpinan, pengetahuan, pengalaman, keterampilan dan kecakapan para anggotanya, sehingga mereka dapat melaksanakan kegiatan nyata dan produktif serta bermanfaat dalam mendukung kegiatan pembangunan pertanian.',imageUrl: '$ThemeDir/peransaka/assets/saka-tarunabumi.png', imageAlt: 'Saka Taruna Bumi', title: 'Satuan Karya Pramuka<br/>Taruna Bumi',  imageHeight: 200, imageWidth: 200});">Detail</button>
                    </div>
                </div>
                <div class="col-6 col-md-3 mb-3">
                    <div class="card border-0 card-body text-center">
                        <img src="$ThemeDir/peransaka/assets/saka-pariwisata.png" class="img-fluid"
                            alt="SAKA Pariwisata" />
                        <button class="btn btn-primary"
                            onclick="Swal.fire({text: 'Saka Pariwisata merupakan wadah kegiatan pendidikan dan pembinaan guna menyalurkan minat, bakat dan menambah pengetahuan, ketrampilan, pengalaman para Pramuka Penegak dan Pandega, dalam bidang kepariwisataan.',imageUrl: '$ThemeDir/peransaka/assets/saka-pariwisata.png', imageAlt: 'Saka Pariwisata', title: 'Satuan Karya Pramuka<br/>Pariwisata',  imageHeight: 200, imageWidth: 200});">Detail</button>
                    </div>
                </div>
                <div class="col-6 col-md-3 mb-3">
                    <div class="card border-0 card-body text-center">
                        <img src="$ThemeDir/peransaka/assets/saka-wbb.png" class="img-fluid" alt="SAKA Widya Bakti" />
                        <button class="btn btn-primary"
                            onclick="Swal.fire({text: 'Saka Widya Budaya Bakti adalah wadah pendidikan dan pembinaan bagi para pramuka penegak dan pramuka pandega untuk menyalurkan minat, mengembangkan bakat, kemampuan, dan pengalaman dalam bidang pengetahuan dan teknologi serta keterampilan di bidang Pendidikan dan Kebudayaan yang dapat menjadi bekal bagi kehidupan dan penghidupannya untuk mengabdi pada masyarakat, bangsa, dan negara.',imageUrl: '$ThemeDir/peransaka/assets/saka-wbb.png', imageAlt: 'Saka Widya Budaya Bakti', title: 'Satuan Karya Pramuka<br/>Widya Budaya Bakti',  imageHeight: 200, imageWidth: 200});">Detail</button>
                    </div>
                </div>
                <div class="col-6 col-md-3 mb-3">
                    <div class="card border-0 card-body text-center">
                        <img src="$ThemeDir/peransaka/assets/saka-kencana.png" class="img-fluid" alt="SAKA Kencana" />
                        <button class="btn btn-primary"
                            onclick="Swal.fire({text: 'Saka Keluarga Berencana (Kencana) adalah wadah kegiatan dan pendidikan untuk meningkatkan pengetahuan keterampilan praktis dan bakti masyarakat, dalam bidang Keluarga Berencana, Keluarga Sejahtera dan Pengembangan Kependudukan.',imageUrl: '$ThemeDir/peransaka/assets/saka-kencana.png', imageAlt: 'Saka Kencana (Keluarga Berencana)', title: 'Satuan Karya Pramuka<br/>Kencana (Keluarga Berencana)',  imageHeight: 200, imageWidth: 200});">Detail</button>
                    </div>
                </div>
                <div class="col-6 col-md-3 mb-3">
                    <div class="card border-0 card-body text-center">
                        <img src="$ThemeDir/peransaka/assets/saka-kalpataru.png" class="img-fluid"
                            alt="SAKA Kalpataru" />
                        <button class="btn btn-primary"
                            onclick="Swal.fire({text: 'Satuan Karya Pramuka (Saka) Kalpataru adalah Satuan Karya Pramuka di Gerakan Pramuka yang khusus bergerak dalam bidang cinta lingkungan hidup.',imageUrl: '$ThemeDir/peransaka/assets/saka-kalpataru.png', imageAlt: 'Saka Kalpataru', title: 'Satuan Karya Pramuka<br/>Kalpataru',  imageHeight: 200, imageWidth: 200});">Detail</button>
                    </div>
                </div>
                <div class="col-6 col-md-3 mb-3">
                    <div class="card border-0 card-body text-center">
                        <img src="$ThemeDir/peransaka/assets/saka-bahari.png" class="img-fluid" alt="SAKA Bahari" />
                        <button class="btn btn-primary"
                            onclick="Swal.fire({text: 'Satuan Karya Bahari adalah wadah bagi Pramuka yang menyelenggarakan kegiatan-kegiatan nyata, produktif dan bermanfaat dalam rangka menanamkan rasa cinta dan menumbuhkan sikap hidup yang berorentasi kebaharian termasuk laut dan perairan dalam.',imageUrl: '$ThemeDir/peransaka/assets/saka-bahari.png', imageAlt: 'Saka Bahari', title: 'Satuan Karya Pramuka<br/>Bahari',  imageHeight: 200, imageWidth: 200});">Detail</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <% if not $CurrentMember %>
    <section id="mendaftar" style="background-color: rgba(52, 152, 219, .25);">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-9">
                    <h3>Ayo Ikut Kegiatan Ini!</h3>
                    <p class="m-0">Ayo ikut kegiatan Peran SAKA 2020 ini! Dijamin seru loh!</p>
                </div>
                <div class="col-md-3">
                    <a href="{$BaseHref}member/login" class="btn btn-primary btn-block">Daftar Sekarang!<i
                            class="fas fa-arrow-right ml-2"></i></a>
                </div>
            </div>
        </div>
    </section>
    <% else %>
    <section id="schedule">
        <div class="container">
            <div class="container">
                <h3 class="section-header dark my-5">
                    <span class="text-dark">Kegiatan</span>
                </h3>
                <div class="row">
                    <% loop getRecentEvent(2) %>
                    <div class="col-md-6">
                        <a href="$Link">
                            <div class="alert alert-flicon alert-info">
                                <div class="icon-wrapper">
                                    <i class="fas fa-4x fa-info-circle"></i>
                                </div>
                                <div class="message-wrapper">
                                    <h3>$Title</h3>
                                    <div class="prev-content">
                                        $Content.LimitWordCount(16,'...')
                                    </div>
                                </div>
                            </div>
                            <a href="$Link">
                    </div>
                    <% end_loop %>
                </div>
                <a href="{$BaseHref}event">
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="alert alert-flicon alert-warning">
                                <div class="icon-wrapper">
                                    <i class="fas fa-4x fa-info-circle"></i>
                                </div>
                                <div class="message-wrapper">
                                    <h3>Lihat Lainnya</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </section>
    <% end_if %>

    <footer class="footer bg-dark py-3 text-white">
        <div class="container">
            <p class="copyright m-0 text-center">Copyright &copy <a class="text-white mr-1"
                    href="https://www.dkdjatim.or.id">Dewan Kerja Daerah Jawa Timur</a> 2020</p>
        </div>
    </footer>

    <button class="btn btn-info btn-btt"><i class="fas fa-chevron-up"></i></button>

    <script src="$ThemeDir/peransaka/js/jquery.min.js"></script>
    <script src="$ThemeDir/peransaka/js/bootstrap.bundle.min.js"></script>

    <script src="$ThemeDir/peransaka/assets/modules/owl/owl.carousel.min.js"></script>
    <script src="$ThemeDir/peransaka/assets/modules/sweetalert/sweetalert2.all.min.js"></script>
    <script src="$ThemeDir/peransaka/assets/modules/sweetalert/sweetalert2.min.js"></script>
    <script src="$ThemeDir/peransaka/js/main.js"></script>
    <script>
        $(".prev-content").each(function () {
            $(this).find("br").each(function () {
                console.log("aa")
                $(this).remove();
            })
        })

    </script>
</body>

</html>
