#
# Copyright (c) Andrew McDonnell, Daniel Sobey, 2015
#
# Might eventually be made available under both:
#
# (a) Affero GPL, or
# (b) on commercial terms, by negotiation.
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# The unleashed web application landing page.
#
# Redeveloped from competition proof of concept.
# It was decided to deprecate web.py and use an actively maintained Python
# web micro framework, bottle
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# SECURITY REMINDER!
#
# The bottle framework compiles templates to executable python bytecode.
# Do not allow server process write access to views/ (which should be the case...)
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Execution Paths
# ---------------
#
# <...>/main.wsgi/wtjs/<filename>    Serve dynamically constructed javascript from template
#                                    Ensure mime type is javascript
#
# <...>/main.wsgi/wtaf/<filename>    Serve other static files, from static/
#
# <...>/main.wsgi                    Home page: shows tag cloud and 'Make My Playlist' button
# <...>/main.wsgi/
#
# <...>/main.wsgi/buildplaylist?wordlist=tag,tag,tag
#                                    Form submission from the Home page, generates a playlist
#                                    and serves the result
#
# Login Path
# ----------
# Authentication will be initiated using Authomatic (http://peterhudec.github.io/authomatic/) 
# a library that provides access to quite a number of possible social authenticators and OAuth
#

debug_show_fake_data_on_error = False
debug_dump_everything = False

import sys
import os
import random
import logging # and set Loglevel info in apache config
import bottle
from bottle import Bottle, SimpleTemplate
from bottle import view, request, response, static_file, template
from authomatic import Authomatic

logging.basicConfig() # needed to see stuff in apache error.log

# Enable bottle debugging; disable this in production
# Note, this wont help detect changes in any library code which is annoying
from bottle import debug
debug(True)

# Change the working directory to this source directory, which is the www root for this application
# This lets bottle find the templates!
self_path = os.path.dirname(__file__)
os.chdir(self_path)

# Add the lib/ directory to our path, for application specific library code
# (but only if not already in the path; remember, the underlying WSGI process persists,
#  so each time the page is returned this code gets re-executed)
lib_path = os.path.normpath(os.path.join(self_path, "../python"))
if lib_path not in sys.path:
  sys.path.insert(1, lib_path)

#import data.usermodel # recreate db if missing

# Find the sqlite database location

# Find the path to static resources
static_path = os.path.normpath(os.path.join(self_path, "static"))

# Dump stuff to /var/log/apache/error.log if needed
if debug_dump_everything:
  print >> sys.stderr, "self_path=>", self_path
  print >> sys.stderr, "python.path=>", repr(sys.path)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Application specific global initialisation
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#stuff.init_database(stuff_db_path)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Bottle application
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# We need a session as well - things signed by the CSRF go there
# Also: https://gist.github.com/FRII/6753045
from beaker.middleware import SessionMiddleware
session_opts = {
    'session.type': 'file',
    'session.cookie_expires': 86400,
    'session.data_dir': '/var/tmp',
    'session.auto': True
}

