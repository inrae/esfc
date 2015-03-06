<script>
$(document).ready(function() {
	$(".taux").attr("pattern","[0-9]+(\.[0-9]+)?");
	$(".taux").attr("title","valeur numérique");
});
</script>
<a href="index.php?module=poissonCampagneList">Retour à la liste des poissons</a>
&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au détail du poisson
</a>
<h2>Modifier les taux de croissance d'un poisson</h2>
<div class="formSaisie">
<div>
<form id="poissonCampagneForm" method="post" action="index.php?module=poissonCampagneWrite">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<dl>
<dt>Identification :</dt>
<dd>
<input name="identification" readonly value="{$data.matricule} {$data.prenom} {$data.pittag_valeur}">
</dd>
</dl>
<dl>
<dt>Année :</dt>
<dd>
<input name="annee" readonly value="{$data.annee}">
</dd>
</dl>

<fieldset>
<legend>Indicateurs de croissance</legend>
<dl>
<dt>Taux de croissance journalier :</dt>
<dd>
<input class="taux" name="tx_croissance_journalier" size="10" maxlength="10" value="{$data.tx_croissance_journalier}">
</dd>
</dl>
<dl>
<dt>Taux de croissance spécifique :</dt>
<dd>
<input class="taux" name="specific_growth_rate" size="10" maxlength="10" value="{$data.specific_growth_rate}">
</dd>
</dl>
</fieldset>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.poisson_campagne_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="poissonCampagneDelete">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
