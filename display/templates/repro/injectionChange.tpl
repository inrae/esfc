<script>
$(document).ready(function() {

	$(".commentaire").attr("size","30");
});
</script>
<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2>{t}Modification d'une injection{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="injectionForm" method="post" action="index.php?module=injectionWrite">
<input type="hidden" name="injection_id" value="{$data.injection_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de l'injection :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" class="datetimepicker" name="injection_date" required value="{$data.injection_date}">
<!--  input class="timepicker" name="injection_time" required value="{$data.injection_time}"-->

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Séquence de reproduction :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<select id="" class="form-control" name="sequence_id">
{section name=lst loop=$sequences}
<option value="{$sequences[lst].sequence_id}" {if $data.sequence_id == $sequences[lst].sequence_id}selected{/if}>
{$sequences[lst].sequence_nom}
</option>
{/section}
</select>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Hormone utilisée :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="hormone_id">
<option value="" {if $data.hormone_id==""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$hormones}
<option value="{$hormones[lst].hormone_id}" {if $data.hormone_id == $hormones[lst].hormone_id}selected{/if}>
{$hormones[lst].hormone_nom} - unité : {$hormones[lst].hormone_unite}
</option>
{/section}
</select>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Dose injectée :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="injection_dose" value="{$data.injection_dose}"></div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Commentaire :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="commentaire" name="injection_commentaire" value="{$data.injection_commentaire}">

</div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.injection_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="injectionDelete">
<input type="hidden" name="injection_id" value="{$data.injection_id}">
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
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>
