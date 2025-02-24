<?php 
namespace App\Models;
use Ppci\Models\PpciModel;
/**
 * ORM de la table gender_methode
 *
 * @author quinton
 *        
 */
class Gender_methode extends PpciModel
{

    
    function __construct()
    {
        $this->table = "gender_methode";
        $this->fields = array(
            "gender_methode_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "gender_methode_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct();
    }
}
