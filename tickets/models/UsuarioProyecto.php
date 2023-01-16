<?php

namespace models;

require_once(dirname(__FILE__) . "/../utils/DB.class.php");
require_once(dirname(__FILE__) . "/Proyecto.php");
require_once(dirname(__FILE__) . "/Usuario.php");

use DB\DB as DB;
use models\Proyecto as Proyecto;
use models\Usuario as Usuario;

class UsuarioProyecto
{
    public $idUsuarioProyecto;
    public $usuario;
    public $proyecto;

    public function __construct($array)
    {
        $this->idUsuarioProyecto = $array["idUsuarioProyecto"];        
        $this->usuario = Usuario::find($array["idUsuario"]);
        $this->proyecto = Proyecto::find($array["idProyectos"]);
    }

    public static function listByUsuario($idUsuario)
    {
        $query = "CALL SP_USUARIOPROYECTO_LISTBYUSUARIO(?)";
        $params = [$idUsuario];
        $result = DB::getInstance()->query($query, $params);

        $data = [];
        foreach ($result as $item) {
            $data[] = new UsuarioProyecto($item);
        }

        return $data;
    }

    public static function findByUsuarioProyecto($idUsuario, $idProyecto)
    {
        $query = "CALL SP_USUARIOPROYECTO_FIND(?, ?)";
        $params = [$idUsuario, $idProyecto];
        $result = DB::getInstance()->query($query, $params);

        return count($result) > 0 ? new UsuarioProyecto($result[0]) : null;
    }

    public static function save($data)
    {
        $query = "CALL SP_USUARIOPROYECTO_ADD(?,?,?)";
        $params = [
            $data["idUsuarioProyecto"], $data["idUsuario"], $data["idProyecto"]
        ];

        $result = DB::getInstance()->insert($query, $params);
        return $result;
    }
}
