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

<h2>Modification d'une congélation de sperme</h2>
<div class="formSaisie">
<div>
<form id="spermeFreezingPlaceForm" method="post" action="index.php?module=spermeFreezingPlaceWrite">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
<input type="hidden" name="sperme_id" value="{$dataCongelation.sperme_id}">
<input type="hidden" name="sperme_freezing_place_id" value="{$data.sperme_freezing_place_id}">
<dl>
<dt>Nom de la cuve :</dt>
<dd><input name="cuve_libelle" value="{$data.cuve_libelle}"></dd>
</dl>
<dl>
<dt>Nombre de visiotubes :</dt>
<dd><input class="nombre" name="nb_visiotube" value="{$data.nb_visiotube}"></dd>
</dl>
<dl>
<dt>Numéro de canister :</dt>
<dd><input name="canister_numero" value="{$data.canister_numero}">
</dd>
</dl>
<dl>
<dt>Position du canister :</dt>
<dd>
<select name="position_canister">
<option value="" {if $data.position_canister == ""}selected{/if}>Sélectionnez...</option>
<option value="1" {if $data.position_canister == "1"}selected{/if}>Bas</option>
<option value="2" {if $data.position_canister == "2"}selected{/if}>Haut</option>
</select>
</dd>
</dl>


<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.sperme_freezing_place_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="spermeFreezingPlaceDelete">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<input type="hidden" name="sperme_id" value="{$spermeCongelation.sperme_id}">
<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
<input type="hidden" name="sperme_freezing_place_id" value="{$data.sperme_freezing_place_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>