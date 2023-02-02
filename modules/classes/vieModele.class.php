<?php
/**
 * ORM de gestion de la table vie_modele
 *
 * @author quinton
 *        
 */
class VieModele extends ObjetBDD
{
	function __construct($bdd, $param = null)
	{
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "vie_modele";
		$this->id_auto = "1";
		$this->colonnes = array(
			"vie_modele_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"vie_implantation_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"vie_implantation_id2" => array(
				"type" => 1,
				"requis" => 1
			),
			"annee" => array(
				"type" => 1,
				"requis" => 1
			),
			"couleur" => array(
				"type" => 0,
				"requis" => 0
			)
		);
		if (!is_array($param))
			$param = array();
		$param["fullDescription"] = 1;
		parent::__construct($bdd, $param);
	}

	/**
	 * Retourne l'ensemble des modèles pour l'année considérée
	 *
	 * @param int $annee        	
	 * @return tableau
	 */
	function getModelesFromAnnee($annee)
	{
		if ($annee > 0 && is_numeric($annee)) {
			$sql = "select vie_modele_id, vm.vie_implantation_id, vie_implantation_id2,
					annee, couleur,
					v1.vie_implantation_libelle, v2.vie_implantation_libelle as vie_implantation_libelle2
					from vie_modele vm
					join vie_implantation v1 on (vm.vie_implantation_id = v1.vie_implantation_id)
					join vie_implantation v2 on (vm.vie_implantation_id2 = v2.vie_implantation_id)
					where annee = " . $annee . " 
					order by vie_modele_id";
			return $this->getListeParam($sql);
		}
	}

	/**
	 * Recupere l'ensemble des modeles disponibles dans la base de donnees
	 *
	 * @return tableau
	 */
	function getAllModeles()
	{
		$sql = "select * from v_vie_modele order by annee desc, couleur, vie_modele_id";
		return $this->getListeParam($sql);
	}
}