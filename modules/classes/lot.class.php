<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 13 mars 2015
 */

class lotException extends Exception
{
}
/**
 * ORM  de gestion de la table Lot
 * @author quinton
 *
 */
class Lot extends ObjetBDD
{
	public BassinLot $bassinLot;
	public Croisement $croisement;
	public LotMesure $lotMesure;
	public Devenir $devenir;

	/**
	 * 
	 * Constructeur de la classe
	 *
	 * @param
	 *        	instance ADODB $bdd
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array())
	{
		$this->table = "lot";
		$this->colonnes = array(
			"lot_id" => array(
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
			"lot_nom" => array(
				"type" => 0,
				"requis" => 1
			),
			"nb_larve_initial" => array(
				"type" => 1
			),
			"nb_larve_compte" => array(
				"type" => 1
			),
			"eclosion_date" => array(
				"type" => 2
			),
			"vie_modele_id" => array(
				"type" => 1
			),
			"vie_date_marquage" => array(
				"type" => 2
			),
			"parent_lot_id" => array(
				"type" => 1
			)
		);
		parent::__construct($bdd, $param);
	}

	/**
	 * Retourne la liste des lots pour une annee
	 *
	 * @param int $annee        	
	 * @return array
	 */
	function getLotByAnnee(int $annee)
	{
		$where = " where s.annee = :annee";
		return $this->getDataParam($where, array("annee" => $annee));
	}
	/**
	 * Retourne les lots a partir du numero de sequence
	 *
	 * @param int $sequence_id        	
	 * @return array
	 */
	function getLotBySequence(int $sequence_id)
	{
		$where = " where sequence_id = :sequence_id";
		return $this->getDataParam($where, array("sequence_id" => $sequence_id));
	}

	/**
	 * Fonction retournant la liste des lots en fonction du critere de recherche fourni
	 *
	 * @param string $where    
	 * @param array $param    	
	 * @return array
	 */
	private function getDataParam($where, $param = array())
	{
		$data = array();
		if (strlen($where) > 0) {
			$sql = "select l.lot_id, l.lot_nom, l.croisement_id, l.nb_larve_initial, l.nb_larve_compte,
					croisement_date,
					sequence_id, s.annee, sequence_nom, croisement_nom, l.eclosion_date, l.vie_date_marquage,
					l.vie_modele_id, couleur, vie_implantation_libelle, vie_implantation_libelle2,
					 extract(epoch from age(l.eclosion_date))/86400 as age,
					 site_id, site_name,
					 parent.lot_nom parent_lot_nom, l.parent_lot_id
					from lot l
					join croisement c on  (c.croisement_id = l.croisement_id)
					join sequence s using (sequence_id)
					left outer join site using (site_id)
					left outer join v_vie_modele vm on (vm.vie_modele_id = l.vie_modele_id)
					left outer join lot parent on (l.parent_lot_id = parent.lot_id)
					";
			$order = " order by sequence_nom, lot_nom";
			$data = $this->getListeParamAsPrepared($sql . $where . $order, $param);
			/*
			 * Mise en forme des donnees, recuperation des reproducteurs et du bassin
			 */
			if (!isset($this->bassinLot)) {
				$this->bassinLot = $this->classInstanciate("BassinLot", "bassinLot.class.php");
			}
			if (!isset($this->croisement)) {
				$this->croisement = $this->classInstanciate("Croisement", "croisement.class.php");
			}
			foreach ($data as $key => $value) {
				$data[$key]["croisement_date"] = $this->formatDateDBversLocal($value["croisement_date"]);
				$data[$key]["parents"] = $this->croisement->getParentsFromCroisement($value["croisement_id"]);
				/*
				 * Recherche du bassin
				 */
				$date = new DateTime();
				$dataBassin = $this->bassinLot->getBassin($value["lot_id"], $date->format("d/m/Y"));
				$data[$key]["bassin_id"] = $dataBassin["bassin_id"];
				$data[$key]["bassin_nom"] = $dataBassin["bassin_nom"];
			}
		}
		return $data;
	}

	/**
	 * Retourne le detail d'un lot
	 *
	 * @param int $lot_id        	
	 * @return array
	 */
	function getDetail($lot_id)
	{
		$where = " where l.lot_id = :lot_id";
		$data = $this->getDataParam($where, array("lot_id" => $lot_id));
		if (is_array($data)) {
			return $data[0];
		} else {
			return array();
		}
	}

	function getDerivatedLots($lot_id) {
		$where = " where l.parent_lot_id = :lot_id";
		return $this->getDataParam($where, array("lot_id" => $lot_id));
	}

