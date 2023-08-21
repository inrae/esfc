<?php

/**
 * ORM de gestion de la table ps_evenement
 *
 * @author quinton
 *        
 */
class PsEvenement extends ObjetBDD
{
    public $poissonSequence;
    public function __construct($p_connection, $param = array())
    {
        $this->table = "ps_evenement";
        $this->colonnes = array(
            "ps_evenement_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "poisson_sequence_id" => array(
                "type" => 1,
                "requis" => 1,
                "parentAttrib" => 1
            ),
            "ps_datetime" => array(
                "type" => 3,
                "requis" => 1
            ),

            "ps_libelle" => array(
                "type" => 0,
                "requis" => 1
            ),
            "ps_commentaire" => array(
                "type" => 0
            )
        );
        parent::__construct($p_connection, $param);
    }
    /**
     * Retourne l'ensemble des événements pour un poisson
     *
     * @param int $poisson_campagne_id        	
     * @return array
     */
    function getListeEvenementFromPoisson($poisson_campagne_id)
    {
        $sql = "select ps_evenement_id, poisson_campagne_id, poisson_sequence_id, 
					ps_datetime, ps_libelle, ps_commentaire,
					sequence_nom
					from ps_evenement
					join poisson_sequence using (poisson_sequence_id) 
					join sequence using (sequence_id)
					where poisson_campagne_id = :id
					order by ps_datetime ";
        return $this->getListeParamAsPrepared($sql, array("id" => $poisson_campagne_id));
    }

    /**
     * Retourne la liste des evenements a partir du numero de poisson_sequence
     *
     * @param int $poisson_sequence_id        	
     * @return array
     */
    function getListeFromPoissonSequence($poisson_sequence_id)
    {
        $sql = "select ps_evenement_id, poisson_sequence_id, ps_datetime, ps_libelle, ps_commentaire,
                    poisson_campagne_id
					from ps_evenement 
                    join poisson_sequence using (poisson_sequence_id)
					where poisson_sequence_id = :id
					order by ps_datetime";
        return $this->getListeParamAsPrepared($sql, array("id" => $poisson_sequence_id));
    }

    /**
     * Reecriture de la fonction lire pour separer la date et l'heure dans 2 champs
     * (non-PHPdoc)
     *
     * @see ObjetBDD::lire()
     */
    function lire($id, $getDefault = true, $parentValue = 0)
    {
        if ($id == 0) {
            $data = $this->getDefaultValue($parentValue);
        } else {
           $data = parent::lire($id, $getDefault, $parentValue); 
        }
        if (!isset($this->poissonSequence)) {
            $this->poissonSequence = $this->classInstanciate("poissonSequence","poissonSequence.class.php");
        }
        $dps = $this->poissonSequence->lire($parentValue);
        $data["poisson_campagne_id"] = $dps["poisson_campagne_id"];
        $date = explode(" ", $data["ps_datetime"]);
        $data["ps_date"] = $date[0];
        $data["ps_time"] = $date[1];
        return $data;
    }

    /**
     * Reecriture de la fonction ecrire pour generer le champ ps_datetime a partir
     * des champs separes
     * (non-PHPdoc)
     *
     * @see ObjetBDD::ecrire()
     */
    function ecrire($data)
    {
        $data["ps_datetime"] = $data["ps_date"] . " " . $data["ps_time"];
        return parent::ecrire($data);
    }
}
