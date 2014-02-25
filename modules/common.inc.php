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
?>