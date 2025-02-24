<?php 
namespace App\Models;
use Ppci\Models\PpciModel;
class SpermeCaract extends PpciModel
{

    function __construct()
    {
        $this->table = "sperme_caract";
        $this->fields = array(
            "sperme_id" => array(
                "type" => 1,
                "requis" => 1
            ),
            "sperme_caracteristique_id" => array(
                "type" => 1,
                "requis" => 1
            )
        );
        parent::__construct();
    }
}
