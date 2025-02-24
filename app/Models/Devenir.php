<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * @author : quinton
 * @date : 1 févr. 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */

/**
 * ORM de gestion de la table devenir
 * @author quinton
 *
 */
class Devenir extends PpciModel
{
	public Lot $lot;
	private $sql = "select d1.*, dt1.devenir_type_libelle, sl1.localisation,
			c.categorie_libelle, lot_nom,
			d2.devenir_date as devenir_date_parent, dt2.devenir_type_libelle as devenir_type_libelle_parent,
			c2.categorie_libelle as categorie_libelle_parent,
			sl2.localisation as localisation_parent, d2.poisson_nombre as poisson_nombre_parent,
			site_name
			from devenir d1
			join devenir_type dt1 on (d1.devenir_type_id = dt1.devenir_type_id)
			join categorie c on (c.categorie_id = d1.categorie_id) 
			left outer join sortie_lieu sl1 on  (sl1.sortie_lieu_id = d1.sortie_lieu_id)
			left outer join lot on (lot.lot_id = d1.lot_id)
			left outer join croisement using (croisement_id)
			left outer join sequence using (sequence_id)
			left outer join site using (site_id)
			left outer join devenir d2 on (d2.devenir_id = d1.parent_devenir_id)
			left outer join devenir_type dt2 on (d2.devenir_type_id = dt2.devenir_type_id)
			left outer join categorie c2 on (c2.categorie_id = d2.categorie_id)
			left outer join sortie_lieu sl2 on (sl2.sortie_lieu_id = d2.sortie_lieu_id)
			";
	private $sqlOrder = " order by lot_nom, d1.devenir_date";
	/**
	 * Constructeur
	 */
	function __construct()
	{
		$this->table = "devenir";
		$this->fields = array(
			"devenir_id" => array("type" => 1, "key" => 1, "requis" => 1, "defaultValue" => 0),
			"devenir_type_id" => array("type" => 1, "requis" => 1),
			"lot_id" => array("type" => 1, "parentAttrib" => 1),
			"sortie_lieu_id" => array("type" => 1),
			"categorie_id" => array("type" => 1, "requis" => 1),
			"devenir_date" => array("type" => 2, "requis" => 1),
			"poisson_nombre" => array("type" => 1),
			"parent_devenir_id" => array("type" => 1)

		);
		parent::__construct();
	}
	/**
	 * Retourne la liste des lachers realises
	 * @param int $annee
	 * @return array
	 */
	function getListeFull(int $annee = 0)
	{
		$where = "";
		$param = array();
		if ($annee > 0) {
			$where = " where extract(year from d1.devenir_date) = :annee:";
			$param["annee"] = $annee;
		}
		$this->fields["devenir_date_parent"]["type"] = 2;
		return $this->getListeParamAsPrepared($this->sql . $where . $this->sqlOrder, $param);
	}
	/**
	 * Retourne la liste des devenirs pour un lot considere
	 * @param int $lotId
	 * @return array
	 */
	function getListFromLot(int $lotId)
	{
		$where = " where d1.lot_id = :id:";
		$this->fields["devenir_date_parent"]["type"] = 2;
		return $this->getListeParamAsPrepared($this->sql . $where . $this->sqlOrder, array("id" => $lotId));
	}

	/**
	 * Retourne la liste des devenirs potentiels pour un devenir considere
	 * @param int $id : devenir_id fils
	 * @param int $lotId : numero du lot
	 * @param int $annee : annee de reproduction
	 * @return array
	 */
	function getParentsPotentiels(int $id, int $lot_id = 0, int $annee = 0)
	{
		$param = array("id" => $id);
		$where = " where d1.devenir_id <> :id:";
		if ($lot_id > 0) {
			$where .= " and d1.lot_id = :lot_id:";
			$param["lot_id"] = $lot_id;
		}
		if ($annee > 0) {
			$where .= " and extract(year from d1.devenir_date) = :annee:";
			$param["annee"] = $annee;
		}
		$this->fields["devenir_date_parent"]["type"] = 2;
		return $this->getListeParamAsPrepared($this->sql . $where . $this->sqlOrder, $param);
	}

	function write($data): int
	{

		$id = parent::write($data);
		/**
		 * Search for a creation of a derivated lot
		 */
		if ($data["devenir_type_id"] == 6 && $data["devenir_id"] == 0) {
			if (!isset($this->lot)) {
				$this->lot = new Lot;
			}
			/**
			 * Search for preexistant sublots
			 */
			$sql = "select count(*) as nb from lot where parent_lot_id = :lot_id:";
			$count = $this->lireParamAsPrepared($sql, array("lot_id" => $data["lot_id"]));
			$nb = $count["nb"] + 1;
			$dataLot = $this->lot->lire($data["lot_id"]);
			$dataLot["parent_lot_id"] = $data["lot_id"];
			$dataLot["lot_id"] = 0;
			$dataLot["nb_larve_initial"] = $data["poisson_nombre"];
			$dataLot["nb_larve_compte"] = $data["poisson_nombre"];
			$dataLot["lot_nom"] .= "-" . $nb;
			$this->lot->ecrire($dataLot);
		}
		return $id;
	}
}
