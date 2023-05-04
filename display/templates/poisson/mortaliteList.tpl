<script>
setDataTables("cmortaliteList");
</script>
<table class="table table-bordered table-hover datatable" id="cmortaliteList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Type de mortalite</th>
<th>Date</th>
<th>Commentaire</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataMortalite}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataMortalite[lst].poisson_id}&evenement_id={$dataMortalite[lst].evenement_id}">
{$dataMortalite[lst].evenement_type_libelle}
</a>
{else}
{$dataMortalite[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataMortalite[lst].mortalite_type_libelle}</td>
<td>{$dataMortalite[lst].mortalite_date}</td>
<td>{$dataMortalite[lst].mortalite_commentaire}</td>
</tr>
{/section}
</tbody>
</table>