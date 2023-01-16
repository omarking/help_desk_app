<?php

namespace models;

require_once(dirname(__FILE__) . "/../utils/DB.class.php");
require_once(dirname(__FILE__) . "/Roles.php");
require_once(dirname(__FILE__) . "/Permisos.php");

use DB\DB as DB;
use models\Roles as Roles;
use models\Permisos as Permisos;

class RolesPermisos
{
    public $idrolesPermisos;
    public $roles;
    public $permisos;

    public function __construct($array)
    {
        $this->idrolesPermisos = $array["idrolesPermisos"];        
        $this->roles = Roles::find($array["roles_idRoles"]);
        $this->permisos = Permisos::find($array["permisos_idPermisos"]);
    }

    public static function listByRol($roles_idRoles)
    {
        $query = "CALL SP_ROLESPERMISOS_LISTBYROL(?)";
        $params = [$roles_idRoles];
        $result = DB::getInstance()->query($query, $params);

        $data = [];
        foreach ($result as $item) {
            $data[] = new RolesPermisos($item);
        }

        return $data;
    }
}
