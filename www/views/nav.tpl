  <nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="http://unleashed">ZacPlus</a>
      </div>
      <div id="navbar" class="navbar-collapse collapse">
        <ul class="nav navbar-nav">
          <li class="active"><a href="{{url_home_page}}">PartyOn!</a></li>
          <li><a href="{{url_about}}">About</a></li>
          <li><a href="{{url_contact}}">Contact</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li><a id="magic-login-status" role="button" class="btn" onclick="return false;"></a></li>
          <li><a href="{{ get_url('home')}}">...</a></li>
          <li><a id="magic-sign-in-button" role="button" class="btn" data-toggle="modal" data-target="#appModalLogin" onclick="return false;">Sign In</a></li>
          <li><a id="magic-sign-out-button" role="button" class="btn" href="{{ get_url('logout-fb')}}">Sign Out</a></li>
        </ul>
      </div><!--/.nav-collapse -->
    </div>
  </nav>

