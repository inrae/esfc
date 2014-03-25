<script>
$(document).ready(function() { 
	/*
	* Gestion de l'affichage
	*/
	var afficher = $.cookie("poissonDisplayAfficher");
	if (isNaN(afficher)) afficher = 1;
	if (afficher == 1) {
		$("#afficher").text("Masquer tous les éléments");
	} else {
		$("#afficher").text("Afficher tous les éléments");
		$ ("fieldset > .masquage").hide("");
	}
	$ (".fsMasquable legend").click(function() {
		if ($(this).nextAll(".masquage") .is (":visible") == true ) {
			$(this).nextAll(".masquage").hide("10");
		} else {
			$(this).nextAll(".masquage").show ("10");
		}
	} );
	$("#afficher").click(function() {
		if (afficher == 0) {
			$( this ).text("Masquer tous les éléments") ;
			afficher = 1 ;
			$ ("fieldset > .masquage").show("");
		} else {
			$ (this ).text ("Afficher tous les éléments") ;
			afficher = 0;
			$ ("fieldset > .masquage").hide("");
		}
		$.cookie("poissonDisplayAfficher", afficher);
	} );
} );

</script>

<h2>Détail d'un poisson</h2>
<a href="index.php?module=poissonList">Retour à la liste des poissons</a>
<table class="tablemulticolonne">
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=poissonChange&poisson_id={$dataPoisson.poisson_id}">
Modifier les informations...
</a>
{/if}
{include file="poisson/poissonDetail.tpl"}
<div id="afficher" class="masquageText">Afficher tous les éléments</div>
<fieldset class="fsMasquable">
<legend>Événements associés</legend>
<div class="masquage">
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataPoisson.poisson_id}&evenement_id=0">
Nouvel événement...
</a>
{/if}
{include file="poisson/evenementList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>Pathologies</legend>
<div class="masquage">
{include file="poisson/pathologieList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>Mortalité</legend>
<div class="masquage">
{include file="poisson/mortaliteList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>Transferts effectués</legend>
<div class="masquage">
{include file="poisson/transfertList.tpl"}
<br>
</div>
</fieldset>
</td>
<td>
<fieldset class="fsMasquable">
<legend>Liste des (pit)tags attribués</legend>
<div class="masquage">
{if $droits["poissonGestion"]==1}
<a href="index.php?module=pittagChange&poisson_id={$dataPoisson.poisson_id}&pittag_id=0">
Nouveau pittag ou étiquette...
</a>
{/if}
{include file="poisson/pittagList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>Liste des parents</legend>
<div class="masquage">
{if $droits["poissonGestion"]==1}
<a href="index.php?module=parentPoissonChange&poisson_id={$dataPoisson.poisson_id}&parent_poisson_id=0">
Nouveau parent...
</a>
{/if}
{include file="poisson/parentPoissonList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>Données morphologiques</legend>
<div class="masquage">
{include file="poisson/morphologieList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>Détermination du sexe</legend>
<div class="masquage">
{include file="poisson/genderSelectionList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>Détermination de la cohorte</legend>
<div class="masquage">
{include file="poisson/cohorteList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>Anomalies relevées dans les données</legend>
<div class="masquage">
{if $droits["poissonGestion"] == 1}
<a href="index.php?module=anomalieChange&poisson_id={$dataPoisson.poisson_id}&anomalie_db_id=0&module_origine=poissonDisplay">
Créer une anomalie manuellement
</a>
{/if}
{include file="poisson/anomalieDbList.tpl"}
<br>
</div>
</fieldset>
</td>

<td>

</td>

</tr>
</table>
