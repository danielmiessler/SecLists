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
*** This file provides access to DNS on the system.
*** Written by Tim Medin <tim@counterhack.com>
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
  <title>Laudanum PHP DNS Access</title>
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
  <title>Laudanum PHP DNS Access</title>
  <link rel="stylesheet" href="style.css" type="text/css">

  <script type="text/javascript">
    function init() {
      document.dns.query.focus();
    }
  </script>
</head>
<body onload="init()">

<h1>DNS Query 0.1</h1>
<form name="dns" action="<?php echo $_SERVER['PHP_SELF'] ?>" method="POST">
<fieldset>
  <legend>DNS Lookup:</legend>
  <p>Query:<input name="query" type="text">
  Type:<select name="type">
<?php
  $types = array("A" => DNS_A, "CNAME" => DNS_CNAME, "HINFO" => DNS_HINFO, "MX" => DNS_MX, "NS" => DNS_NS, "PTR" => DNS_PTR, "SOA" => DNS_SOA, "TXT" => DNS_TXT, "AAAA" => DNS_AAAA, "SRV" => DNS_SRV, "NAPTR" => DNS_NAPTR, "A6" => DNS_A6, "ALL" => DNS_ALL, "ANY" => DNS_ANY);

  if (!in_array($type, array_keys($types))) {
    $type = "ANY";
  }

  $validtype = 0;
  foreach (array_keys($types) as $t) {
    echo "    <option value=\"$t\"" . (($type == $t) ? " SELECTED" : "") . ">$t</option>\n";
  }
?>

  </select>
  <input type="submit" value="Submit">
</fieldset>
</form>


<?php
if ($query != '')
{
  $result = dns_get_record($query, $types[$type], $authns, $addtl);
  echo "<pre><results>";
  echo "Result = ";
  print_r($result);
  echo "Auth NS = ";
  print_r($authns);
  echo "Additional = ";
  print_r($addtl);
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
