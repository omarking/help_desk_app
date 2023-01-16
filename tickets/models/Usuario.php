<?php

namespace models;

require_once(dirname(__FILE__) . "/../utils/DB.class.php");
require_once(dirname(__FILE__) . "/Empresa.php");

use DB\DB as DB;
use models\Empresa as Empresa;

class Usuario
{
    public $idUsuario;
    public $nombre;
    public $apellidoMaterno;
    public $apellidoPaterno;
    public $telefono;
    public $username;
    public $password;
    public $status;
    public $empresa;
    public $access_token;

    public function __construct($array)
    {
        $this->idUsuario = $array["idUsuario"];
        $this->nombre = $array["nombre"];
        $this->apellidoMaterno = $array["apellidoMaterno"];
        $this->apellidoPaterno = $array["apellidoPaterno"];
        $this->telefono = $array["telefono"];
        $this->username = $array["username"];
        $this->password = $array["password"];
        $this->status = $array["status"];
        $this->empresa = Empresa::find($array["idEmpresa"]);
    }

    public function generateAccessToken()
    {
        $this->access_token = "12345";
    }

    public static function list()
    {
        $query = "CALL SP_USUARIO_LIST()";
        $result = DB::getInstance()->query($query);

        $data = [];
        foreach ($result as $item) {
            $data[] = new Usuario($item);
        }

        return $data;
    }

    public static function find($id)
    {
        $query = "CALL SP_USUARIO_FIND(?)";
        $params = [$id];
        $result = DB::getInstance()->query($query, $params);

        return count($result) > 0 ? new Usuario($result[0]) : null;
    }

    public static function findByUsermame($username)
    {
        $query = "CALL SP_USUARIO_FINDBYUSERNAME(?)";
        $params = [$username];
        $result = DB::getInstance()->query($query, $params);

        return count($result) > 0 ? new Usuario($result[0]) : null;
    }

    public static function save($data)
    {
        $query = "CALL SP_USUARIO_ADD(?,?,?,?,?,?,?,?,?)";
        $params = [
            $data["idUsuario"], $data["nombre"], $data["apellidopaterno"], $data["apellidomaterno"], $data["telefono"],
            $data["username"], $data["password"], $data["status"], $data["idEmpresa"]
        ];

        $result = DB::getInstance()->insert($query, $params);
        return $result;
    }

    public static function update($data)
    {
        $query = "CALL SP_USUARIO_EDIT(?,?,?,?,?,?,?,?,?)";
        $params = [
            $data["idUsuario"], $data["nombre"], $data["apellidopaterno"], $data["apellidomaterno"], $data["telefono"],
            $data["username"], $data["password"], $data["status"], $data["idEmpresa"]
        ];

        $result = DB::getInstance()->update($query, $params);
        return $result;
    }

    public static function delete($id)
    {
        $query = "CALL SP_USUARIO_DELETE(?)";
        $params = [
            $id
        ];

        $result = DB::getInstance()->insert($query, $params);
        return $result;
    }

    public static function login($username, $password)
    {
        $query = "CALL SP_USUARIO_LOGIN(?,?)";
        $params = [$username, $password];
        $result = DB::getInstance()->query($query, $params);

        $user = null;

        if (count($result) > 0) {
            $user = new Usuario($result[0]);
            $user->generateAccessToken();
        }
        return $user;
    }

    public static function saveIncidente($data)
    {
        $query = "CALL SP_INCIDENTE_ADD(?,?,?,?,?,?)";
        $params = [
            $data["idUsuario"], $data["idProyecto"], $data["ticketsFolio"], $data["fechaCreacion"], 
            $data["descripcionIncidente"], $data["descripcionComentario"]
        ];

        $result = DB::getInstance()->insert($query, $params);
        return $result;
    }
}
