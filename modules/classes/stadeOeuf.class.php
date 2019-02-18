<?php
/**
 * Created : 3 févr. 2017
 * Creator : quinton
 * Encoding : UTF-8
 * Copyright 2017 - All rights reserved
 */
class StadeOeuf extends ObjetBDD {
	function __construct($bdd, $param = null) {
		$this->param = $param;
		$this->paramori = $param;
		$this->table = "stade_oeuf";
		$this->id_auto = "1";
		$this->colonnes = array (
				"stade_oeuf_id" => array (
						"type" => 1,
						"key" => 1,
						"requis" => 1,
						"defaultValue" => 0
				),
				"stade_oeuf_libelle" => array (
						"type" => 0,
						"requis" => 1
				)
		);
		if (! is_array ( $param ))
			$param = array();
			$param ["fullDescription"] = 1;
			parent::__construct ( $bdd, $param );
	}
}
?>