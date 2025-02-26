<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM de gestion de la table vie_modele
 *
 * @author quinton
 *        
 */
class VieModele extends PpciModel
{
	function __construct()
	{
		$this->table = "vie_modele";
		$this->fields = array(
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
				"requis" => 0
			),
			"annee" => array(
				"type" => 1,
				"requis" => 1
			),
			"couleur" => array(
				"type" => 0,
				"requis" => 1
			)
		);
		parent::__construct();
	}

	/**
	 * Retourne l'ensemble des modèles pour l'année considérée
	 *
	 * @param int $annee        	
	 * @return array
	 */
	function getModelesFromAnnee(int $annee)
	{

		$sql = "SELECT vie_modele_id, vm.vie_implantation_id, vie_implantation_id2,
					annee, couleur,
					v1.vie_implantation_libelle, v2.vie_implantation_libelle as vie_implantation_libelle2
					from vie_modele vm
					join vie_implantation v1 on (vm.vie_implantation_id = v1.vie_implantation_id)
					left outer join vie_implantation v2 on (vm.vie_implantation_id2 = v2.vie_implantation_id)
					where annee = :annee:
					order by vie_modele_id";
		return $this->getListeParamAsPrepared($sql, array("annee" => $annee));
	}

	/**
	 * Recupere l'ensemble des modeles disponibles dans la base de donnees
	 *
	 * @return array
	 */
	function getAllModeles()
	{
		$sql = "SELECT * from v_vie_modele order by annee desc, couleur, vie_modele_id";
		return $this->getListeParam($sql);
	}
}
