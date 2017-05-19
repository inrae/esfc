<script>
$(document).ready(function() {
	$("#recalcul").submit(function(event){
		if (! confirm("Confirmez le recalcul des taux de croissance")) {
			event.preventDefault();
		}
	});
});

</script>
<table class="tableaffichage">
<tr>
<td>
<label>Identification : </label>{$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur} - {$dataPoisson.sexe_libelle}
 {if $dataPoisson.poisson_statut_id != 1}- {$dataPoisson.poisson_statut_libelle}{/if}
<span class="lienimage"><a href=index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}>
<img src="display/images/fish.png" height="24" title="Accéder à la fiche détaillée du poisson">
</a> 
</span>
<br>
<label>Année de reproduction : </label>{$dataPoisson.annee}
&nbsp;<label>Statut : </label>{$dataPoisson.repro_statut_libelle}
<br>

<label>Taux de croissance journalier / spécifique : </label>
{$dataPoisson.tx_croissance_journalier}
/ {$dataPoisson.specific_growth_rate}
{if $droits.reproGestion == 1}
<form style="display:inline-block" id="recalcul" method="post" action="index.php?module=poissonCampagneRecalcul&poisson_id={$dataPoisson.poisson_id}&annee={$dataPoisson.poisson_id}">
<input type="hidden" name="poisson_id" value="{$dataPoisson.poisson_id}">
<input type="hidden" name="annee" value="{$dataPoisson.annee}">
<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
<input type="submit" value="Recalculer">
</form>
{/if}

</td>
</tr>
</table>
