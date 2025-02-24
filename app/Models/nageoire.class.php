<?php 
namespace App\Models;
use Ppci\Models\PpciModel;
/**
 * ORM de gestion de la table nageoire
 *
 * @author quinton
 *        
 */
class Nageoire extends PpciModel
{
    
    function __construct()
    {
        $this->table = "nageoire";
        $this->fields = array(
            "nageoire_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "nageoire_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct();
    }
}
