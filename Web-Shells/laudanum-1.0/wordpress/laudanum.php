<?php
/**
 * Plugin Name: Laudanum
 * Description: This plugin is leveraged for running security tests and should be left disabled when not in use.
 * Author: Jason Gillam and the Laudanum Team
 * Version: 0.02
 */
 
 
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
*** This file is a Word Press plugin wrapper for Laudanum's PHP tools.  As with 
*** other Word Press plugins, this entire directory should be zipped up for deployment.
*** The templates/ipcheck.php file should be updated with the tester's IP address first.
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
 
 if(!class_exists("WP_Laudanum"))
 {
 	class WP_Laudanum
 	{
 	
 		public function __construct()
 		{
 			add_action('admin_menu', array(&$this, 'add_menu'));
 		}
 	
 		public function __activate()
 		{
 	
 		}
 	
 		public function __deactivate()
 		{
 	
 		}
 		
 		public function add_menu()
 		{
 			add_options_page('Laudanum Settings', 'Laudanum', 'manage_options', 'wp_laudanum', array(&$this, 'plugin_settings_page')); 			
 		}
 		
 		public function plugin_settings_page()
 		{
 			if(!current_user_can('manage_options'))
 			{
 				wp_die(__('You do not have sufficient permissions to access this page.'));
 			}
 			
 			include(sprintf("%s/templates/settings.php", dirname(__FILE__)));	
 		}
 	}
 	
 	register_activation_hook(__FILE__, array('WP_Laudanum', 'activate'));
 	register_deactivation_hook(__FILE__, array('WP_Laudanum', 'deactivate'));
 	
 	$wp_laudanum = new WP_Laudanum();
 	
 	if(isset($wp_laudanum)) { 
 		function plugin_settings_link($links)
 			{ 
 			$settings_link = '<a href="options-general.php?page=wp_laudanum">Settings</a>'; 
 			array_unshift($links, $settings_link); 
 			return $links; 
 		} 
 		
 		$plugin = plugin_basename(__FILE__); 
 		add_filter("plugin_action_links_$plugin", 'plugin_settings_link'); 
 	}
 	
 }
 
 
 
 ?>