<?php
/**
 * Code execute systematiquement a chaque appel, apres demarrage de la session
 * Utilise notamment pour recuperer les instances de classes stockees en 
 * variables de session
 */
/*
 * Declaration de la classe de recherche des poissons
 */
if (! isset ( $_SESSION ["searchPoisson"] )) {
	$searchPoisson = new SearchPoisson ();
	$_SESSION ["searchPoisson"] = $searchPoisson;
} else {
	$searchPoisson = $_SESSION ["searchPoisson"];
}
/*
 * Declaration de la classe de recherche des bassins
*/
if (! isset ( $_SESSION ["searchBassin"] )) {
	$searchBassin = new SearchBassin();
	$_SESSION ["searchBassin"] = $searchBassin;
} else {
	$searchBassin = $_SESSION ["searchBassin"];
}
/*
 * Declaration de la classe de recherche des circuits d'eau
 */
if (! isset ( $_SESSION ["searchCircuitEau"] )) {
	$searchCircuitEau = new SearchCircuitEau();
	$_SESSION ["searchCircuitEau"] = $searchCircuitEau;
} else {
	$searchCircuitEau = $_SESSION ["searchCircuitEau"];
}
?>