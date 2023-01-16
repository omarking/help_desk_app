<?php

namespace api;

require_once(dirname(__FILE__) . "/../api/BaseController.php");
require_once(dirname(__FILE__) . "/../models/Usuario.php");
require_once(dirname(__FILE__) . "/../models/UsuarioRoles.php");
require_once(dirname(__FILE__) . "/../models/RolesPermisos.php");
require_once(dirname(__FILE__) . "/../models/UsuarioProyecto.php");

use Exception;
use models\Permisos;
use models\Usuario as Usuario;
use models\UsuarioRoles as UsuarioRoles;
use models\RolesPermisos as RolesPermisos;
use models\UsuarioProyecto as UsuarioProyecto;

class UsuarioController extends BaseController
{
    public function getAction()
    {
        $strErrorDesc = '';
        $arrUriSegments = $this->getUriSegments();
        $arrQueryStringParams = $this->getQueryStringParams();

        try {
            $data = '';

            switch ($arrUriSegments[0]) {
                case 'list':
                    $data = Usuario::list();
                    break;
                case 'find':
                    $idUsuario = $_GET['idUsuario'];
                    $data = Usuario::find($idUsuario);
                    break;
                case 'usuarioRol':
                    $idUsuario = $_GET['idUsuario'];
                    $data = UsuarioRoles::findByUser($idUsuario);
                    break;
                case 'mis-proyectos':
                    $idUsuario = $_GET['idUsuario'];
                    $data = UsuarioProyecto::listByUsuario($idUsuario);
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
                case 'login':
                    $username = $_POST['username'];
                    $password = $_POST['password'];
                    $usuario = Usuario::login($username, $password);

                    if ($usuario == null) {
                        $data = ['error' => 'Credenciales incorrectas'];
                    } else {
                        if ($usuario->status == 'I') {
                            $data = ['error' => 'El usuario está inactivo'];
                        } else {
                            $roles = UsuarioRoles::findByUser($usuario->idUsuario);
                            if ($roles != null) {
                                $rolesPermisos = RolesPermisos::listByRol($roles->roles->idRoles);

                                $permisos = [];
                                foreach ($rolesPermisos as $item) {
                                    array_push($permisos, $item->permisos);
                                }

                                $data = [
                                    'user' => $usuario,
                                    'roles' => $roles->roles,
                                    'permisos' => $permisos
                                ];
                            } else {
                                $data = ['error' => 'El usuario no tiene rol asignado'];
                            }
                        }
                    }
                    break;
                case 'add':
                    $idUsuario = 0;
                    $nombre = $_POST['nombre'];
                    $apellidopaterno = $_POST['apellidopaterno'];
                    $apellidomaterno = $_POST['apellidomaterno'];
                    $telefono = $_POST['telefono'];
                    $username = $_POST['username'];
                    $password = $_POST['password'];
                    $status = $_POST['status'];
                    $idEmpresa = $_POST['idEmpresa'];
                    $idRoles = $_POST['idRoles'];

                    $usuario = Usuario::findByUsermame($username);
                    if ($usuario != null) {
                        $data = ['error' => 'El username ya existe'];
                    } else {
                        if (Usuario::save([
                            "idUsuario" => $idUsuario,
                            "nombre" => $nombre,
                            "apellidopaterno" => $apellidopaterno,
                            "apellidomaterno" => $apellidomaterno,
                            "telefono" => $telefono,
                            "username" => $username,
                            "password" => $password,
                            "status" => $status,
                            "idEmpresa" => $idEmpresa
                        ])) {
                            $usuario = Usuario::findByUsermame($username);
                            if (UsuarioRoles::save([
                                "idusuarioRoles" => 0,
                                "idUsuario" => $usuario->idUsuario,
                                "idRoles" => $idRoles
                            ])) {
                                $data = ['success' => 'Usuario registrado'];
                            } else {
                                $data = ['error' => 'Usuario registrado sin rol'];
                            }
                        } else {
                            $data = ['error' => 'No se pudo registrar el usuario'];
                        }
                    }
                    break;
                case 'edit':
                    $idUsuario = $_POST['idUsuario'];
                    $nombre = $_POST['nombre'];
                    $apellidopaterno = $_POST['apellidopaterno'];
                    $apellidomaterno = $_POST['apellidomaterno'];
                    $telefono = $_POST['telefono'];
                    $username = $_POST['username'];
                    $password = $_POST['password'];
                    $status = $_POST['status'];
                    $idEmpresa = $_POST['idEmpresa'];
                    $idRoles = $_POST['idRoles'];

                    if (Usuario::update([
                        "idUsuario" => $idUsuario,
                        "nombre" => $nombre,
                        "apellidopaterno" => $apellidopaterno,
                        "apellidomaterno" => $apellidomaterno,
                        "telefono" => $telefono,
                        "username" => $username,
                        "password" => $password,
                        "status" => $status,
                        "idEmpresa" => $idEmpresa
                    ])) {
                        if (UsuarioRoles::update([
                            "idusuarioRoles" => 0,
                            "idUsuario" => $idUsuario,
                            "idRoles" => $idRoles
                        ])) {
                            $data = ['success' => 'Usuario actualizado'];
                        } else {
                            $data = ['error' => 'No se pudo actualizar el rol del usuario'];
                        }
                    } else {
                        $data = ['error' => 'No se pudo actualizar el usuario'];
                    }
                    break;
                case 'delete':
                    $idUsuario = $_POST['idUsuario'];
                    if (Usuario::delete($idUsuario)) {
                        $data = ['success' => 'Usuario eliminado'];
                    } else {
                        $data = ['error' => 'No se pudo eliminar el usuario'];
                    }
                    break;
                case 'asignar-proyecto':
                    $idUsuario = $_POST['idUsuario'];
                    $idProyecto = $_POST['idProyecto'];

                    $usuarioProyecto = UsuarioProyecto::findByUsuarioProyecto($idUsuario, $idProyecto);

                    if ($usuarioProyecto == null) {
                        if (UsuarioProyecto::save([
                            "idUsuarioProyecto" => 0,
                            "idUsuario" => $idUsuario,
                            "idProyecto" => $idProyecto
                        ])) {
                            $data = ['success' => 'Proyecto asignado al usuario'];
                        } else {
                            $data = ['error' => 'No se pudo asignar el proyecto al usuario'];
                        }
                    } else {
                        $data = ['error' => 'El usuario ya cuenta con el proyecto'];
                    }
                    break;
                case 'add-incidente':
                    $idUsuario = $_POST['idUsuario'];
                    $idProyecto = $_POST['idProyecto'];
                    $ticketsFolio = $_POST['ticketsFolio'];
                    $fechaCreacion = $_POST['fechaCreacion'];
                    $descripcionIncidente = $_POST['descripcion'];
                    $descripcionComentario = $_POST['descripcionComentario'];

                    if (Usuario::saveIncidente([
                        "idUsuario" => $idUsuario,
                        "idProyecto" => $idProyecto,
                        "ticketsFolio" => $ticketsFolio,
                        "fechaCreacion" => $fechaCreacion,
                        "descripcionIncidente" => $descripcionIncidente,
                        "descripcionComentario" => $descripcionComentario,
                    ])) {
                        $data = ['success' => 'Incidente enviado correctamente'];
                    } else {
                        $data = ['error' => 'No se pudo enviar el incidente'];
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

$controller = new UsuarioController();
$controller->evaluate();
