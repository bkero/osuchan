<!doctype html>
<head>
    <title>/{{title}}/ - OSUchan</title>
    <link rel='stylesheet' type="text/css" href='/static/style.css' />
</head>
<body>
    <header>OSUChan</header>
    <section id="compose">
        <form name="formcompose" action='/{{board}}/{{thread}}/comment' method='post' enctype="multipart/form-data">
            <label for='name'>Name</label><input type='text' name='name' value="Anonymous" /><br />
            <label for='email'>Email</label><input type='text' name='email' /><br />
            <label for='comment'>Comment</label><textarea name='comment' wrap='soft' rows=4 cols=48></textarea><br />
            <label for='datafile'>File</label><input type='file' name='datafile' /><br />
            <input type='hidden' name='board' value='{{title}}'>
            <input type='submit' value='Submit' /><br />
        </form>
    </section>
    <section id="threads">
        %for (id, author, threadid, timestamp, comment, email, file) in posts:
        <article>
            <header>
                {{author}} <time>{{timestamp}}</time> No. {{id}} <br />
            </header>
            <section>
                <img src="/static/images/{{file}}" />
                {{comment}}
            </section>
        </article>
        <br />
        %end
    </section>
    <footer>OSUChan</footer>
    </body>
</html>
