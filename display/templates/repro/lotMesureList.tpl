<script>
setDataTables("clotMesureList");
</script>
{if $droits["reproGestion"] == 1}
<a href="index.php?module=lotMesureChange&lot_mesure_id=0&lot_id={$dataLot.lot_id}">
Nouvelle mesure...
</a>
{/if}
<table class="table table-bordered table-hover datatable" id="clotMesureList" class="tableliste">
<thead>
<tr>
<th>{t}Date{/t}<th>
<th>{t}Nbre de<br>jours{/t}<th>
<th>{t}Mortalité{/t}<th>
<th>{t}Mortalité<br>cumulée{/t}<th>
<th>{t}Masse<br>globale{/t}<th>
<th>{t}Masse<br>individuelle{/t}<th>
</tr>
</thead>
<tbody>
{assign var=mortalite value=0}
{section name=lst loop=$dataMesure}
<tr>
<td>
{if $droits.reproGestion == 1}
<a href="index.php?module=lotMesureChange&lot_mesure_id={$dataMesure[lst].lot_mesure_id}">
{$dataMesure[lst].lot_mesure_date}
</a>
{else}
{$dataMesure[lst].lot_mesure_date}
{/if}
</td>
<td class="center">{$dataMesure[lst].nb_jour}</td>
<td class="right">{$dataMesure[lst].lot_mortalite}</td>
{assign var=mortalite value=$mortalite + $dataMesure[lst].lot_mortalite}
<td class="right">{$mortalite}</td>
<td class="right">{$dataMesure[lst].lot_mesure_masse}</td>
<td class="right">{$dataMesure[lst].lot_mesure_masse_indiv}</td>
</tr>
{/section}
</tbody>
</table>