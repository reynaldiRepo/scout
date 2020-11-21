<!DOCTYPE html>
<html lang="$Locale.RFC1766">

<head>
    <% base_tag %>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, maximum-scale=1.0" />
    <title>$Title</title>
    <link rel="shortcut icon" type="image/x-icon" href="$SiteConfig.FavicoImage.Fill(16,16).URL">
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

<body class="loading cms" data-frameworkpath="$ModulePath(silverstripe/framework)"
    data-member-tempid="$CurrentMember.TempIDHash.ATT">
    <% include SilverStripe\\Admin\\CMSLoadingScreen %>

    <div class="cms-container" data-layout-type="custom">
        $Menu
        $Content
        $PreviewPanel
    </div>

    <% include SilverStripe\\Admin\\BrowserWarning %>
</body>

</html>
