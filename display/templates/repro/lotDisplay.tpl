<a href="index.php?module=lotList">{t}Retour à la liste{/t}</a>
<h2>{t}Détail d'un lot{/t}</h2>
<div class="tableCell">
{if $droits.reproGestion == 1}
<a href="index.php?module=lotChange&lot_id={$dataLot.lot_id}">Modifier le lot</a>
{/if}
{include file="repro/lotDetail.tpl"}
<br>
<fieldset>
<legend>{t}Comptages et mesures{/t}</legend>
{include file="repro/lotMesureList.tpl"}
</fieldset>
<br>
<fieldset>
<legend>{t}Bassins utilisés{/t}</legend>
{include file="repro/bassinLotList.tpl"}
</fieldset>
<br>
<fieldset>
<legend>{t}Devenir du lot{/t}</legend>
{include file="repro/devenirList.tpl"}
</fieldset>
</div>
