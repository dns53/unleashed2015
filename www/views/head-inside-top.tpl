<%
# NOTE: we are using the receptor method to get certain information
# (such as API keys) from the backend into javascript.
#
# This is NOT for security, but so that we can easily switch keys (e.g. between
# facebook test and production apps) by just making a change in one place on the
# backend without having to edit any javascript or template code
#
# See: http://thanpol.as/javascript/passing-data-from-server-to-javascript-on-page-load/
# See: https://github.com/thanpolas/server2js
#
# For the moment though we'll leave all the hook stuff, we are not yet complicated 
# enough to worry about dynamic updates and ordering or whatever...
#
# Until things are more mature, we'll just deal with using GLOBAL
#
%>
<!-- common inside-head markup -->
<meta charset="UTF-8" />
<title>Zacplus!</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="{{ get_url('static', filename='favicon.jpg') }}" />

<!-- bootstrap javascript framework -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- needed for login choice popup -->
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">

<!-- server side data receptor goes here -->
<script type="text/javascript">
  var GLOBAL = [
    {op: 'authenticated',  val: '{{authenticated}}' },
    {op: 'users_name',     val: '{{users_name}}' },
    {op: 'deploymentMode', val: 'DEVELOPMENT'},
    {op: 'apiKeyFacebook', val: '{{api_key_facebook}}'},
  ];
  function GET_GLOBAL(key) { 
    for (var i = 0, l = GLOBAL.length; i < l; i++) {
      var op = GLOBAL[i]['op'];
      if (op === key) { return GLOBAL[i]['val']; }
    }
    return undefined;
  }
</script>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- needed for login execution popup window -->
<script src="{{ get_url('static', filename='authomatic.js') }}"></script>

<!-- Common javascript initialisation, loaded after jQuery and authomatic -->
<script src="{{ get_url('static', filename='pz-common-init.js') }}"></script>

<!-- Facebook javascript initialisation -->
<script src="{{ get_url('static', filename='pz-common-fb.js') }}"></script>

<!-- unleashed css -->
<link rel="stylesheet" href="{{ get_url('static', filename='unleashed.css') }}">

