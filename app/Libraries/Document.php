<?php

namespace App\Libraries;

use App\Models\DocumentLie;
use App\Models\DocumentSturio;
use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Document extends PpciLibrary
{
	/**
	 * @var 
	 */
	protected PpciModel $dataclass;
	public $keyName;
	public $vars = array("moduleParent", "parentType", "parentIdName", "parent_id", "document_limit", "document_offset");

	function __construct()
	{
		parent::__construct();
		/**
		 * @var DocumentSturio
		 */
		$this->dataclass = new DocumentSturio;
		$this->keyName = "document_id";
		if (isset($_REQUEST[$this->keyName])) {
			$this->id = $_REQUEST[$this->keyName];
		}
		helper("esfc");
	}
	function change()
	{
		$this->vue = service('Smarty');
		$this->dataRead($this->id, "document/documentChange.tpl");
		foreach ($this->vars as $var) {
			$this->vue->set($_REQUEST[$var], $var);
		}
		return $this->vue->send();
	}
	function changeData()
	{
		$this->vue = service('Smarty');
		$this->dataRead($this->id, "document/documentChangeData.tpl");
		foreach ($this->vars as $var) {
			$this->vue->set($_REQUEST[$var], $var);
		}
		$this->vue->set($_REQUEST["parent_id"], $_REQUEST["parentIdName"]);
		return $this->vue->send();
	}
	function writeData()
	{
		/**
		 * Retour au module initial
		 */
		$this->dataclass->writeData($_REQUEST);
		$_REQUEST[$_REQUEST["parentIdName"]] = $_REQUEST["parent_id"];
		return true;
	}
	function write()
	{
		/**
		 * write record in database
		 */
		if (!empty($_REQUEST["parentType"])) {
			/**
			 * Preparation de files
			 */
			try {
				$files = formatFiles();
				foreach ($files as $file) {
					$this->id = $this->dataclass->write($file, $_REQUEST["document_description"], $_REQUEST["document_date_creation"]);
					if ($this->id > 0) {
						$_REQUEST[$this->keyName] = $this->id;
						/**
						 * Ecriture de l'enregistrement en table liee
						 */
						$documentLie = new DocumentLie( $_REQUEST["parentType"]);
						$data = array(
							"document_id" => $this->id,
							$_REQUEST["parentIdName"] => $_REQUEST["parent_id"]
						);
						$documentLie->write($data);
					}
				}
			} catch (PpciException $e) {
				$this->message->set($e->getMessage(), true);
			}
			$this->log->setLog($_SESSION["login"], get_class($this->dataclass) . "-write", $this->id);
		}
		/**
		 * Retour au module initial
		 */
		$_REQUEST[$_REQUEST["parentIdName"]] = $_REQUEST["parent_id"];
	}
	function delete()
	{
		/**
		 * delete record
		 */
		$_REQUEST[$_REQUEST["parentIdName"]] = $_REQUEST["parent_id"];
		try {
			$this->dataDelete($this->id);
			return true;
		} catch (PpciException $e) {
			return false;
		}
	}
	function get()
	{
		/**
		 * Envoie vers le navigateur le document
		 */
		$_REQUEST["attached"] = 1 ? $attached = true : $attached = false;
		$this->dataclass->documentSent($this->id, $_REQUEST["phototype"], $attached);
	}
}
