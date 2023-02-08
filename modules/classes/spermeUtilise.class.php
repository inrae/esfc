<?php

/**
 * ORM de gestion de la table sperme_utilise
 *
 * @author quinton
 *        
 */
class SpermeUtilise extends ObjetBDD
{
    public SpermeCongelation $spermeCongelation;
    function __construct($bdd, $param = array())
    {
        $this->table = "sperme_utilise";
        $this->colonnes = array(
            "sperme_utilise_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "croisement_id" => array(
                "type" => 1,
                "requis" => 1,
                "parentAttrib" => 1
            ),
            "sperme_id" => array(
                "type" => 1,
                "requis" => 1
            ),
            "volume_utilise" => array(
                "type" => 1
            ),
            "nb_paillette_croisement" => array(
                "type" => 1
            )
        );
        parent::__construct($bdd, $param);
    }

    /**
     * Surcharge de la fonction ecrire
     * pour mettre a jour le nombre de paillettes utilisees
     *
     * {@inheritdoc}
     * @see ObjetBDD::ecrire()
     */
    function ecrire($data)
    {
        /*
         * Recuperation des donnees anciennes pour lire le nombre de paillettes precedemment utilisees
         */
        $dataold = $this->lire($data["sperme_utilise_id"]);
        $retour = parent::ecrire($data);

        if ($retour > 0) {
            if (($dataold["nb_paillette_croisement"] > 0 || $data["nb_paillette_croisement"] > 0) && $data["sperme_congelation_id"] > 0) {
                if (!isset($this->spermeCongelation)) {
                    $this->spermeCongelation = $this->classInstanciate("SpermeCongelation", "spermeCongelation.class.php");
                }
                $dsc = $this->spermeCongelation->lire($data["sperme_congelation_id"]);
                $dsc["nb_paillettes_utilisees"] = $dsc["nb_paillettes_utilisees"] - $dataold["nb_paillette_croisement"] + $data["nb_paillette_croisement"];
                $this->spermeCongelation->ecrire($dsc);
            }
        }
        return $retour;
    }

    /**
     * Fonction recuperant la liste des spermes utilises dans un croisement
     *
     * @param int $croisement_id
     * @return array
     */
    function getListFromCroisement(int $croisement_id)
    {
        $sql = "select sperme_utilise_id, matricule, prenom,
					sperme_date, congelation_date,
					volume_utilise, nb_paillette_croisement
					from sperme_utilise su
					join sperme s on  (s.sperme_id = su.sperme_id)
					join poisson_campagne using (poisson_campagne_id)
					join poisson using (poisson_id)
					left outer join sperme_congelation sc on (sc.sperme_congelation_id = su.sperme_congelation_id)";
        $where = " where croisement_id = :id";
        $order = " order by su.sperme_id";
        $this->colonnes["sperme_date"]["type"] = 2;
        $this->colonnes["congelation_date"]["type"] = 2;
        return $this->getListeParamAsPrepared($sql . $where . $order, array("id" => $croisement_id));
    }
}
