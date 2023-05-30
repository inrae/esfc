<a href="index.php?module=lotList">Retour à la liste des lots</a>&nbsp;
<a href="index.php?module=lotDisplay&lot_id={$data.lot_id}">Retour au lot</a>
{include file="repro/lotDetail.tpl"}

<h2>{t}Modification de l'attribution d'un bassin{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="bassinLotForm" method="post" action="index.php?module=bassinLotWrite" >
<input type="hidden" name="bassin_lot_id" value="{$data.bassin_lot_id}">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de début d'utilisation :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" class="date" name="bl_date_arrivee" value="{$data.bl_date_arrivee}" required>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Bassin :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<select id="" class="form-control" name="bassin_id" >
{section name=lst loop=$bassins}
<option value="{$bassins[lst].bassin_id}" {if $bassins[lst].bassin_id == $data.bassin_id}selected{/if}>
{$bassins[lst].bassin_nom}
</option>
{/section}
</select>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de fin d'utilisation :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="date" name="bl_date_depart" value="{$data.bl_date_depart}">

</div>
</div>
<div class="form-group"></div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.bassin_lot_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="bassinLotDelete">
<input type="hidden" name="bassin_lot_id" value="{$data.bassin_lot_id}">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
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