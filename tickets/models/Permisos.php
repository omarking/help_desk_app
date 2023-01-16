<?php

namespace models;

require_once(dirname(__FILE__) . "/../utils/DB.class.php");

use DB\DB as DB;

class Permisos
{
    public $idPermisos;
    public $nombrePermiso;
    public $descripcionPermiso;
    public $status;

    public function __construct($array)
    {
        $this->idPermisos = $array["idPermisos"];
        $this->nombrePermiso = $array["nombrePermiso"];
        $this->descripcionPermiso = $array["descripcionPermiso"];
        $this->status = $array["status"];
    }

    public static function list()
    {
        $query = "CALL SP_PERMISOS_LIST()";
        $result = DB::getInstance()->query($query);

        $data = [];
        foreach ($result as $item) {
            $data[] = new Permisos($item);
        }

        return $data;
    }

    public static function find($id)
    {
        $query = "CALL SP_PERMISOS_FIND(?)";
        $params = [$id];
        $result = DB::getInstance()->query($query, $params);
        
        return count($result) > 0 ? new Permisos($result[0]) : null;
    }
}
