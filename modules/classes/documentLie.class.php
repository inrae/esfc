<?php
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
	 * @param PDO $bdd        	
	 * @param array $param        	
	 */
	function __construct($bdd, $param = array(), $nomTable = "") {
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
	function getListeDocument(int $id) {
		$documentSturio = new DocumentSturio ( $this->connection, $this->paramori );
		return $documentSturio->getListeDocument ( $this->tableOrigine, $id );
	}
}