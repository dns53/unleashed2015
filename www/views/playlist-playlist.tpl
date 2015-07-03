% setdefault('show_likes', False)
<div class="panel panel-primary">
  <div class="panel-heading">
    % if playlist_type == 'aussie':
      <h2 class="panel-title">Here is your 100% Fair Dinkum Aussie playlist! (Well, perhaps that needs a bit more work...)</h2>
    % else:
      <h2 class="panel-title">Here is your specially selected playlist!</h2>
    % end
  </div>
  <div class="panel-body">
    <p>Chart data courtesy Channel V charts apis, Musicbrainz, AcousticBrainz, iTunes</p>
    <div class="row" style="background-color: #222222; color: #ffffff;">
      <table class="table" style="font-size:+1;">
        <thead>
          <tr>
            <th>Song</th>
            <th>Artist</th>
            <th>BPM</th>
            <th>&nbsp;</th>
            <th>&nbsp;</th>
            <th>&nbsp;</th>
          </tr>
        </thead>
        <tbody>
          % for xx in songs:
            <tr>
              <td>{{xx['song']}}</td>
              <td>{{xx['artist']}}</td>
              <td>{{xx['bpm']}}</td>
              <td><a href="{{xx['itunes']}}">iTunes</a></td>
              <td>PlayStore</td>
              <td>Spotify</td><td>V / ARIA chart icon</td>
            </tr>
          % end
        </tbody>
      </table>
    </div>
      % if not authenticated:
      <h4 id="magic-sign-in-msg2">For a longer playlist, or to reorder, or save or recall multiple playlists, please 
          <a class="navbar-link button pzbuttonhack" data-toggle="modal" data-target="#appModalLogin" href="#" onclick="return false;">Sign In</a>
      </h4>
      % end
    % if show_likes:
<div>
  <script src="http://coinwidget.com/widget/coin.js"></script>
  <script>
  CoinWidgetCom.go({
	  wallet_address: "122CjP6LsJBCGU3kPqeJWUPTf6Sc38dhFf"
	  , currency: "bitcoin"
	  , counter: "hide"
	  , alignment: "bl"
	  , qrcode: true
	  , auto_show: false
	  , lbl_button: "If you like this, shout us a cup of coffee!"
	  , lbl_address: "Our Bitcoin Address:"
	  , lbl_count: "donations"
	  , lbl_amount: "BTC"
  });
  </script>
<% # using 6px fixes the alignment in Chrome, but still crooked in firefox... aargh
%>
  <div style="position:relative; top:6px; display:inline-block;"
    class="fb-like" data-share="true" data-width="450" data-show-faces="true">
  </div>
</div>
    % end

  </div>
</div>

