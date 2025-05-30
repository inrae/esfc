<?php

namespace App\Models;

use Ppci\Models\PpciModel;

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
		foreach ($this->modules as $value) {
			$tablename = $value . "_document";
			$sql = "delete from $tablename where document_id = :id:";
			$this->executeQuery($sql, $param, true);
		}
		return parent::supprimer($id);
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
		$data = [];
		if (in_array($type, $this->modules) && $ok == true) {
			$order = " order by case 
						when document_date_creation  is null then '1970-01-01'
						else document_date_creation
						end desc, document_date_import desc";
			if ($type == "poisson") {
				$sql = "SELECT document_id, document_date_import, document_nom,
 						document_description, size, mime_type_id,
 						document_date_creation
 						from document
 						join poisson_document using (document_id)
 						where poisson_id = :id:
 						union
 						SELECT document_id, document_date_import, document_nom,
 						document_description, size, mime_type_id,
 						document_date_creation
 						from document
 						join evenement_document using (document_id)
 						join evenement using (evenement_id)
 						join poisson using (poisson_id)";
				$data["id"] = $id;
				$data["id1"] = $id;
				$where = " where poisson_id = :id1:";
			} else {
				$sql = "SELECT " . $type . "_id, document_id, document_date_import,
					document_nom, document_description, size, mime_type_id,
 					document_date_creation
					from document
					join " . $type . "_document using (document_id)";
				if (is_array($id)) {
					$where = " where " . $type . "_id in (";
					$comma = "";
					$i = 0;
					foreach ($id as $value) {
						$where .= $comma . ":id$i:";
						$data["id$i"] = $value;
						$i++;
						$comma = ",";
					}
					$where .= ")";
				} else {
					$where = " where " . $type . "_id = :id:";
					$data["id"] = $id;
				}
			}
			if (!is_numeric($limit))
				$limit = "all";
			if (!is_numeric($offset))
				$offset = 0;
			$limit = " limit " . $limit;
			$offset = " offset " . $offset;
			$commande = "SELECT * from ($sql $where) as a  $order $limit $offset";
			$liste = $this->getListeParam($commande, $data);
			/*
			 * Stockage des photos dans le dossier temporaire
			 */
			/*foreach ($liste as $key => $value) {
				$liste[$key]["photo_name"] = $this->generateFileName($value["document_id"], 0, $this->resolution);
				$liste[$key]["photo_preview"] = $this->generateFileName($value["document_id"], 1, $this->resolution);
				$liste[$key]["thumbnail_name"] = $this->generateFileName($value["document_id"], 2, $this->resolution);
			}*/
			return $liste;
		} else {
			return array();
		}
	}
}
