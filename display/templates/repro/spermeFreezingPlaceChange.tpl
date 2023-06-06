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

<h2>{t}Modification d'une congélation de sperme{/t}</h2>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="spermeFreezingPlaceForm" method="post" action="index.php?module=spermeFreezingPlaceWrite">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
<input type="hidden" name="sperme_id" value="{$dataCongelation.sperme_id}">
<input type="hidden" name="sperme_freezing_place_id" value="{$data.sperme_freezing_place_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nom de la cuve :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="cuve_libelle" value="{$data.cuve_libelle}">
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nombre de visiotubes :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="nombre" name="nb_visiotube" value="{$data.nb_visiotube}">
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Numéro de canister :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="canister_numero" value="{$data.canister_numero}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Position du canister :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="position_canister">
<option value="" {if $data.position_canister == ""}selected{/if}>Sélectionnez...</option>
<option value="1" {if $data.position_canister == "1"}selected{/if}>Bas</option>
<option value="2" {if $data.position_canister == "2"}selected{/if}>Haut</option>
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
{if $data.sperme_freezing_place_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="spermeFreezingPlaceDelete">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<input type="hidden" name="sperme_id" value="{$spermeCongelation.sperme_id}">
<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
<input type="hidden" name="sperme_freezing_place_id" value="{$data.sperme_freezing_place_id}">
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