<script>
setDataTables("cpittagList");
</script>
<table id="cpittagList" class="tableaffichage">
<thead>
<tr>
<th>Valeur</th>
<th>Type de pittag</th>
<th>Date de pose</th>
<th>Commentaire</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataPittag}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=pittagChange&poisson_id={$dataPittag[lst].poisson_id}&pittag_id={$dataPittag[lst].pittag_id}">
{$dataPittag[lst].pittag_valeur}
</a>
{else}
{$dataPittag[lst].pittag_valeur}
{/if}
</td>
<td>{$dataPittag[lst].pittag_type_libelle}</td>
<td>{$dataPittag[lst].pittag_date_pose}</td>
<td>{$dataPittag[lst].pittag_commentaire}</td>
</tr>
{/section}
</tdata>
</table>