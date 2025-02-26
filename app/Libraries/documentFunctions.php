<?php 
namespace App\Libraries;

use Ppci\Libraries\PpciException;
use Ppci\Libraries\PpciLibrary;
use Ppci\Models\PpciModel;

class Xx extends PpciLibrary { 
    /**
     * @var xx
     */
    protected PpciModel $this->dataclass;
    private $keyName;

    function __construct()
    {
        parent::__construct();
        $this->dataclass = new ;
        $keyName = "_id";
        if (isset($_REQUEST[$this->keyName])) {
            $this->id = $_REQUEST[$this->keyName];
        }
    }


/**
 * Fonction permettant de preparer les documents a afficher, en limitant le nombre envoye au navigateur
 * @param string $type : type de document recherche
 * @param array|int $this->id : cle du parent
 * @param string|int $limit : nombre d'enregistrements a afficher
 * @param number $offset : numero du premier enregistrement a afficher
 * @return array
 */
function getListeDocument($type, array|int $this->id, $limit = "", $offset = 0)
{
	global $this->vue, $bdd, $ObjetBDDParam;
	require_once 'modules/classes/documentSturio.class.php';
	$document = new DocumentSturio;
	if (!$limit == "all" && !$limit > 0) {
		$limit = 10;
	}
	if (!$offset || !is_numeric($offset) || $offset < 1) {
		$offset = 0;
	}

	/*
	 * Envoi au navigateur des valeurs de limit et offset
	 */
	$this->vue->set($limit, "document_limit");
	$this->vue->set($offset, "document_offset");
	return $document->getListeDocument($type, $this->id, $limit, $offset);
}
