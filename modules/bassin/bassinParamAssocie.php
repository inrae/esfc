<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2014, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 4 mars 2014
 *  Code integre dans chaque page necessitant de recuperer les parametres associes a un bassin (selection, modification, etc.)
 */
include_once 'modules/classes/bassin.class.php';
$bassin_type = new Bassin_type($bdd, $ObjetBDDParam);
$vue->set( , "");("bassin_type", $bassin_type->getListe(2));
$bassin_usage = new Bassin_usage($bdd, $ObjetBDDParam);
$vue->set( , "");("bassin_usage", $bassin_usage->getListe(2));
$bassin_zone = new Bassin_zone($bdd, $ObjetBDDParam);
$vue->set( , "");("bassin_zone", $bassin_zone->getListe(2));
$circuit_eau = new CircuitEau($bdd, $ObjetBDDParam);
$vue->set( , "");("circuit_eau", $circuit_eau->getListe(2));

?>