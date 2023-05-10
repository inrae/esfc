<script>
setDataTables("cpittagList");
</script>
<table class="table table-bordered table-hover datatable" id="cpittagList" class="tableliste">
<thead>
<tr>
<th>{t}Valeur{/t}<th>
<th>{t}Type de pittag{/t}<th>
<th>{t}Date de pose{/t}<th>
<th>{t}Commentaire{/t}<th>
</tr>
</thead>
<tbody>
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
</tbody>
</table>