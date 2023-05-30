<a href="index.php?module={$poissonDetailParent}">Retour à la liste des poissons</a>
&nbsp;
<a href="index.php?module={$poissonParent}&poisson_campagne_id={$data.poisson_campagne_id}&poisson_id={$data.poisson_id}">
Retour au détail du poisson
</a>
<h2{t}Sélectionner un poisson pour une campagne{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="poissonCampagneForm" method="post" action="index.php?module=poissonCampagneWrite">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Identification :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="identification" readonly value="{$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Année :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="annee">
{section name=lst loop=$annees}
<option value="{$annees[lst].annee}" {if $annees[lst].annee == $data.annee}selected{/if}>
{$annees[lst].annee}
</option>
{/section}
</select>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}
Statut du poisson pour la repro :
{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="repro_statut_id">
{section name=lst loop=$reproStatut}
<option value="{$reproStatut[lst].repro_statut_id}" {if $reproStatut[lst].repro_statut_id == $data.repro_statut_id}selected{/if}>
{$reproStatut[lst].repro_statut_libelle}
</option>
{/section}
</select>
</div>

<fieldset>
<legend>{t}Indicateurs de croissance (calculés automatiquement en cas de nouvelle sélection){/t}<legend>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Taux de croissance journalier :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="tx_croissance_journalier" size="10" maxlength="10" value="{$data.tx_croissance_journalier}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Taux de croissance spécifique :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="specific_growth_rate" size="10" maxlength="10" value="{$data.specific_growth_rate}">

</div>
</fieldset>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.poisson_campagne_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="poissonCampagneDelete">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>
{/if}
</div>
</div>
