<script>
setDataTables("clotMesureList");
</script>
{if $droits["reproGestion"] == 1}
<a href="index.php?module=lotMesureChange&lot_mesure_id=0&lot_id={$dataLot.lot_id}">
Nouvelle mesure...
</a>
{/if}
<table id="clotMesureList" class="tableliste">
<thead>
<tr>
<th>Date</th>
<th>Nbre de<br>jours</th>
<th>Mortalité</th>
<th>Mortalité<br>cumulée</th>
<th>Masse<br>globale</th>
<th>Masse<br>individuelle</th>
</tr>
</thead>
<tdata>
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
</tdata>
</table>