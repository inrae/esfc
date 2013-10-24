<?php
include_once 'gestion/ressource.class.php';
include_once 'modules/administration/gestionParam.class.php';
$ressource = new Ressource($bdd,$ObjetBDDParam);
$smarty->assign("ressource", $ressource->lire($_REQUEST['Ressource_IdRessource']));
$dataClass = new FonctionMetier($bdd,$ObjetBDDParam);
$typeFonctionMetier = new TypeFonctionMetier($bdd,$ObjetBDDParam);
$smarty->assign("typeFonctionMetier",$typeFonctionMetier->getListe());
$corps = "modules/gestion/fonctionMetierModif.tpl";
unset($id);
if (isset($_REQUEST["idFonctionMetier"])) $id=$_REQUEST["idFonctionMetier"];
/*
 * Gestion des valeurs par defaut
 */
if ($id==0) {
	$listeDefaut=array();
	$listeDefaut["dateDebut"]=date("d/m/Y");
	$listeDefaut["dateFin"]="31/12/2050";
	$listeDefaut["Ressource_IdRessource"]=$_REQUEST["Ressource_IdRessource"];
}

include('modules/ecrireFiche.php');

?>