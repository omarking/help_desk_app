<?php

namespace models;

require_once(dirname(__FILE__) . "/../utils/DB.class.php");

use DB\DB as DB;

class Proyecto
{
    public $idProyecto;
    public $nombreProyecto;
    public $descripcion;
    public $status;

    public function __construct($array)
    {
        $this->idProyecto = $array["idProyectos"];
        $this->nombreProyecto = $array["nombreProyecto"];
        $this->descripcion = $array["descripcion"];
        $this->status = $array["status"];
    }

    public static function list()
    {
        $query = "CALL SP_PROYECTO_LIST()";
        $result = DB::getInstance()->query($query);

        $data = [];
        foreach ($result as $item) {
            $data[] = new Proyecto($item);
        }

        return $data;
    }

    public static function listActive()
    {
        $query = "CALL SP_PROYECTO_LISTACTIVE()";
        $result = DB::getInstance()->query($query);

        $data = [];
        foreach ($result as $item) {
            $data[] = new Proyecto($item);
        }

        return $data;
    }

    public static function find($id)
    {
        $query = "CALL SP_PROYECTO_FIND(?)";
        $params = [
            $id
        ];
        $result = DB::getInstance()->query($query, $params);

        return count($result) > 0 ? new Proyecto($result[0]) : null;
    }

    public static function save($data)
    {
        $query = "CALL SP_PROYECTO_ADD(?,?,?,?)";
        $params = [
            $data["idProyecto"], $data["nombreProyecto"], $data["descripcion"], $data["status"]
        ];

        $result = DB::getInstance()->insert($query, $params);
        return $result;
    }

    public static function update($data)
    {
        $query = "CALL SP_PROYECTO_EDIT(?,?,?,?)";
        $params = [
            $data["idProyecto"], $data["nombreProyecto"], $data["descripcion"], $data["status"]
        ];

        $result = DB::getInstance()->update($query, $params);
        return $result;
    }

    public static function delete($id)
    {
        $query = "CALL SP_PROYECTO_DELETE(?)";
        $params = [
            $id
        ];

        $result = DB::getInstance()->insert($query, $params);
        return $result;
    }
}
