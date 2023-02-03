<?php
/**
 * ORM de gestion de la table mime_type
 *
 * @author quinton
 *        
 */
class Mime_type extends ObjetBDD
{

    /**
     * Constructeur de la classe
     *
     * @param
     *            instance ADODB $bdd
     * @param array $param
     */
    function __construct($bdd, $param = array())
    {
        $this->table = "mime_type";
        $this->colonnes = array(
            "mime_type_id" => array(
                "type" => 1,
                "key" => 1,
                "requis" => 1,
                "defaultValue" => 0
            ),
            "content_type" => array(
                "type" => 0,
                "requis" => 1
            ),
            "extension" => array(
                "type" => 0,
                "requis" => 1
            )
        );
        parent::__construct($bdd, $param);
    }

    /**
     * retourne la liste des types mimes triés par extension
     * (non-PHPdoc)
     *
     * @see ObjetBDD::getListe()
     */
    function getListe($order = "")
    {
        $sql = "select * from mime_type order by extension";
        return ($this->getListeParam($sql));
    }
}
