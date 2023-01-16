<?php

namespace api;

require_once(dirname(__FILE__) . "/../api/BaseController.php");
require_once(dirname(__FILE__) . "/../models/Roles.php");

use Exception;
use models\Roles as Roles;

class RolesController extends BaseController
{
    public function getAction()
    {
        $strErrorDesc = '';
        $arrUriSegments = $this->getUriSegments();

        try {
            $data = '';

            switch ($arrUriSegments[0]) {
                case 'list':
                    $data = Roles::list();
                    break;
                case 'list-active':
                    $data = Roles::listActive();
                    break;
                case 'find':
                    $idRoles = $_GET['idRoles'];
                    $data = Roles::find($idRoles);
                    break;
            }

            $responseData = json_encode($data);
        } catch (Exception $e) {
            $strErrorDesc = $e->getMessage() . ' Something went wrong! Please contact support.';
            $strErrorHeader = 'HTTP/1.1 500 Internal Server Error';
        }

        // send output 
        if (!$strErrorDesc) {
            $this->sendOutput(
                $responseData,
                array('Content-Type: application/json', 'HTTP/1.1 200 OK')
            );
        } else {
            $this->sendOutput(
                json_encode(array('error' => $strErrorDesc)),
                array('Content-Type: application/json', $strErrorHeader)
            );
        }
    }

    public function postAction()
    {
    }

    public function evaluate()
    {
        $requestMethod = $_SERVER["REQUEST_METHOD"];

        if (strtoupper($requestMethod) == 'GET') {
            $this->getAction();
        } else if (strtoupper($requestMethod) == 'POST') {
            $this->postAction();
        } else {

            $strErrorDesc = 'Method not supported';
            $strErrorHeader = 'HTTP/1.1 422 Unprocessable Entity';

            $this->sendOutput(
                json_encode(array('error' => $strErrorDesc)),
                array('Content-Type: application/json', $strErrorHeader)
            );
        }
    }
}

$controller = new RolesController();
$controller->evaluate();
