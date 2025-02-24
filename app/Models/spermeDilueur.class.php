<?php 
namespace App\Models;
use Ppci\Models\PpciModel;
/**
 * ORM de gestion de la table sperme_dilueur
 *
 * @author quinton
 *        
 */
class SpermeDilueur extends PpciModel
{

    function __construct()
    {
        $this->table = "sperme_dilueur";
        $this->fields = array(
            "sperme_dilueur_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "sperme_dilueur_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct();
    }
}
