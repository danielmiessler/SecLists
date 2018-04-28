<?php
@unlink(__FILE__);

// Validate if the request is from Softaculous
if($_REQUEST['pass'] != 'mv8gdj4ohqfxpu34yj5ursupfabcmvdm'){ // your password here
	die("Unauthorized Access");
}

require('wp-blog-header.php');
require('wp-includes/pluggable.php');
$user_info = get_userdata(1);
// Automatic login //
$username = $user_info->user_login;
$user = get_user_by('login', $username );
// Redirect URL //
if ( !is_wp_error( $user ) )
{
    wp_clear_auth_cookie();
    wp_set_current_user ( $user->ID );
    wp_set_auth_cookie  ( $user->ID );

    $redirect_to = user_admin_url();
    wp_safe_redirect( $redirect_to );

    exit();
}
