
<a href="index.php?module={$poissonDetailParent}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<table class="tablemulticolonne">
<tr>
<td>
<fieldset>
<legend>{t}Modification d'un prélèvement de sperme{/t}</legend>

<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="spermeForm" method="post" action="index.php?module=spermeWrite">
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
{include file="repro/spermeChangeCorps.tpl"}


<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.sperme_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="spermeDelete">
<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
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
</fieldset>
</td>
<td>
<fieldset>
<legend>{t}Analyses réalisées{/t}</legend>
{include file="repro/spermeMesureList.tpl"}
</fieldset>
</td>
</tr>
<tr>
<td colspan="2">
<!-- Ajout de l'affichage des congelations -->
{if $data.sperme_id > 0}
<fieldset>
<legend>{t}Congélations{/t}</legend>
{include file="repro/spermeCongelationList.tpl"}
</fieldset>
{/if}
</td>
</tr>
</table>