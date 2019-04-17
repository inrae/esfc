<?php
/**
 * @author : quinton
 * @date : 16 mars 2016
 * @encoding : UTF-8
 * (c) 2016 - All rights reserved
 */
/**
 * Fonction permettant de reorganiser les donnees des fichiers telecharges,
 * pour une utilisation directe en tableau
 * @return multitype:multitype:NULL  unknown
 */
function formatFiles($attributName = "documentName") {
	global $_FILES;
	$files=array();
	$fdata=$_FILES[$attributName];
	if(is_array($fdata['name'])){
		for($i=0;$i<count($fdata['name']);++$i){
			$files[]=array(
					'name'    =>$fdata['name'][$i],
					'type'  => $fdata['type'][$i],
					'tmp_name'=>$fdata['tmp_name'][$i],
					'error' => $fdata['error'][$i],
					'size'  => $fdata['size'][$i]
			);
		}
	}else $files[]=$fdata;
	return $files;
}
/**
 * Fonction permettant de preparer les documents a afficher, en limitant le nombre envoye au navigateur
 * @param string $type : type de document recherche
 * @param int $id : cle du parent
 * @param string|int $limit : nombre d'enregistrements a afficher
 * @param number $offset : numero du premier enregistrement a afficher
 * @return array
 */
function getListeDocument($type, $id, $limit="", $offset=0) {
	global $smarty, $bdd, $ObjetBDDParam;
	require_once 'modules/classes/documentSturio.class.php';
	$document = new DocumentSturio($bdd, $ObjetBDDParam);
	if (!$limit == "all" && !$limit > 0)
		$limit = 10;
	if ($offset < 1)
		$offset = 0; 
	$data = $document->getListeDocument($type, $id, $limit, $offset);
	/*
	 * Envoi au navigateur des valeurs de limit et offset
	 */
	$smarty->assign("document_limit", $limit);
	$smarty->assign("document_offset", $offset);
	return $data;
}
?>