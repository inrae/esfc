<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 7 avr. 2014
 */
include_once "modules/classes/document.class.php";
/**
 * Classe adaptée à l'application sturio, surchargeant la classe Document
 *
 * @author quinton
 *        
 */
class DocumentSturio extends DocumentAttach {
	public $resolution = 800;
	public $modules = array (
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
	function supprimer($id) {
		if ($id > 0 && is_numeric ( $id )) {
			/*
			 * Suppression dans les tables liées
			 */
			foreach ( $this->modules as $value ) {
				$sql = "delete from " . $value . "_document where document_id = " . $id;
				$this->executeSQL ( $sql );
			}
			return parent::supprimer ( $id );
		}
	}
	/**
	 * Retourne la liste des documents associes au type (evenement, poisson, bassin) et à la clé correspondante
	 *
	 * @param string $type        	
	 * @param int $id        	
	 * @return array
	 */
	function getListeDocument($type, $id, $limit = "all", $offset = 0) {
		/*
		 * Verification des valeurs numeriques
		 */
		$ok = true;
		if (is_array ( $id )) {
			foreach ( $id as $value ) {
				if (! is_numeric ( $value ))
					$ok = false;
			}
			if (count($id) == 0 )
				$ok = false;
		} else {
			if (! is_numeric ( $id ) || $id < 1 || strlen($id) == 0)
				$ok = false;
		}
		if (in_array ( $type, $this->modules ) && $ok == true) {
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
				if (is_array ( $id )) {
					$where = " where " . $type . "_id in (";
					$comma = "";
					foreach ( $id as $value ) {
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
			$limit = " limit ".$limit;
			$offset = " offset ".$offset;
			$commande = "select * from ($sql $where) as a  $order $limit $offset";
			$liste = $this->getListeParam ( $commande);
			/*
			 * Stockage des photos dans le dossier temporaire
			 */
			foreach ( $liste as $key => $value ) {
				// $filenames = $this->writeFileImage($value["document_id"], $this->resolution);
				$liste [$key] ["photo_name"] = $this->generateFileName ( $value ["document_id"], 0, $this->resolution );
				$liste [$key] ["photo_preview"] = $this->generateFileName ( $value ["document_id"], 1, $this->resolution );
				$liste [$key] ["thumbnail_name"] = $this->generateFileName ( $value ["document_id"], 2, $this->resolution );
			}
			return ($liste);
		}
	}
}
/**
 * ORM permettant de gérer toutes les tables de liaison avec la table Document
 *
 * @author quinton
 *        
 */
class DocumentLie extends ObjetBDD {
	public $tableOrigine;
	/**
	 * Constructeur de la classe
	 *
	 * @param Adodb_instance $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = null, $nomTable = "") {
		$this->param = $param;
		$this->paramori = $this->param;
		$this->tableOrigine = $nomTable;
		$this->table = $nomTable . "_document";
		$this->id_auto = 0;
		$this->colonnes = array (
				$nomTable . "_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1 
				),
				"document_id" => array (
						"type" => 1,
						"requis" => 1,
						"key" => 1 
				) 
		);
		if (! is_array ( $param ))
			$param = array();
		$param ["fullDescription"] = 1;
		parent::__construct ( $bdd, $param );
	}
	/**
	 * Reecriture de la fonction ecrire($data)
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function ecrire($data) {
		$nomChamp = $this->tableOrigine . "_id";
		if ($data ["document_id"] > 0 && $data [$nomChamp] > 0) {
			$sql = "insert into " . $this->table . "
 					(document_id, " . $nomChamp . ")
 					values 
 					(" . $data ["document_id"] . "," . $data [$nomChamp] . ")";
			$rs = $this->executeSQL ( $sql );
			
			if (count ( $rs ) > 0) {
				return 1;
			} else {
				return - 1;
			}
		}
	}
	/**
	 * Retourne la liste des documents associes
	 *
	 * @param int $id        	
	 * @return array
	 */
	function getListeDocument($id) {
		$documentSturio = new DocumentSturio ( $this->connection, $this->paramori );
		return $documentSturio->getListeDocument ( $this->tableOrigine, $id );
	}
}
?>