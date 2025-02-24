<?php 
namespace App\Models;
use Ppci\Models\PpciModel;

/**
 * ORM de la table mortalite_type
 *
 * @author quinton
 *        
 */
class Mortalite_type extends PpciModel
{
    
    function __construct()
    {
        $this->table = "mortalite_type";
        $this->fields = array(
            "mortalite_type_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "mortalite_type_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct();
    }
}
