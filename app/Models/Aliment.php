<?php

namespace App\Models;

use Ppci\Models\PpciModel;

class Aliment extends PpciModel

{

	public AlimentCategorie $alimentCategorie;

	function __construct()
	{
		$this->table = "aliment";
		$this->fields = array(
			"aliment_id" => array(
				"type" => 1,
				"key" => 1,
				"requis" => 1,
				"defaultValue" => 0
			),
			"aliment_libelle" => array(
				"type" => 0,
				"requis" => 1
			),
			"aliment_libelle_court" => array(
				"type" => 0,
				"requis" => 1
			),
			"aliment_type_id" => array(
				"type" => 1,
				"requis" => 1
			),
			"actif" => array(
				"type" => 1,
				"defaultValue" => 1,
				"requis" => 1
			)
		);
		parent::__construct();
	}
	function write($data): int
	{
		$id = parent::write($data);
		if ($id > 0) {
			/*
			 * Traitement des categories rattachees
			 */
			$this->ecrireTableNN("aliment_categorie", "aliment_id", "categorie_id", $id, $data["categorie"]);
		}
		return $id;
	}

	function supprimer($id)
	{
		if ($id > 0 && is_numeric($id)) {
			/*
			 * Suppression des rattachements aux catégories
			 */
			if (!isset($this->alimentCategorie)) {
				$this->alimentCategorie = new AlimentCategorie;
			}
			$this->alimentCategorie->supprimerChamp($id, "aliment_id");
			return parent::delete($id);
		}
	}
	/**
	 * Retourne la liste des aliments actuellement utilisés
	 *
	 * @return array
	 */
	function getListeActif()
	{
		$sql = "select * from aliment where actif = 1 order by aliment_libelle";
		return $this->getListeParam($sql);
	}

	function getListe($order = ""): array
	{
		$sql = "select * from aliment 
				join aliment_type using (aliment_type_id)
				order by aliment_libelle";
		return $this->getListeParam($sql);
	}
}
