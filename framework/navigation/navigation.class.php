<?php
/** Fichier cree le 10 juil. 08 par quinton
 *
 *UTF-8
 */

/**
 * @class Navigation
 * @author Eric Quinton - eric.quinton@free.fr
 *
 */
class Navigation {
	var $doc;
	var $module;
	var $nommodule = "";
	var $t_module = array();
	var $g_module = array();


	/**
	 * Fonction de creation de la classe
	 * lecture du fichier xml contenant la navigation de l'application
	 *
	 * @param string $nomfichier
	 * @return Navigation
	 */
	function Navigation($nomfichier) {
		$this->dom = new DOMDocument();
		$this->dom->load($nomfichier);
		$this->g_module = $this->lireGlobal();
	}
	/**
	 * Retourne un tableau contenant tous les attributs du module
	 *
	 * @param string $module
	 * @return array
	 */
	function getModule($module) {
		// $this->lireModule($module);
		return $this->g_module[$module];
	}
	/**
	 * deprecared
	 * Fonction lisant les attributs du module, et les restituant
	 * dans le tableau t_module
	 * Operation effectuee que si le module n'a pas encore ete charge
	 *
	 * @param string $nommodule
	 */
	function lireModule($nommodule) {
		if ($this->nommodule<>$nommodule) {
			$this->module = $this->dom->getElementsByTagName($nommodule);
			$this->t_module = array();
			foreach ($this->module as $noeud){
				if ($noeud->hasAttributes()) {
					foreach ($noeud->attributes as $attname=>$noeud_attribute) {
						$this->t_module[$attname] = $noeud->getAttribute($attname);
					}
				}
			}
			$this->nommodule = $nommodule;
		}
	}
	/**
	 * Fonction retournant la valeur d'un attribut pour le module considere
	 *
	 * @param string $nommodule
	 * @param string $attribut
	 * @return string
	 */

	function getAttribut($nommodule, $attribut){
		return $this->g_module[$nommodule][$attribut];
	}

	/**
	 * Fonction lisant l'arborescence sur 2 niveaux du fichier xml
	 * Lecture depuis la racine du fichier xml, des noeuds de niveau 1
	 * et des attributs associes
	 *
	 * @param string $racine
	 * @return array
	 */
	function lireGlobal() {
		$root = $this->dom->getElementsByTagName($this->dom->documentElement->tagName);
		$root = $root->item(0);
		$noeuds = $root->childNodes;
		$g_module = array();
		foreach ($noeuds as $noeud){
			// Exclusion du modele
			
			if ($noeud->hasAttributes()&&$noeud->tagName<>"model") {
				foreach ($noeud->attributes as $attname=>$noeud_attribute) {
					$g_module[$noeud->tagName][$attname] = $noeud->getAttribute($attname);
				}
			}
		}
		return $g_module;
	}
/**
 * Fonction preparant un tableau multi-niveaux, contenant tous les items 
 * necessaires pour generer un menu a partir du fichier xml.
 * Gere 2 niveaux de menu
 * Le tableau recupere doit ensuite etre trie (via ksort), et les droits
 * verifies (menuloginrequis et menudroits)
 *
 * @return array
 */
	function genererMenu() {
		$gmenu = array();
		foreach ($this->g_module as $key => $value ) {
			if (isset($value["menulevel"])) {
				/* 
				 * Recuperation des informations sur le menu
				 */
				$menu = array();
				$menu["menuvalue"] = $value["menuvalue"];
				$menu["module"] = $key;
				if (isset($value["menudroits"]))
				$menu["menudroits"] = $value["menudroits"];
				if (isset($value["menuloginrequis"]))
				$menu["menuloginrequis"] = $value["menuloginrequis"];
				$menu["menutitle"] = $value["menutitle"];
				if (isset ($value["onlynoconnect"]))
				$menu["onlynoconnect"] =$value["onlynoconnect"];
				/* 
				 * Recherche si on est en menu principal ou secondaire
				 */
				if ($value["menulevel"]==0) {
					foreach ($menu as $key1 => $value1) {
						$gmenu[$value["menuorder"]][$key1]=$value1;
					}
				} else {
					$gmenu[$value["menuparent"]][$value["menuorder"]]=$menu;
				}
			}
		}
		return $gmenu;
	}
}

?>