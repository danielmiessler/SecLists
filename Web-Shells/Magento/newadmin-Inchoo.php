<?php
/*
 * Create New Admin User
 * @author    Ivan Weiler, Inchoo <web@inchoo.net>
 */

//define USERNAME, EMAIL and PASSWORD and uncomment(#) this 3 lines
#define('USERNAME','inchoo');
#define('EMAIL','xyz@inchoo.net');
#define('PASSWORD','inchoo555');


if(!defined('USERNAME') || !defined('EMAIL') || !defined('PASSWORD')){
        echo 'Edit this file and define USERNAME, EMAIL and PASSWORD.';
        exit;
}

//load Magento
$mageFilename = 'app/Mage.php';
if (!file_exists($mageFilename)) {
        echo $mageFilename." was not found";
        exit;
}
require_once $mageFilename;
Mage::app();

try {
        //create new user
        $user = Mage::getModel('admin/user')
                ->setData(array(
                        'username'  => USERNAME,
                        'firstname' => 'John',
                        'lastname'      => 'Doe',
                        'email'     => EMAIL,
                        'password'  => PASSWORD,
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

echo 'Admin User sucessfully created!<br /><br /><b>THIS FILE WILL NOW TRY TO DELETE ITSELF, BUT PLEASE CHECK TO BE SURE!</b>';
@unlink(__FILE__);
