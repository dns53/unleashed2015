<!DOCTYPE html>
<html lang="en-AU">
<head>
% include('head-inside-top.tpl')
<!-- tag canvas -->
<script src="{{ get_url('static', filename='jquery.tagcanvas.min.js') }}" type="text/javascript"></script>
<!-- application code -->
<script src="{{ get_url('static', filename='pz-page-main.js') }}" type="text/javascript"></script>
</head>
<body role="document" id="mbody">
% include('body-top.tpl')
% include('nav.tpl')
<div style='background: #00ff00 url({{ get_url('static', filename=asset_main_bg) }}) repeat; background-size: cover;'>
<div class="container theme-showcase" role="main" id="mmain">
% include('main-jumbo.tpl')
% include('main-enthuse.tpl')
% include('main-chart-select.tpl')
</div>
% include('body-bottom.tpl')
</div>
</body>
</html>
