<?php

namespace models;

require_once(dirname(__FILE__) . "/../utils/DB.class.php");

use DB\DB as DB;

class Empresa
{
    public $idEmpresa;
    public $nombreEmpresa;
    public $telefono;
    public $email;
    public $status;

    public function __construct($array)
    {
        $this->idEmpresa = $array["idEmpresa"];
        $this->nombreEmpresa = $array["nombreEmpresa"];
        $this->telefono = $array["telefono"];
        $this->email = $array["email"];
        $this->status = $array["status"];
    }

    public static function list()
    {
        $query = "CALL SP_EMPRESA_LIST()";
        $result = DB::getInstance()->query($query);

        $data = [];
        foreach ($result as $item) {
            $data[] = new Empresa($item);
        }

        return $data;
    }

    public static function listActive()
    {
        $query = "CALL SP_EMPRESA_LISTACTIVE()";
        $result = DB::getInstance()->query($query);

        $data = [];
        foreach ($result as $item) {
            $data[] = new Empresa($item);
        }

        return $data;
    }

    public static function find($id)
    {
        $query = "CALL SP_EMPRESA_FIND(?)";
        $params = [
            $id
        ];
        $result = DB::getInstance()->query($query, $params);

        return count($result) > 0 ? new Empresa($result[0]) : null;
    }

    public static function save($data)
    {
        $query = "CALL SP_EMPRESA_ADD(?,?,?,?,?)";
        $params = [
            $data["idEmpresa"], $data["nombreEmpresa"], $data["telefono"], $data["email"], $data["status"]
        ];

        $result = DB::getInstance()->insert($query, $params);
        return $result;
    }

    public static function update($data)
    {
        $query = "CALL SP_EMPRESA_EDIT(?,?,?,?,?)";
        $params = [
            $data["idEmpresa"], $data["nombreEmpresa"], $data["telefono"], $data["email"], $data["status"]
        ];

        $result = DB::getInstance()->update($query, $params);
        return $result;
    }

    public static function delete($id)
    {
        $query = "CALL SP_EMPRESA_DELETE(?)";
        $params = [
            $id
        ];

        $result = DB::getInstance()->insert($query, $params);
        return $result;
    }
}
