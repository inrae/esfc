<script>
$(document).ready(function() { 
	$("#selectStatut").change(function () {
		$("#search").submit();
	} );
	$(".confirmation").on('click', function () {
        if (confirm("Confirmez-vous la suppression du reproducteur pour l'année considérée ?")) {
        	return true ;
        } else {
        	return false;
        }
    } );
	$("#clistform").submit(function(){
	    if (confirm("Confirmez-vous le changement de statut pour les poissons sélectionnés ?")) {
			return true ;
		} else {
			return false;
		}
	} ) ;
	$("#campagneinit").on('click', function () { 
		if (confirm("Confirmez-vous le rajout de tous les adultes vivants dans la liste ?")) {
			return true ;
		} else {
			return false ;
		}
	} );
} ) ;
//setDataTables("cpoissonList", false, false, true);
</script>
<form method="get" action="index.php" id="search">
<input type="hidden" name="module" value="poissonCampagneList">
<input type="hidden" name="isSearch" value="1">
<table class="tableaffichage">
<tr><td>
Statut de reproduction : 
<select id="selectStatut" name="repro_statut_id">
<option value="0" {if $dataSearch.repro_statut_id == 0}selected{/if}>
Sélectionnez le statut...
</option>
{section name=lst loop=$dataReproStatut}
<option value="{$dataReproStatut[lst].repro_statut_id}" {if $dataReproStatut[lst].repro_statut_id == $dataSearch.repro_statut_id}selected{/if}>
{$dataReproStatut[lst].repro_statut_libelle}
</option>
{/section}
</select>
<br>Année : 
<select name="annee">
{section name=lst loop=$annees}
<option value="{$annees[lst].annee}" {if $annees[lst].annee == $dataSearch.annee}selected{/if}>
{$annees[lst].annee}
</option>
{/section}
</select>
<input type="submit" value="Rechercher">
</td>
</tr>
</table>
</form>

{if $dataSearch.isSearch == 1}
{if $droits.reproGestion == 1}
<a id="campagneinit" href="index.php?module=poissonCampagneInit&annee={$dataSearch.annee}">
Ajouter tous les adultes vivants à la campagne...
</a>
{/if}
<form id="clistform" method="post" action="index.php" >
<input type="hidden" name="module" value="poissonCampagneChangeStatut">

<table id="cpoissonList" class="tableliste">
<thead>
<tr>
<th>Données<br>d'élevage</th>
<th>Identification</th>
<th>Statut de<br>reproduction</th>
<th>Cohorte</th>
<th>Sexe</th>
<th>Masse<br>actuelle</th>
<th>Tx de croissance<br>journalier</th>
<th>Specific<br>growth rate</th>
<th>Années de<br>croisement</th>
<th>Séquences</th>
<th>Sélection</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$data}
<tr>
<td class="center">
<a href=index.php?module=poissonDisplay&poisson_id={$data[lst].poisson_id}>
<img src="display/images/fish.png" height="24" title="Accéder à la fiche détaillée du poisson">
</a>
<td>
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data[lst].poisson_campagne_id}">
{$data[lst].matricule} {$data[lst].prenom} {$data[lst].pittag_valeur}
</a>
</td>
<td>{$data[lst].repro_statut_libelle}</td>

<td class="center">{$data[lst].cohorte}</td>
<td class="center">{$data[lst].sexe_libelle_court}</td>
<td class="right">{$data[lst].masse}</td>
<td class="{if $data[lst].tx_croissance_journalier > 0.02}etat3{else}right{/if}">{$data[lst].tx_croissance_journalier}</td>
<td class="{if $data[lst].specific_growth_rate > 0.02}etat3{else}right{/if}">{$data[lst].specific_growth_rate}</td>
<td>{$data[lst].annees}</td>
<td>{$data[lst].sequences}</td>
<td class="center">
<input type="checkbox" name="poisson_campagne_id[]" value={$data[lst].poisson_campagne_id}>
</td>
</tr>
{/section}
</tdata>
<tr>
<td colspan="10" class="right">
<select name="repro_statut_id">
<option value="0" {if $dataSearch.repro_statut_id == 0}selected{/if}>
Sélectionnez le statut...
</option>
{section name=lst loop=$dataReproStatut}
<option value="{$dataReproStatut[lst].repro_statut_id}" >
{$dataReproStatut[lst].repro_statut_libelle}
</option>
{/section}
</select>
</td>
<td colspan="1" class="right">
<input type="submit" value="Modifier">
</td>

</table>
</form>
{/if}