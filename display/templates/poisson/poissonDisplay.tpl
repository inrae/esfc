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

<h2>{t}Détail d'un poisson{/t}</h2>
<a href="index.php?module={$poissonDetailParent}">Retour à la liste des poissons</a>
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
<legend>{t}Événements associés{/t}</legend>
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
<legend>{t}Pathologies{/t}</legend>
<div class="masquage">
{include file="poisson/pathologieList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>{t}Transferts effectués{/t}</legend>
<div class="masquage">
{include file="poisson/transfertList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>{t}Campagnes de reproduction{/t}</legend>
<div class="masquage">
{if $droits.reproGestion == 1} 
<a href="index.php?module=poissonCampagneChange&poisson_id={$dataPoisson.poisson_id}&poisson_campagne_id=0">
Pré-sélectionner le poisson pour une campagne de reproduction
</a>
{/if}
{include file="poisson/poissonCampagneList.tpl"}
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>{t}Dosages sanguins{/t}</legend>
<div class="masquage">
{include file="poisson/dosageSanguinList.tpl"}
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>{t}Prélèvements génétiques{/t}</legend>
<div class="masquage">
{include file="poisson/genetiqueList.tpl"}
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>{t}Sortie du stock{/t}</legend>
<div class="masquage">
{include file="poisson/sortieList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>{t}Mortalité{/t}</legend>
<div class="masquage">
{include file="poisson/mortaliteList.tpl"}
<br>
</div>
</fieldset>
</td>
<td>

<fieldset class="fsMasquable">
<legend>{t}Documents associés{/t}</legend>
<div class="masquage">
{include file="document/documentList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>{t}Données morphologiques{/t}</legend>
<div class="masquage">
{include file="poisson/morphologieList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>{t}Échographies{/t}</legend>
<div class="masquage">
{include file="poisson/echographieList.tpl"}
<br></div>
</fieldset>
<fieldset class="fsMasquable">
<legend>{t}Anesthésies{/t}</legend>
<div class="masquage">
{include file="poisson/anesthesieList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>{t}Ventilation{/t}</legend>
<div class="masquage">
{include file="poisson/ventilationList.tpl"}
<br>
</div>
</fieldset>

<fieldset class="fsMasquable">
<legend>{t}Détermination du sexe{/t}</legend>
<div class="masquage">
{include file="poisson/genderSelectionList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>{t}Liste des (pit)tags attribués{/t}</legend>
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
<legend>{t}Liste des parents{/t}</legend>
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
<legend>{t}Détermination de la parenté{/t}</legend>
<div class="masquage">
{include file="poisson/parenteList.tpl"}
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>{t}Détermination de la cohorte{/t}</legend>
<div class="masquage">
{include file="poisson/cohorteList.tpl"}
<br>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>{t}Anomalies relevées dans les données{/t}</legend>
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
