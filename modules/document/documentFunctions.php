<?php


/**
 * Fonction permettant de preparer les documents a afficher, en limitant le nombre envoye au navigateur
 * @param string $type : type de document recherche
 * @param int $id : cle du parent
 * @param string|int $limit : nombre d'enregistrements a afficher
 * @param number $offset : numero du premier enregistrement a afficher
 * @return array
 */
function getListeDocument($type, int $id, $limit = "", $offset = 0)
{
	global $vue, $bdd, $ObjetBDDParam;
	require_once 'modules/classes/documentSturio.class.php';
	$document = new DocumentSturio($bdd, $ObjetBDDParam);
	if (!$limit == "all" && !$limit > 0) {
		$limit = 10;
	}
	if (!$offset || !is_numeric($offset) || $offset < 1) {
		$offset = 0;
	}

	/*
	 * Envoi au navigateur des valeurs de limit et offset
	 */
	$vue->set($limit, "document_limit");
	$vue->set($offset, "document_offset");
	return $document->getListeDocument($type, $id, $limit, $offset);
}
