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
***         Tim Medin <tim@counterhack.com>
***
*** Copyright 2014 by Kevin Johnson and the Laudanum Team
***
********************************************************************************
***
*** This file provides a host lookup by ip address.
*** Written by Jason Gillam <jgillam@secureideas.com>
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

include 'ipcheck.php';


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
  <title>Laudanum PHP Hostname by IP Lookup</title>
</head>
<body>
  <h1>Fatal Error!</h1>
  <p><b>' . $errstr . '</b></p>
  <p>in <b>' . $errfile . '</b>, line <b>' . $errline . '</b>.</p>

  <hr>
  <address>
  Copyright &copy; 2014, <a href="mailto:laudanum@secureideas.net">Kevin Johnson</a> and the Laudanum team.<br/>
  Written by Tim Medin.<br/>
  Get the latest version at <a href="http://laudanum.secureideas.net">laudanum.secureideas.net</a>.
  </address>

</body>
</html>');
    }
}

set_error_handler('error_handler');


/* Initialize some variables we need again and again. */
$query = isset($_POST['query']) ? $_POST['query'] : '';
$type  = isset($_POST['type'])  ? $_POST['type']  : 'DNS_ANY';
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <title>Laudanum Host Lookup</title>
  <link rel="stylesheet" href="style.css" type="text/css">

  <script type="text/javascript">
    function init() {
      document.dns.query.focus();
    }
  </script>
</head>
<body onload="init()">

<h1>Host Lookup 0.1</h1>
<form name="dns" action="<?php echo $_SERVER['PHP_SELF'] ?>" method="POST">
<fieldset>
  <legend>Host Lookup:</legend>
  <p>IP:<input name="query" type="text">
  </select>
  <input type="submit" value="Submit">
</fieldset>
</form>


<?php
if ($query != '')
{
  $result = gethostbyaddr($query);
  echo "<pre><results>";
  echo "Result = ";
  print_r($result);
  echo "</results></pre>";
}
?>
  <hr>
  <address>
  Copyright &copy; 2014, <a href="mailto:laudanum@secureideas.net">Kevin Johnson</a> and the Laudanum team.<br/>
  Written by Tim Medin.<br/>
  Get the latest version at <a href="http://laudanum.secureideas.net">laudanum.secureideas.net</a>.
  </address>

</body>
</html>
