<a href="index.php?module={$poissonDetailParent}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Retour au reproducteur
</a>&nbsp;
<a href="index.php?module=spermeChange&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&sperme_id={$data.sperme_id}">
Retour au sperme
</a>
{include file="repro/poissonCampagneDetail.tpl"}

<h2>Modification d'une congélation de sperme</h2>
<div class="formSaisie">
<div>
<form id="spermeForm" method="post" action="index.php?module=spermeCongelationWrite">


<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
<dl>
<dt>Date de congélation<span class="red">*</span> :</dt>
<dd><input class="date" name="congelation_date" value="{$data.congelation_date}" required ></dd>
</dl>
<dl>
<dt>Volume congelé (ml) :</dt>
<dd><input class="taux" name="congelation_volume" value="{$data.congelation_volume}">
</dd>
</dl>
<dl>
<dt>Dilueur utilisé : </dt>
<dd>
<select name="sperme_dilueur_id">
<option value="" {if $data.sperme_dilueur_id == ""}selected{/if}>Choisissez...</option>
{section name=lst loop=$spermeDilueur}
<option value="{$spermeDilueur[lst].sperme_dilueur_id}" {if $data.sperme_dilueur_id == $spermeDilueur[lst].sperme_dilueur_id}selected{/if}>
{$spermeDilueur[lst].sperme_dilueur_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Nombre de paillettes :</dt>
<dd><input class="nombre" name="nb_paillette" value="{$data.nb_paillette}"></dd>
</dl>
<dl>
<dt>Nombre de visiotubes :</dt>
<dd><input class="nombre" name="nb_visiotube" value="{$data.nb_visiotube}"></dd>
</dl>
<dl>
<dt>Numéro de canister :</dt>
<dd><input name="numero_canister" value="{$data.numero_canister}">
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
<dl>
<dt>Commentaire :</dt>
<dd>
<input class="commentaire" name="sperme_congelation_commentaire" value="{$data.sperme_congelation_commentaire}">
</dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.sperme_congelation_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="spermeCongelationDelete">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>