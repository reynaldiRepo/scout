<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Peransaka Email</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
            background-color: #e7e5e5;
        }

        .ctr {
            width: 70%;
            margin-left: auto;
            margin-right: auto;
            margin-top: 30px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            padding:20px;
            background-color: #ffffff;
        }

    </style>
</head>

<body>
    <div class="ctr">
        <h1>$subject</h1>
        <hr>
        <p>
            Kepada Yth, $member.FirstName $member.Surname <br>
        </p>
        <p>
            $body.RAW
        </p>        
        <hr>
        Hormat Kami,
        <br><br><br>
        Peransaka Jawa Timur
    </div>
</body>

</html>
