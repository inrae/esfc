<script>
$(document).ready(function() { 
	var afficher = 1;
	$("#afficher").text("Masquer tous les éléments");
	//$ ("h3").next(".masquage").hide();
	var styles = {
		      "cursor": "pointer",
		      "fontStyle": "italic",
		      "text-decoration": "underline"
		    } ;
	$ ("#afficher").css( styles );
	$ ("h3").css(styles);
	$( "h3" ).click(function() {
		//$( this ).next( ".masquage" ).toggle("slow") ;
		if ($( this ).next( ".masquage" ).is(":visible") == true ) {
			$( this ).next( ".masquage" ).hide("slow");
		} else {
			$( this ).next( ".masquage" ).show("slow")
		}
	} );
	$("#afficher").click(function() {
		/*$ ("h3").next(".masquage").toggle();*/
		if (afficher == 0) {
			$( this ).text("Masquer tous les éléments") ;
			afficher = 1 ;
			$ ("h3").next(".masquage").show("slow");
		} else {
			$ (this ).text ("Afficher tous les éléments") ;
			afficher = 0;
			$ ("h3").next(".masquage").hide("slow");
		}
	} );
} );

</script>

<h2>Détail d'un poisson</h2>
<a href="index.php?module=poissonList">Retour à la liste des poissons</a>
<table class="tablemulticolonne">
<tr>
<td colspan="2">
{if $droits["poissonGestion"]==1}
<a href="index.php?module=poissonChange&poisson_id={$dataPoisson.poisson_id}">
Modifier les informations...
</a>
{/if}
{include file="poisson/poissonDetail.tpl"}
</td>
</tr>
<tr>
<td>
<div id="afficher"><i>Afficher tous les éléments</i></div>
<h3>Événements associés</h3>
<div class="masquage">
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataPoisson.poisson_id}&evenement_id=0">
Nouvel événement...
</a>
{/if}
{include file="poisson/evenementList.tpl"}
<br>
</div>
<h3>Pathologies</h3>
<div class="masquage">
{include file="poisson/pathologieList.tpl"}
<br>
</div>
<h3>Mortalité</h3>
<div class="masquage">
{include file="poisson/mortaliteList.tpl"}
<br>
</div>
<h3>Transferts effectués</h3>
<div class="masquage">
{include file="poisson/transfertList.tpl"}
<br>
</div>
</td>
<td>
<h3>Liste des (pit)tags attribués</h3>
<div class="masquage">
{if $droits["poissonGestion"]==1}
<a href="index.php?module=pittagChange&poisson_id={$dataPoisson.poisson_id}&pittag_id=0">
Nouveau pittag ou étiquette...
</a>
{/if}
{include file="poisson/pittagList.tpl"}
<br>
</div>
<h3>Données morphologiques</h3>
<div class="masquage">
{include file="poisson/morphologieList.tpl"}
<br>
</div>
<h3>Détermination du sexe</h3>
<div class="masquage">
{include file="poisson/genderSelectionList.tpl"}
<br>
</div>
<h3>Anomalies relevées dans les données</h3>
<div class="masquage">
{if $droits["poissonGestion"] == 1}
<a href="index.php?module=anomalieChange&poisson_id={$dataPoisson.poisson_id}&anomalie_db_id=0&module_origine=poissonDisplay">
Créer une anomalie manuellement
</a>
{/if}
{include file="poisson/anomalieDbList.tpl"}
<br>
</div>
</td>
</tr>
</table>
