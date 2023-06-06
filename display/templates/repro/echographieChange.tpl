<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2>{t}Modification d'une échographie{/t}</h2>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="echographieForm" method="post" action="index.php?module=echographieWrite">
<input type="hidden" name="echographie_id" value="{$data.echographie_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de l'échographie :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" class="date" name="echographie_date" required size="10" maxlength="10" value="{$data.echographie_date}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Commentaires :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="commentaire" name="echographie_commentaire" value="{$data.echographie_commentaire}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nombre de clichés :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="nombre" name="cliche_nb" value="{$data.cliche_nb}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Référence des clichés :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="commentaire" name="cliche_ref" value="{$data.cliche_ref}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Stade des gonades :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="stade_gonade_id">
<option value="" {if $data.stade_gonade_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$gonades}
<option value="{$gonades[lst].stade_gonade_id}" {if $data.stade_gonade_id == $gonades[lst].stade_gonade_id}selected{/if}>
{$gonades[lst].stade_gonade_id}
</option>
{/section}
</select>

</div>

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Stade des œufs :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="stade_oeuf_id">
<option value="" {if $data.stade_oeuf_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$oeufs}
<option value="{$oeufs[lst].stade_oeuf_id}" {if $data.stade_oeuf_id == $oeufs[lst].stade_oeuf_id}selected{/if}>
{$oeufs[lst].stade_oeuf_id}
</option>
{/section}
</select>

</div>


<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>
{if $data.echographie_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="echographieDelete">
<input type="hidden" name="echographie_id" value="{$data.echographie_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
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
<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>

<h3>Photos associées</h3>
{include file="document/documentList.tpl"}