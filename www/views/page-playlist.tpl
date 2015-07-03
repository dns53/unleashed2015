<!DOCTYPE html>
<html lang="en-AU">
<head>
% include('head-inside-top.tpl')
<!-- application code -->
</head>
<body role="document" id="mbody">
% include('body-top.tpl')
% include('nav.tpl')
<div style='background: #00ff00 url({{ get_url('static', filename=asset_main_bg) }}) repeat; background-size: cover;'>
<div class="container theme-showcase" role="main" id="mmain">
% include('main-jumbo.tpl')
  <div class="panel panel-primary">
    <h3>ADVERTISEMENT GOES HERE! &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
  </div>
% include('playlist-playlist.tpl', show_likes=True)
% include('playlist-signup.tpl')
% include('playlist-features.tpl')
</div>
% include('body-bottom.tpl')
</div>
</body>
</html>
