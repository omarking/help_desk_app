<?php

namespace api;

require_once(dirname(__FILE__) . "/../api/BaseController.php");
require_once(dirname(__FILE__) . "/../models/Proyecto.php");

use Exception;
use models\Proyecto as Proyecto;

class ProyectoController extends BaseController
{
    public function getAction()
    {
        $strErrorDesc = '';
        $arrUriSegments = $this->getUriSegments();

        try {
            $data = '';

            switch ($arrUriSegments[0]) {
                case 'list':
                    $data = Proyecto::list();
                    break;
                case 'list-active':
                    $data = Proyecto::listActive();
                    break;
                case 'find':
                    $idProyecto = $_GET['idProyecto'];
                    $data = Proyecto::find($idProyecto);
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
                    $idProyecto = 0;
                    $nombreProyecto = $_POST['nombreProyecto'];
                    $descripcion = $_POST['descripcion'];
                    $status = $_POST['status'];

                    if (Proyecto::save([
                        "idProyecto" => $idProyecto,
                        "nombreProyecto" => $nombreProyecto,
                        "descripcion" => $descripcion,
                        "status" => $status
                    ])) {
                        $data = ['success' => 'Proyecto registrado'];
                    } else {
                        $data = ['error' => 'No se pudo registrar el proyecto'];
                    }
                    break;
                case 'edit':
                    $idProyecto = $_POST['idProyecto'];
                    $nombreProyecto = $_POST['nombreProyecto'];
                    $descripcion = $_POST['descripcion'];
                    $status = $_POST['status'];

                    if (Proyecto::update([
                        "idProyecto" => $idProyecto,
                        "nombreProyecto" => $nombreProyecto,
                        "descripcion" => $descripcion,
                        "status" => $status
                    ])) {
                        $data = ['success' => 'Proyecto actualizado'];
                    } else {
                        $data = ['error' => 'No se pudo actualizar el proyecto'];
                    }
                    break;
                case 'delete':
                    $idProyecto = $_POST['idProyecto'];
                    if (Proyecto::delete($idProyecto)) {
                        $data = ['success' => 'Proyecto eliminado'];
                    } else {
                        $data = ['error' => 'No se pudo eliminar el proyecto'];
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

$controller = new ProyectoController();
$controller->evaluate();
