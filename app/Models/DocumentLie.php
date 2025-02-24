<?php

namespace App\Models;

use Ppci\Models\PpciModel;

/**
 * ORM permettant de gérer toutes les tables de liaison avec la table Document
 *
 * @author quinton
 *        
 */
class DocumentLie extends PpciModel
{
	public $tableOrigine;
	/**
	 * Constructeur de la classe
	 *
	 *         	
	 */
	function __construct($nomTable)
	{
		$this->tableOrigine = $nomTable;
		$this->table = $nomTable . "_document";
		$this->useAutoIncrement = false;
		$this->fields = array(
			$nomTable . "_id" => array(
				"type" => 1,
				"requis" => 1,
				"key" => 1
			),
			"document_id" => array(
				"type" => 1,
				"requis" => 1,
				"key" => 1
			)
		);
		parent::__construct();
	}
	/**
	 * Reecriture de la fonction ecrire($data)
	 * (non-PHPdoc)
	 *
	 * @see ObjetBDD::ecrire()
	 */
	function write($data): int
	{
		$nomChamp = $this->tableOrigine . "_id";
		if ($data["document_id"] > 0 && $data[$nomChamp] > 0) {
			$sql = "insert into " . $this->table . "
 					(document_id, " . $nomChamp . ")
 					values 
 					(:document_id:,:fieldname:)";
			$this->executeSQL(
				$sql,
				[
					"document_id" => $data["document_id"],
					"fieldname" => $data[$nomChamp]
				],
				true
			);
		}
		return 1;
	}
	/**
	 * Retourne la liste des documents associes
	 *
	 * @param int $id        	
	 * @return array
	 */
	function getListeDocument(int $id)
	{
		$documentSturio = new DocumentSturio;
		return $documentSturio->getListeDocument($this->tableOrigine, $id);
	}
}
