<?php

/**
 * ORM de gestion de la table sperme_caracteristique
 *
 * @author quinton
 *        
 */
class SpermeCaracteristique extends ObjetBDD
{

    function __construct($bdd, $param = array())
    {
        $this->table = "sperme_caracteristique";
        $this->colonnes = array(
            "sperme_caracteristique_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "sperme_caracteristique_libelle" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct($bdd, $param);
    }

    /**
     * Retourne la liste des caracteristiques, attachees ou non au sperme_id fourni
     *
     * @param number $sperme_id
     * @return array
     */
    function getFromSperme(int $sperme_id = 0)
    {

        $sql = "select s.sperme_caracteristique_id, s.sperme_caracteristique_libelle, sperme_id
					from sperme_caracteristique s
					left outer join sperme_caract c on (s.sperme_caracteristique_id = c.sperme_caracteristique_id 
					and c.sperme_id = :id)
						order by sperme_caracteristique_libelle";
        return $this->getListeParamAsPrepared($sql, array("id" => $sperme_id));
    }
}
