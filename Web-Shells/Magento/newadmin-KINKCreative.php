<?php

/*

Put this file into your root folder. Set the user settings below and run the script. It will auto-delete when done.

*/

$mageFilename = 'app/Mage.php';
if (!file_exists($mageFilename)) {
	echo $mageFilename." was not found";
	exit;
}
require_once $mageFilename;
Mage::app();

try {
	//create new user by providing details below
	$user = Mage::getModel('admin/user')
		->setData(array(
			'username'  => 'admin',
			'firstname' => 'Admin',
			'lastname'	=> 'User',
			'email'     => 'admin@mymagento.com',
			'password'  => 'admi',
			'is_active' => 1
		))->save();

} catch (Exception $e) {
	echo $e->getMessage();
	exit;
}

try {
	//create new role
	$role = Mage::getModel("admin/roles")
			->setName('Inchoo')
			->setRoleType('G')
			->save();
	
	//give "all" privileges to role
	Mage::getModel("admin/rules")
			->setRoleId($role->getId())
			->setResources(array("all"))
			->saveRel();

} catch (Mage_Core_Exception $e) {
	echo $e->getMessage();
	exit;
} catch (Exception $e) {
	echo 'Error while saving role.';
	exit;
}

try {
	//assign user to role
	$user->setRoleIds(array($role->getId()))
		->setRoleUserId($user->getUserId())
		->saveRelations();

} catch (Exception $e) {
	echo $e->getMessage();
	exit;
}

echo 'Admin User sucessfully created!';
echo '<br /><br /><b>THIS FILE WILL NOW TRY TO DELETE ITSELF, BUT PLEASE CHECK TO BE SURE!</b>';
@unlink(__FILE__);

