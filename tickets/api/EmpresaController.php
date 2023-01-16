<?php

namespace api;

require_once(dirname(__FILE__) . "/../api/BaseController.php");
require_once(dirname(__FILE__) . "/../models/Empresa.php");

use Exception;
use models\Empresa as Empresa;

class EmpresaController extends BaseController
{
    public function getAction()
    {
        $strErrorDesc = '';
        $arrUriSegments = $this->getUriSegments();

        try {
            $data = '';

            switch ($arrUriSegments[0]) {
                case 'list':
                    $data = Empresa::list();
                    break;
                case 'list-active':
                    $data = Empresa::listActive();
                    break;
                case 'find':
                    $idEmpresa = $_GET['idEmpresa'];
                    $data = Empresa::find($idEmpresa);
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
        $strErrorDesc = '';
        $arrUriSegments = $this->getUriSegments();
        $arrQueryStringParams = $this->getQueryStringParams();

        try {
            $data = '';

            switch ($arrUriSegments[0]) {
                case 'add':
                    $idEmpresa = 0;
                    $nombreEmpresa = $_POST['nombreEmpresa'];
                    $telefono = $_POST['telefono'];
                    $email = $_POST['email'];
                    $status = $_POST['status'];

                    if (Empresa::save([
                        "idEmpresa" => $idEmpresa,
                        "nombreEmpresa" => $nombreEmpresa,
                        "telefono" => $telefono,
                        "email" => $email,
                        "status" => $status
                    ])) {
                        $data = ['success' => 'Empresa registrada'];
                    } else {
                        $data = ['error' => 'No se pudo registrar la empresa'];
                    }
                    break;
                case 'edit':
                    $idEmpresa = $_POST['idEmpresa'];
                    $nombreEmpresa = $_POST['nombreEmpresa'];
                    $telefono = $_POST['telefono'];
                    $email = $_POST['email'];
                    $status = $_POST['status'];

                    if (Empresa::update([
                        "idEmpresa" => $idEmpresa,
                        "nombreEmpresa" => $nombreEmpresa,
                        "telefono" => $telefono,
                        "email" => $email,
                        "status" => $status
                    ])) {
                        $data = ['success' => 'Empresa actualizada'];
                    } else {
                        $data = ['error' => 'No se pudo actualizar la empresa'];
                    }
                    break;
                case 'delete':
                    $idEmpresa = $_POST['idEmpresa'];
                    if (Empresa::delete($idEmpresa)) {
                        $data = ['success' => 'Empresa eliminada'];
                    } else {
                        $data = ['error' => 'No se pudo eliminar la empresa'];
                    }
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

$controller = new EmpresaController();
$controller->evaluate();
