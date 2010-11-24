<!doctype html>
<head>
    <title>/{{title}}/ - OSUchan</title>
    <link rel='stylesheet' type="text/css" href='/static/style.css' />
</head>
<body>
    <header>OSUChan</header>
    <section id="compose">
        <form name="formcompose" action='/{{board}}/comment' method='post' enctype="multipart/form-data">
            <label for="name">Name</label><input type='text' name='name' value='Anonymous'/><br />
            <label for="email">Email</label><input type='text' name='email' /><br />
            <label for="subject">Subject</label><input type='text' name='subject' /><br />
            <label for="comment">Comment</label><textarea rows=4 cols=48 name='comment'></textarea><br />
            <label for='datafile'>Image</label><input type='file' name='datafile' /><br />
            <input type='hidden' id='board' value='{{title}}'>
            <input type='submit' value='Submit' /><br />
        </form>
    </section>


    <section>
        %for (id, subject, author) in threads:
        <article>
            {{author}} - {{subject}}  [<a href="{{board}}/{{id}}">Reply</a>] <br />
        </article>
        %end
    </section>


    <footer>OSUChan</footer>
    </body>
</html>
