<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2>Modification d'une échographie</h2>
<div class="formSaisie">
<div>
<form id="echographieForm" method="post" action="index.php?module=echographieWrite">
<input type="hidden" name="echographie_id" value="{$data.echographie_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<dl>
<dt>Date de l'échographie <span class="red">*</span> :</dt>
<dd>
<input class="date" name="echographie_date" required size="10" maxlength="10" value="{$data.echographie_date}">
</dd>
</dl>
<dl>
<dt>Commentaires :</dt>
<dd>
<input class="commentaire" name="echographie_commentaire" value="{$data.echographie_commentaire}">
</dd>
</dl>
<dl>
<dt>Nombre de clichés :</dt>
<dd>
<input class="nombre" name="cliche_nb" value="{$data.cliche_nb}">
</dd>
</dl>
<dl>
<dt>Référence des clichés :</dt>
<dd>
<input class="commentaire" name="cliche_ref" value="{$data.cliche_ref}">
</dd>
</dl>
<dl>
<dt>Stade des gonades :</dt>
<dd>
<select name="stade_gonade_id">
<option value="" {if $data.stade_gonade_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$gonades}
<option value="{$gonades[lst].stade_gonade_id}" {if $data.stade_gonade_id == $gonades[lst].stade_gonade_id}selected{/if}>
{$gonades[lst].stade_gonade_id}
</option>
{/section}
</select>
</dd>
</dl>

<dl>
<dt>Stade des œufs :</dt>
<dd>
<select name="stade_oeuf_id">
<option value="" {if $data.stade_oeuf_id == ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$oeufs}
<option value="{$oeufs[lst].stade_oeuf_id}" {if $data.stade_oeuf_id == $oeufs[lst].stade_oeuf_id}selected{/if}>
{$oeufs[lst].stade_oeuf_id}
</option>
{/section}
</select>
</dd>
</dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.echographie_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="echographieDelete">
<input type="hidden" name="echographie_id" value="{$data.echographie_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>

<h3>Photos associées</h3>
{include file="document/documentList.tpl"}