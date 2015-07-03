<!DOCTYPE html>
<html>
<head>
<title>Logout in progress...</title>
<script type="text/javascript">
window.onunload = refreshParent();
window.onload = closeMe();
function refreshParent() {
  window.opener.location.reload();
}
function closeMe() {
  window.close();
}
</script>
</head>
<body>
</body>
</html>

