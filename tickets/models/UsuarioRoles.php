<?php

namespace models;

require_once(dirname(__FILE__) . "/../utils/DB.class.php");
require_once(dirname(__FILE__) . "/Roles.php");
require_once(dirname(__FILE__) . "/Usuario.php");

use DB\DB as DB;
use models\Roles as Roles;
use models\Usuario as Usuario;

class UsuarioRoles
{
    public $idusuarioRoles;
    public $usuario;
    public $roles;

    public function __construct($array)
    {
        $this->idusuarioRoles = $array["idusuarioRoles"];
        $this->usuario = Usuario::find($array["idUsuario"]);
        $this->roles = Roles::find($array["idRoles"]);
    }

    public static function listByUser($idUsuario)
    {
        $query = "CALL SP_USUARIOROLES_LISTBYUSER(?)";
        $params = [$idUsuario];

        $result = DB::getInstance()->query($query, $params);

        $data = [];
        foreach ($result as $item) {
            $data[] = new UsuarioRoles($item);
        }

        return $data;
    }

    public static function find($id)
    {
        $query = "CALL SP_USUARIOROLES_FIND(?)";
        $params = [$id];
        $result = DB::getInstance()->query($query, $params);

        return count($result) > 0 ? new UsuarioRoles($result[0]) : null;
    }

    public static function findByUser($idUsuario)
    {
        $query = "CALL SP_USUARIOROLES_FINDBYUSER(?)";
        $params = [$idUsuario];
        $result = DB::getInstance()->query($query, $params);

        return count($result) > 0 ? new UsuarioRoles($result[0]) : null;
    }

    public static function save($data)
    {
        $query = "CALL SP_USUARIOROLES_ADD(?,?,?)";
        $params = [
            $data["idusuarioRoles"], $data["idUsuario"], $data["idRoles"]
        ];

        $result = DB::getInstance()->insert($query, $params);
        return $result;
    }

    public static function update($data)
    {
        $query = "CALL SP_USUARIOROLES_EDIT(?,?,?)";
        $params = [
            $data["idusuarioRoles"], $data["idUsuario"], $data["idRoles"]
        ];

        $result = DB::getInstance()->insert($query, $params);
        return $result;
    }
}
