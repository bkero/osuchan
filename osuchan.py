#!/usr/bin/env python

from bottle import request, route, run, template, view
import bottle
bottle.debug(True)
import psycopg2
import hashlib

DSN="dbname=cs440"
header="OSUChan"

conn = psycopg2.connect(DSN)
curs = conn.cursor()

@route('/')
@view('index')
def index():
    curs.execute("SELECT name, abbreviation from board")
    boards = curs.fetchall()
    return {"title": header, "boards": boards}

@route('/static/:name')
def style(name):
    bottle.send_file(name,root='static')

@route('/static/images/:image')
def sendimage(image):
    bottle.send_file(image,root='static/images')

@route('/:board/comment', method='POST')
def comment(board):

    if not request.POST['subject']:
        return "You forgot to fill out the subject"
    if not request.POST['name']:
        return "You forgot to fill our your name"
    if not request.POST['comment']:
        return "You forgot to fill in a comment!"
    if not request.POST['email']:
        return "You forgot to provide an email address"

    datafile = request.POST.get('datafile')
    hash = hashlib.md5()
    hash.update(datafile.file.read())
    md5sum = hash.hexdigest()
    datafile.file.seek(0)

    fh = open('/home/bkero/cs440/static/images/%s' % md5sum, 'w')
    fh.write(datafile.file.read())
    fh.close()

        # Insert thread entry
    curs.execute("INSERT INTO thread (id, board, subject, author) VALUES (DEFAULT, '%s', '%s', '%s'); SELECT currval('thread_id_seq');" % (board, request.POST['subject'], request.POST['name']))
    threadid = curs.fetchone()[0]
    
        # Insert first post
    query = "INSERT INTO post (threadid, author, comment, email, file, timestamp) VALUES (%d, '%s', '%s', '%s', '%s', NOW())" % (threadid, request.POST['name'], request.POST['comment'], request.POST['email'], md5sum)
    curs.execute(query)
    conn.commit()
    
    return "<html><head><meta http-equiv='refresh' content='3;url=http://ponderosa.osuosl.org:1337/%s'></head><body>Message Posted!  Please wait 3 seconds to be redirected back to the board index.</body></html>" % board

@route('/:board/:thread/comment', method='POST')
def threadcomment(board, thread):

    if not request.POST['name']:
        return "You forgot to fill our your name"
    if not request.POST['comment']:
        return "You forgot to fill in a comment!"
    if not request.POST['email']:
        return "You forgot to provide an email address"

    datafile = request.POST.get('datafile')
    hash = hashlib.md5()
    hash.update(datafile.file.read())
    md5sum = hash.hexdigest()
    datafile.file.seek(0)

    fh = open('/home/bkero/cs440/static/images/%s' % md5sum, 'w')
    fh.write(datafile.file.read())
    fh.close()

    query = "INSERT INTO post (threadid, author, comment, email, file, timestamp) VALUES (%s, '%s', '%s', '%s', '%s', NOW())" % (thread, request.POST['name'], request.POST['comment'], request.POST['email'], md5sum)
    curs.execute(query)
    conn.commit()
    return "<html><head><meta http-equiv='refresh' content='3;url=http://ponderosa.osuosl.org:1337/%s/%s'></head><body>Message Posted!  Please wait 3 seconds to be redirected back to the thread.</body></html>" % (board, thread)

@route('/:board')
@view('showboard')
def showboard(board):
    curs.execute("SELECT id, subject, author FROM thread WHERE board='%s'" % (board))
    threads = curs.fetchall()
    return dict(title=board, board=board, threads=threads)

@route('/:board/:thread')
@view('showthread')
def showthread(board, thread):
    curs.execute("SELECT subject FROM thread WHERE id=%s" % (thread))
    subject = curs.fetchone()[0]
    query = "SELECT id, author, threadid, timestamp, comment, email, file from post WHERE threadid=%s ORDER BY timestamp" % (thread)
    curs.execute(query)
    posts = curs.fetchall()
    return dict(title = subject, board=board, posts=posts, thread=thread)

run(host='0.0.0.0', port=1337)
