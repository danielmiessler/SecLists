<?php
/* *****************************************************************************
***
*** Laudanum Project
*** A Collection of Injectable Files used during a Penetration Test
***
*** More information is available at:
***  http://laudanum.secureideas.net
***  laudanum@secureideas.net
***
***  Project Leads:
***         Kevin Johnson <kjohnson@secureideas.net
***         Tim Medin <tim@securitywhole.com>
***
*** Copyright 2012 by Kevin Johnson and the Laudanum Team
***
********************************************************************************
***
*** This file allows browsing of the file system.
*** Written by Tim Medin <tim@securitywhole.com>
***
********************************************************************************
*** This program is free software; you can redistribute it and/or
*** modify it under the terms of the GNU General Public License
*** as published by the Free Software Foundation; either version 2
*** of the License, or (at your option) any later version.
***
*** This program is distributed in the hope that it will be useful,
*** but WITHOUT ANY WARRANTY; without even the implied warranty of
*** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*** GNU General Public License for more details.
***
*** You can get a copy of the GNU General Public License from this
*** address: http://www.gnu.org/copyleft/gpl.html#SEC1
*** You can also write to the Free Software Foundation, Inc., 59 Temple
*** Place - Suite 330, Boston, MA  02111-1307, USA.
***
***************************************************************************** */

// ***************** Config entries below ***********************

// IPs are enterable as individual addresses TODO: add CIDR support
$allowedIPs = array("192.168.1.1","127.0.0.1");

# *********** No editable content below this line **************

$allowed = 0;
foreach ($allowedIPs as $IP) {
    if ($_SERVER["REMOTE_ADDR"] == $IP)
        $allowed = 1;
}

if ($allowed == 0) {
    header("HTTP/1.0 404 Not Found");
    die();
}



/* This error handler will turn all notices, warnings, and errors into fatal
 * errors, unless they have been suppressed with the @-operator. */
function error_handler($errno, $errstr, $errfile, $errline, $errcontext) {
    /* The @-opertor (used with chdir() below) temporarely makes
     * error_reporting() return zero, and we don't want to die in that case.
     * We do note the error in the output, though. */
    if (error_reporting() == 0) {
        $_SESSION['output'] .= $errstr . "\n";
    } else {
        die('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <title>Laudanum PHP File Browser</title>
</head>
<body>
  <h1>Fatal Error!</h1>
  <p><b>' . $errstr . '</b></p>
  <p>in <b>' . $errfile . '</b>, line <b>' . $errline . '</b>.</p>

  <hr>
  <address>
  Copyright &copy; 2012, <a href="mailto:laudanum@secureideas.net">Kevin Johnson</a> and the Laudanum team.<br/>
  Written by Tim Medin.<br/>
  Get the latest version at <a href="http://laudanum.secureideas.net">laudanum.secureideas.net</a>.
  </address>

</body>
</html>');
    }
}

set_error_handler('error_handler');


/* Initialize some variables we need again and again. */
$dir  = isset($_GET["dir"])  ? $_GET["dir"]  : ".";
$file = isset($_GET["file"]) ? $_GET["file"] : "";

if ($file != "") {
  if(file_exists($file)) {

    $s = split("/", $file);
    $filename = $s[count($s) - 1];
    header("Content-type: application/x-download");
    header("Content-Length: ".filesize($file)); 
    header("Content-Disposition: attachment; filename=\"".$filename."\"");
    readfile($file);
    die();
  }
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <title>Laudanum File Browser</title>
  <link rel="stylesheet" href="style.css" type="text/css">

  <script type="text/javascript">
  </script>
</head>
<body onload="init()">

<h1>Laudanum File Browser 0.1</h1>
<a href="<?php echo $_SERVER['PHP_SELF']  ?>">Home</a><br/>

<?php
// get the actual path, add an ending / if necessary
$curdir = realpath($dir);
$curdir .= substr($curdir, -1) != "/" ? "/" : "";

$dirs = split("/",$curdir);

// Create the breadcrumb
echo "<h2>Directory listing of <a href=\"" . $_SERVER['PHP_SELF'] . "?dir=/\">/</a> ";
$breadcrumb = '/';
foreach ($dirs as $d) {
  if ($d != '') {
    $breadcrumb .=  $d . "/";
    echo "<a href=\"" . $_SERVER['PHP_SELF'] . "?dir=" . urlencode($breadcrumb) . "\">$d/</a> ";
  }
}
echo "</h2>";

// translate .. to a real dir
$parentdir = "";
for ($i = 0; $i < count($dirs) - 2; $i++) {
  $parentdir .= $dirs[$i] . "/";   
}

echo "<table>";
echo "<tr><th>Name</th><th>Date</th><th>Size</th></tr>";
echo "<tr><td><a href=\"" . $_SERVER['PHP_SELF'] . "?dir=$parentdir\">../</a></td><td> </td><td> </td></tr>";

//get listing, separate into directories and files
$listingfiles = array();
$listingdirs  = array();

if ($handle = @opendir($curdir)) {
  while ($o = readdir($handle)) {
    if ($o == "." || $o == "..")  continue;
    if (@filetype($curdir . $o) == "dir") {
      $listingdirs[] = $o . "/";
    }
    else {
      $listingfiles[] = $o;
    }
  }

  @natcasesort($listingdirs);
  @natcasesort($listingfiles);

  //display directories
  foreach ($listingdirs as $f) {
    echo "<tr><td><a href=\"" . $_SERVER['PHP_SELF'] . "?dir=" . urlencode($curdir . $f) . "\">" . $f . "</a></td><td align=\"right\">" . "</td><td> <td></tr>";
  }

  //display files
  foreach ($listingfiles as $f) {
    echo "<tr><td><a href=\"" . $_SERVER['PHP_SELF'] . "?file=" . urlencode($curdir . $f) . "\">" . $f . "</a></td><td align=\"right\">" . "</td><td align=\"right\">" . number_format(@filesize($curdir . $f)) . "<td></tr>";
  }
}
else {
  echo "<tr><td colspan=\"3\"><h1>Can't open directory</h1></td></tr>";
}
?>
</table>
  <hr>
  <address>
  Copyright &copy; 2012, <a href="mailto:laudanum@secureideas.net">Kevin Johnson</a> and the Laudanum team.<br/>
  Written by Tim Medin.<br/>
  Get the latest version at <a href="http://laudanum.secureideas.net">laudanum.secureideas.net</a>.
  </address>
</body>
</html>
