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
  * @author quinton
  *
  */
 class DocumentSturio extends DocumentAttach {
 	/**
 	 * Surcharge de la fonction supprimer pour effacer les enregistrements liés
 	 * (non-PHPdoc)
 	 *
 	 * @see ObjetBDD::supprimer()
 	 */
 	function supprimer($id) {
 		if ($id > 0) {
 			/*
 			 * Suppression dans les tables liées
 			*/
 			$table = array (
 					"poisson_document",
 					"evenement_document",
 					"bassin_document"
 			);
 			foreach ( $table as $key => $value ) {
 				$sql = "delete from " . $value . " where document_id = " . $id;
 				$this->executeSQL ( $sql );
 			}
 			return parent::supprimer ( $id );
 		}
 	}
 	/**
 	 * Retourne la liste des documents associes au type (evenement, poisson, bassin) et à la clé correspondante
 	 * @param string $type
 	 * @param int $id
 	 * @return array
 	 */
 	function getListeDocument($type, $id) {
 		if (($type == "evenement" || $type = "poisson" || $type = "bassin") && $id > 0) {
 			$sql = "select " . $type . "_id, document_id, document_date_import,
					document_nom, document_description, size / 1024,
					thumbnail
					from document
					join " . $type . "_document using (document_id)
					where " . $type . "_id = " . $id . "
					order by document_date_import desc";
 			$liste = $this->getListeParam ( $sql );
 			/*
 			 * Preparation des vignettes
 			*/
 			foreach ( $liste as $key => $value ) {
 				if ($value ["mime_type_id"] == 1 || $value ["mime_type_id"] == 4 || $value ["mime_type_id"] == 5 || $value ["mime_type_id"] == 6) {
 					$liste[$key]["photo_name"] = $this->writeFileImage($id, $value["thumbnail"]);
 					/*
 					 * Suppression de la vignette avant envoi au navigateur (pas besoin...)
 					 */
 					unset ($liste[$key]["thumbnail"]);
 				}
 			}
 			return ($liste);
 		}
 	}
 }
 /**
  * ORM permettant de gérer toutes les tables de liaison avec la table Document
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
 	function __construct($bdd, $param = null, $nomTable="") {
 		$this->param = $param;
 		$this->paramori = $this->param;
 		$this->tableOrigine = $nomTable;
 		$this->table = $nomTable."_document";
 		$this->id_auto = 0;
 		$this->colonnes = array (
 				$nomTable."_id" => array (
 						"type" => 1,
 						"key" => 1,
 						"requis" => 1
 				),
 				"document_id" => array (
 						"type" => 1,
 						"requis" => 1
 				)
 		);
 		if (! is_array ( $param ))
 			$param == array ();
 		$param ["fullDescription"] = 1;
 		parent::__construct ( $bdd, $param );
 	}
 	/**
 	 * Retourne la liste des documents associes
 	 * @param int $id
 	 * @return array
 	 */
 	function getListeDocument ($id) {
 		$documentSturio = new DocumentSturio($this->connection, $this->paramori);
 		return $documentSturio->getListeDocument($this->tableOrigine, $id);
 	}	
 }
?>