app = Bottle()
the_application = SessionMiddleware(app, session_opts)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# The following fields are common to all the bottle pages
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
default_fields = {
  'authenticated'    : False,
  'users_name'       : None,
  'url_home_page'    : 'http://108.61.184.183',  # point this to weebly
  'url_about'        : 'http://108.61.184.183/about.html',
  'url_contact'      : 'http://108.61.184.183/contact.html',
  'asset_main_bg'    : 'dance-108915_1920.jpg',
  'api_key_facebook' : '' #something.auth.API_KEY_FACEBOOK,
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# See: http://stackoverflow.com/questions/9505256/static-files-not-loaded-in-a-bottle-application-when-the-trailing-slash-is-omitt
# See: http://stackoverflow.com/questions/6978603/how-to-load-a-javascript-or-css-file-into-a-bottlepy-template
#
# @app.route('/static/:filename#.+#', name='static') --> 
#    {{ get_url('static', filename='thing') }} -->
#         renders as: http://localhost/~public_html/dir/www/main.wsgi/static/thing
#
# Note: filename=, must match the name in @route after /wtaf/
#
# wtaf: for reasons that make completely no sense, this only works if you prefix  anything
# _other_ than '/static/' !!!! i.e., WTAF?
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Hacky replacement for app.get_url to detect 'main.wsgi/' (for home) 
# and replace it without the trailing slash
#
# All this pain is just because things dont quite work right with public_html, which I use for development
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def my_url_function(routename, **kargs):
  if routename == 'primary':
    result = app.get_url('home') + '/' + kargs['actual']
  else:
    result = app.get_url(routename, **kargs)
  if result.endswith('main.wsgi/'):
    result = result[:-1]
  return result

SimpleTemplate.defaults["get_url"] = my_url_function

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Static file server
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/wtaf/<filename>', name='static')
def send_static(filename):
  return static_file(filename, root=static_path)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Dynamic route: javascript requested via this path is rendered using a bottle
# template. Note, care should be taken not to go overboard using self modifying
# code.
#
# Not using this anymore, but kept as a reminder that need to set application/javascript
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/wtjs/<filename>', name='dynamic')
def dynamic_js(filename):
  fields = { }
  response.content_type = "application/javascript";
  return template(filename, **fields)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Web application request: test auth detection
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@app.route('/test-auth-detect')
@view('page-debug')
def serve_login():
  session = request.environ.get('beaker.session')
#  result = something.auth.detect_authenticated_user(request, response, session)

  text = "Session.Token=%s\nCookie.something.space=%s\n" % (session.get('auth_token',None), request.get_cookie("something.space"));
  if result == False:
    text = text + "No authenticated user\n"
  else:
    text = text + "User=%s\nError=%s\n" % (result.user, result.error)
  return { 'debug' : text }

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Web application request: test facebook login
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@app.route('/test-login-fb', name='test-login-fb')
def serve_login():
  session = request.environ.get('beaker.session')
#  (result, row, report) = something.auth.deprecated_login(request, response, session, "fb")
  result = None
  if result == None:
    return "Signing in..."

  return template( 'page-debug', {'debug' : report})

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Web application request: facebook login via Authomatic javascript button
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@app.route('/login-fb', name='login-fb')
@view('popup-page-login')
def serve_login():
  session = request.environ.get('beaker.session')
#  (result, row, report) = something.auth.deprecated_login(request, response, session, "fb")
  if result == None:
    return ""

  row = None
  if row != None:
    # Do backend login stuff with database
    # Metrics
    pass
  # else : user cancel

  # Close the popup window - we also need to refresh the underlying page
  return { 'scriptlet' : result.popup_js(stay_open=True), 'template_settings' : {'noescape' : True} }

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Web application request: facebook logout
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@app.route('/logout-fb', name='logout-fb')
@view('popup-page-logout')
def serve_login():
  session = request.environ.get('beaker.session')

#  something.auth.deprecated_logout(request, response, session)

  # Metrics

  # For now just flush the cookies

  # TODO: warn user the app is still authorised in Facebook

  # Redirect back
  bottle.redirect(my_url_function('home'))

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Web application request:
# When the user hits 'generate' we need to generate a playlist and display it
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/buildplaylist')
@view('page-playlist')
def serve_playlist():

  # Perhaps we could make a decorator to do this
  fields = {}
  fields.update(default_fields)
  session = request.environ.get('beaker.session')
#  row = something.auth.detect_authenticated_user(request, response, session)
  authenticated = False
  row = None
  if row:
    authenticated = True
    fields['authenticated'] = True
    fields['users_name'] = row.name

  tagwords = request.query.wordlist
  fields.update(dict({
    'playlist_type'  : '',          # or "aussie"
    'songs'          : fake_songs,
  }))
  return fields

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Web application request:
# The default page, with the tag cloud.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

fake_tagwords = ""
@app.route('/', name='home')
@view('page-main')
def serve_entry():
  # Perhaps we could make a decorator to do this
  fields = {}
  fields.update(default_fields)
  session = request.environ.get('beaker.session')
#  row = something.auth.detect_authenticated_user(request, response, session)
  row = None
  if row:
    authenticated = True
    fields['authenticated'] = True
    fields['users_name'] = row.name

  fields.update(dict({
    'tagwords'         : fake_tagwords,
  }))
  return fields

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Make everything work
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

application = the_application