	/**
	 * Compte le nombre de larves pour tous les lots d'un croisement
	 *
	 * @param int $croisement_id        	
	 * @return array
	 */
	function getNbLarveFromCroisement($croisement_id)
	{
		$sql = "select sum(nb_larve_initial) as total_larve_initial, 
					sum(nb_larve_compte) as total_larve_compte
				from lot
				where croisement_id = :croisement_id";
		return $this->lireParamAsPrepared($sql, array("croisement_id" => $croisement_id));
	}
	/**
	 * Retourne un enregistrement a partir de la valeur de vie_modele_id
	 * 
	 * @param int $vie_modele_id        	
	 * @return array
	 */
	function getFromVieModele($vie_modele_id)
	{
		$sql = "select * from lot where vie_modele_id = :id";
		return $this->lireParamAsPrepared($sql, array("id" => $vie_modele_id));
	}
	/**
	 * Retourne les parents d'un lot
	 * @param int $lot_id
	 * @return array
	 */
	function getParents($lot_id)
	{
		$sql = "select poisson_id
				from lot
				join poisson_croisement using (croisement_id)
				join poisson_campagne using (poisson_campagne_id)
				where lot_id = :lot_id";
		return $this->getListeParamAsPrepared($sql, array("lot_id" => $lot_id));
	}

	/**
	 * Retourne la liste des lots dont la date de naissance est anterieure a la date fournie,
	 * pour l'annee consideree
	 * @param string $dateDebut
	 * @return array
	 */
	function getListAfterDate($dateDebut)
	{
		$dateDebut = $this->formatDateLocaleVersDB($dateDebut);
		$sql = "select lot_id, lot_nom, croisement_id, nb_larve_initial, eclosion_date,
					s.annee, sequence_nom
				from lot
				join croisement using (croisement_id)
				join sequence s using (sequence_id)
				where eclosion_date < :date_debut
					and extract(year from eclosion_date) = :annee
				order by lot_nom";
		return $this->getListeParamAsPrepared(
			$sql,
			array(
				"date_debut" => $dateDebut,
				"annee" => substr($dateDebut, 0, 4)
			)
		);
	}

	/**
	 * Retourne les informations sur les lots pour la liste des lots fournie
	 * @param array $lots
	 * @return array
	 */
	function getDataFromListe($lots)
	{
		$data = array();
		$liste = "";
		$param = array();
		$i = 1;
		foreach ($lots as $value) {
			if ($i > 1) {
				$liste .= ", ";
			}
			$liste .= ":lot" . $i;
			$param["lot" . $i] = $value;
			$i++;
		}
		if ($i > 1) {
			$sql = "select lot_id, lot_nom, croisement_id, nb_larve_initial, eclosion_date,
					s.annee, sequence_nom
				from lot
				join croisement using (croisement_id)
				join sequence s using (sequence_id)
				where lot_id in (" . $liste . ")";
			$data = $this->getListeParamAsPrepared($sql, $param);
		}
		return $data;
	}

	function supprimer($lot_id) {
		/**
		 * Search if the lot is referenced by another
		 */
		$data = array("lot_id"=>$lot_id);
		$sql = "select count(*) as nb from lot where parent_lot_id = :lot_id";
		$res = $this->lireParamAsPrepared($sql, $data);
		if ($res["nb"] > 0) {
			throw new ObjetBDDException(_("Le lot a été partagé en un ou plusieurs lots, sa suppression n'est pas possible"));
		}
		/**
		 * Search if exists devenir item
		 */
		$sql = "select count(*) as nb from devenir where lot_id = :lot_id";
		$res = $this->lireParamAsPrepared($sql, $data);
		if ($res["nb"] > 0) {
			throw new ObjetBDDException(_("Des destinations ont été enregistrées pour les poissons du lot, sa suppression n'est pas possible"));
		}
		/**
		 * Delete from lot_mesure
		 */
		if (!isset ($this->lotMesure)) {
			$this->lotMesure = $this->classInstanciate("LotMesure", "lotMesure.class.php");
		}
		$this->lotMesure->supprimerChamp($lot_id, "lot_id");
		/**
		 * Delete from bassin_lot
		 */
		if (!isset ($this->bassinLot)) {
			$this->bassinLot = $this->classInstanciate("BassinLot", "bassinLot.class.php");
		}
		$this->bassinLot->supprimerChamp($lot_id, "lot_id");
		parent::supprimer($lot_id);
	}
}