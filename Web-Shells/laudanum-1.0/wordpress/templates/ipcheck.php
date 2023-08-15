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
*** This file provides a rudamentary IP filter to help prevent usage of Laudanum tools
*** by someone other than the person who uploaded Laudanum.  This file should be included
*** in other Laudanum tools and not called directly. 
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


// ***************** Config entries below ***********************
// IPs are enterable as individual addresses TODO: add CIDR support
$wpl_allowedIPs = array("192.168.0.2", "127.0.0.1", "172.16.179.1");
 	

# *********** No editable content below this line **************

$wpl_allowed = 0;
foreach ($wpl_allowedIPs as $IP) {
    if ($_SERVER["REMOTE_ADDR"] == $IP)
        $wpl_allowed = 1;
}

if ($wpl_allowed == 0) {
    header("HTTP/1.0 404 Not Found");
    die();
}

?>