<?php

/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 avr. 2014
 */

/**
 * Classe adaptée à l'application sturio, surchargeant la classe Document
 *
 * @author quinton
 *        
 */
require_once "modules/classes/documentAttach.class.php";

class DocumentSturio extends DocumentAttach
{
	public $resolution = 800;
	public $modules = array(
		"poisson",
		"evenement",
		"bassin",
		"biopsie"
	);
	/**
	 * Surcharge de la fonction supprimer pour effacer les enregistrements liés
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::supprimer()
	 */
	function supprimer($id)
	{
		/**
		 * Suppression dans les tables liées
		 */
		$param = array("id" => $id);
		$sql = "delete from :tablename where document_id = :id";
		foreach ($this->modules as $value) {
			$tablename = $value . "_document";
			$sql = "delete from $tablename where document_id = :id";
			$this->executeAsPrepared($sql, $param);
		}
		//return parent::supprimer($id);
	}
	/**
	 * Retourne la liste des documents associes au type (evenement, poisson, bassin) et à la clé correspondante
	 *
	 * @param string $type        	
	 * @param int $id        	
	 * @return array
	 */
	function getListeDocument($type, $id, $limit = "all", $offset = 0)
	{
		/*
		 * Verification des valeurs numeriques
		 */
		$ok = true;
		if (is_array($id)) {
			foreach ($id as $value) {
				if (!is_numeric($value))
					$ok = false;
			}
			if (count($id) == 0)
				$ok = false;
		} else {
			if (!is_numeric($id) || $id < 1 || strlen($id) == 0)
				$ok = false;
		}
		if (in_array($type, $this->modules) && $ok == true) {
			$order = " order by case 
						when document_date_creation  is null then '1970-01-01'
						else document_date_creation
						end desc, document_date_import desc";
			if ($type == "poisson") {
				$sql = "select document_id, document_date_import, document_nom,
 						document_description, size, mime_type_id,
 						document_date_creation
 						from document
 						join poisson_document using (document_id)
 						where poisson_id = " . $id . "
 						union
 						select document_id, document_date_import, document_nom,
 						document_description, size, mime_type_id,
 						document_date_creation
 						from document
 						join evenement_document using (document_id)
 						join evenement using (evenement_id)
 						join poisson using (poisson_id)";
				$where = " where poisson_id = " . $id;
			} else {
				$sql = "select " . $type . "_id, document_id, document_date_import,
					document_nom, document_description, size, mime_type_id,
 					document_date_creation
					from document
					join " . $type . "_document using (document_id)";
				if (is_array($id)) {
					$where = " where " . $type . "_id in (";
					$comma = "";
					foreach ($id as $value) {
						$where .= $comma . $value;
						$comma = ",";
					}
					$where .= ")";
				} else {
					$where = " where " . $type . "_id = " . $id;
				}
			}
			if (!is_numeric($limit))
				$limit = "all";
			if (!is_numeric($offset))
				$offset = 0;
			$limit = " limit " . $limit;
			$offset = " offset " . $offset;
			$commande = "select * from ($sql $where) as a  $order $limit $offset";
			$liste = $this->getListeParam($commande);
			/*
			 * Stockage des photos dans le dossier temporaire
			 */
			foreach ($liste as $key => $value) {
				$liste[$key]["photo_name"] = $this->generateFileName($value["document_id"], 0, $this->resolution);
				$liste[$key]["photo_preview"] = $this->generateFileName($value["document_id"], 1, $this->resolution);
				$liste[$key]["thumbnail_name"] = $this->generateFileName($value["document_id"], 2, $this->resolution);
			}
			return $liste;
		} else {
			return array();
		}
	}
}
