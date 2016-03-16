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
function formatFiles() {
	global $_FILES;
	$files=array();
	$fdata=$_FILES['documentName'];
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
?>