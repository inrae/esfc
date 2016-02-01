<a href="index.php?module=lotList">Retour à la liste</a>
<h2>Détail d'un lot</h2>
<div class="tableCell">
{if $droits.reproGestion == 1}
<a href="index.php?module=lotChange&lot_id={$dataLot.lot_id}">Modifier le lot</a>
{/if}
{include file="repro/lotDetail.tpl"}
<br>
<fieldset>
<legend>Comptages et mesures</legend>
{include file="repro/lotMesureList.tpl"}
</fieldset>
<br>
<fieldset>
<legend>Bassins utilisés</legend>
{include file="repro/bassinLotList.tpl"}
</fieldset>
<br>
<fieldset>
<legend>Devenir du lot</legend>
{include file="repro/devenirList.tpl"}
</fieldset>
</div>
