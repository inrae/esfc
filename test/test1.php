<?php
/**
 * @author Eric Quinton
 * @copyright Copyright (c) 2015, IRSTEA / Eric Quinton
 * @license http://www.cecill.info/licences/Licence_CeCILL-C_V1-fr.html LICENCE DE LOGICIEL LIBRE CeCILL-C
 *  Creation 2 avr. 2015
 */
 $a = array (1, "a", "'", "%");
foreach ( $a as $value) {
	echo $value;
	if ($value > 0) {
		echo " ok";
	} else 
		echo " ko";
	echo "<br>";
}

?>