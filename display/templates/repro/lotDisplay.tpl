<a href="index.php?module=lotList">Retour à la liste</a>
<h2>Détail d'un lot</h2>
{if $droits.reproGestion == 1}
<a href="index.php?module=lotChange&lot_id={$dataLot.lot_id}">Modifier le lot</a>
{/if}
{include file="repro/lotDetail.tpl"}
<br>
{include file="repro/lotMesureList.tpl"}