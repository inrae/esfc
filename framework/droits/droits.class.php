<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 3 juin 2015
 */
 
class Aclappli extends ObjetBDD {
	
	function __construct($bdd, $param) {
		$this->param = $param;
		$this->table="aclappli";
		$this->id_auto="1";
		$this->colonnes=array(
				"aclappli_id"=>array("type"=>1,"key"=>1, "requis"=>1, "defaultValue"=>0),
				"appli"=>array("requis"=>0),
				"applidetail"=>array("type"=>0)
		);
		if(!is_array($param)) $param==array();
		$param["fullDescription"]=1;
		parent::__construct($bdd,$param);
	}
}

class Aclaco extends ObjetBDD {
	function __construct($bdd, $param) {
		$this->param = $param;
		$this->table="aclaco";
		$this->id_auto="1";
		$this->colonnes=array(
				"aclaco_id"=>array("type"=>1,"key"=>1, "requis"=>1, "defaultValue"=>0),
				"aclappli_id"=>array("type"=>1, "requis"=>1, "parentAttrib"=>1),
				"aco"=>array("requis"=>0)
		);
		if(!is_array($param)) $param==array();
		$param["fullDescription"]=1;
		parent::__construct($bdd,$param);
	}
}

class Acllogin extends ObjetBDD {
	function __construct($bdd, $param) {
		$this->param = $param;
		$this->table="acllogin";
		$this->id_auto="1";
		$this->colonnes=array(
				"acllogin_id"=>array("type"=>1,"key"=>1, "requis"=>1, "defaultValue"=>0),
				"login"=>array("requis"=>1),
				"logindetail"=>array("type"=>0, "requis"=>1)
		);
		if(!is_array($param)) $param==array();
		$param["fullDescription"]=1;
		parent::__construct($bdd,$param);
	}
	
	/*
	 * WITH RECURSIVE hierarchie(id_employe, nom_employe, id_superieur) AS (
  SELECT id_employe, nom_employe, id_superieur
    FROM employes WHERE id_employe = 3
  UNION ALL
  SELECT e.id_employe, e.nom_employe, e.id_superieur
    FROM hierarchie AS h,employes AS e 
    WHERE h.id_superieur = e.id_employe
)
SELECT * FROM hierarchie;
	 */
}

class Aclgroup extends ObjetBDD {
	function __construct($bdd, $param) {
		$this->param = $param;
		$this->table="aclgroup";
		$this->id_auto="1";
		$this->colonnes=array(
				"aclgroup_id"=>array("type"=>1,"key"=>1, "requis"=>1, "defaultValue"=>0),
				"group"=>array("requis"=>1),
				"aclgroup_id_parent"=>array("type"=>1)
		);
		if(!is_array($param)) $param==array();
		$param["fullDescription"]=1;
		parent::__construct($bdd,$param);
	}
	
	function getGroups () {
		$sql = "with recursive aclgroupparent(aclgroup_id, group) as (
				select aclgroup_id, group, aclgroup_id_parent
				from aclgroup
				order by group
				union all
				select g.aclgroup_id, g.group, g.aclgroup_id_parent
				from aclgroupparent p, aclgroup g
				where p.aclgroup_id_parent = g.aclgroup_id
				)
				select * from aclgropuparent";
		return $this->getListeParam($sql);
	}
}
?>