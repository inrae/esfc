<?php
/**
 * ORM de gestion de la table parent_poisson
 *
 * @author quinton
 *        
 */
class Parent_poisson extends ObjetBDD
{

    /**
     * Constructeur de la classe
     *
     * @param
     *            instance ADODB $bdd
     * @param array $param
     */
    function __construct($bdd, $param = array())
    {
        $this->table = "parent_poisson";
        $this->id_auto = 1;
        $this->colonnes = array(
            "parent_poisson_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "poisson_id" => array(
                "type" => 1,
                "requis" => 1,
                "parentAttrib" => 1
            ),
            "parent_id" => array(
                "type" => 1,
                "requis" => 1
            )
        );
        parent::__construct($bdd, $param);
    }

    /**
     * Retourne la liste des poissons parents
     *
     * @param int $poisson_id
     * @return array
     */
    function getListParent($poisson_id)
    {
        if ($poisson_id > 0 && is_numeric($poisson_id)) {
            $sql = "select parent_poisson_id, par.poisson_id, parent_id, matricule, pittag_valeur, prenom, sexe_libelle, cohorte
					from " . $this->table . " par
					join poisson pois on (par.parent_id = pois.poisson_id)
					left outer join sexe using (sexe_id)
					left outer join v_pittag_by_poisson pit on (pois.poisson_id = pit.poisson_id)
					where par.poisson_id = " . $poisson_id . " order by matricule, pittag_valeur, prenom ";
            return $this->getListeParam($sql);
        }
    }

    /**
     * Retourne les parents
     *
     * @param int $id
     * @return array
     */
    function lireAvecParent($id)
    {
        if ($id > 0 && is_numeric($id)) {
            $sql = "select parent_poisson_id, parent_poisson.poisson_id, parent_id,
				matricule, prenom, pittag_valeur
				from " . $this->table . "
				join poisson on (parent_poisson.parent_id = poisson.poisson_id)
				left outer join v_pittag_by_poisson pit on (poisson.poisson_id = pit.poisson_id)
				where parent_poisson_id = " . $id;
            return $this->lireParam($sql);
        }
    }

    /**
     * Retourne la liste des enfants attaches a un parent
     *
     * @param int $parent_id
     * @return array
     */
    function lireEnfant($parent_id)
    {
        if ($parent_id > 0 && is_numeric($parent_id)) {
            $sql = "select parent_poisson_id, parent_poisson.poisson_id, parent_id,
				matricule, prenom, pittag_valeur
				from " . $this->table . "
				join poisson on (parent_poisson.poisson_id = poisson.poisson_id)
				left outer join v_pittag_by_poisson pit on (poisson.poisson_id = pit.poisson_id)
				where parent_id = " . $parent_id;
        }
        return $this->getListeParam($sql);
    }
}
