{if strlen($poissonDetailParent) > 0}
<a href="index.php?module={$poissonDetailParent}">Retour à la liste des poissons</a>&nbsp;
{/if}
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$dataSperme.poisson_campagne_id}">
Retour au reproducteur
</a>
&nbsp;
<a href="index.php?module=spermeChange&sperme_id={$data.sperme_id}">Retour au prélèvement</a>
{include file="repro/poissonCampagneDetail.tpl"}

<h2>{t}Modification de l'analyse du prélèvement{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="spermeMesureForm" method="post" action="index.php?module=spermeMesureWrite">
{include file="repro/spermeMesureChangeCorps.tpl"}

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.sperme_mesure_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="spermeMesureDelete">
<input type="hidden" name="sperme_mesure_id" value="{$data.sperme_mesure_id}">
<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
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