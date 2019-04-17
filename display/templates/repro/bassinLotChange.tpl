<a href="index.php?module=lotList">Retour à la liste des lots</a>&nbsp;
<a href="index.php?module=lotDisplay&lot_id={$data.lot_id}">Retour au lot</a>
{include file="repro/lotDetail.tpl"}

<h2>Modification de l'attribution d'un bassin</h2>
<div class="formSaisie">
<div>
<form id="bassinLotForm" method="post" action="index.php?module=bassinLotWrite" >
<input type="hidden" name="bassin_lot_id" value="{$data.bassin_lot_id}">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
<dl>
<dt>Date de début d'utilisation <span class="red">*</span> :</dt>
<dd>
<input class="date" name="bl_date_arrivee" value="{$data.bl_date_arrivee}" required>
</dd>
</dl>
<dl>
<dt>Bassin <span class="red">*</span> :</dt>
<dd>
<select name="bassin_id" >
{section name=lst loop=$bassins}
<option value="{$bassins[lst].bassin_id}" {if $bassins[lst].bassin_id == $data.bassin_id}selected{/if}>
{$bassins[lst].bassin_nom}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Date de fin d'utilisation :</dt>
<dd>
<input class="date" name="bl_date_depart" value="{$data.bl_date_depart}">
</dd>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.bassin_lot_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="bassinLotDelete">
<input type="hidden" name="bassin_lot_id" value="{$data.bassin_lot_id}">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>