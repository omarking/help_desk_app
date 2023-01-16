<?php

namespace models;

require_once(dirname(__FILE__) . "/../utils/DB.class.php");

use DB\DB as DB;

class Roles
{
    public $idRoles;
    public $roles;
    public $status;

    public function __construct($array)
    {
        $this->idRoles = $array["idRoles"];
        $this->roles = $array["roles"];
        $this->status = $array["status"];
    }

    public static function list()
    {
        $query = "CALL SP_ROLES_LIST()";
        $result = DB::getInstance()->query($query);

        $data = [];
        foreach ($result as $item) {
            $data[] = new Roles($item);
        }

        return $data;
    }

    public static function listActive()
    {
        $query = "CALL SP_ROLES_LISTACTIVE()";
        $result = DB::getInstance()->query($query);

        $data = [];
        foreach ($result as $item) {
            $data[] = new Roles($item);
        }

        return $data;
    }

    public static function find($id)
    {
        $query = "CALL SP_ROLES_FIND(?)";
        $params = [$id];
        $result = DB::getInstance()->query($query, $params);

        return count($result) > 0 ? new Roles($result[0]) : null;
    }
}
