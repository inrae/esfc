<a href="index.php?module={$poissonDetailParent}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Retour au reproducteur
</a>&nbsp;
<a href="index.php?module=spermeChange&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&sperme_id={$dataCongelation.sperme_id}">
Retour au sperme prélevé
</a>
</a>&nbsp;
<a href="index.php?module=spermeCongelationChange&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&sperme_id={$dataCongelation.sperme_id}&sperme_congelation_id={$dataCongelation.sperme_congelation_id}">
Retour à la congélation
</a>
{include file="repro/poissonCampagneDetail.tpl"}

<h2>{t}Modification d'une température relevée pendant la phase de congélation{/t}</h2>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="spermeFreezingMeasureForm" method="post" action="index.php?module=spermeFreezingMeasureWrite">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
<input type="hidden" name="sperme_id" value="{$dataCongelation.sperme_id}">
<input type="hidden" name="sperme_freezing_measure_id" value="{$data.sperme_freezing_measure_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date/heure:{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" name="measure_date" class="datetimepicker" value="{$data.measure_date}">
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Temperature relevée:{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" name="measure_temp" class="taux" value="{$data.measure_temp}" autofocus>
</div>



<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>
{if $data.sperme_freezing_measure_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="spermeFreezingMeasureDelete">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<input type="hidden" name="sperme_id" value="{$spermeCongelation.sperme_id}">
<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
<input type="hidden" name="sperme_freezing_measure_id" value="{$data.sperme_freezing_measure_id}">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>