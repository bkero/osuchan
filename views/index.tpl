<!doctype html>
<head>
    <title>OSUchan</title>
    <link rel='stylesheet' type="text/css" href='/static/style.css' />
</head>
<body>
    <header>OSUChan</header>
    <section id="boards">
    <table>
    %for (boardname, abbreviation) in boards:
        <tr>
            <td><a href="/{{abbreviation}}">{{boardname}}</a></td>
        </tr>
    %end
    </table>
    </section>

    <hr />

    <footer>(C)GPLv2</footer>
    </body>
</html>
