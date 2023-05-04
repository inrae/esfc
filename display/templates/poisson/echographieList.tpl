<script>
setDataTables("cechographieList");
</script>
<table class="table table-bordered table-hover datatable" id="cechographieList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Date</th>
<th>Stade gonade</th>
<th>Stade œufs</th>
<th>Commentaire</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataEcho}
<tr>
<td>
{if $droits["poissonGestion"]==1||$droits.reproGestion==1}
<a href="index.php?module=evenementChange&poisson_id={$dataEcho[lst].poisson_id}&evenement_id={$dataEcho[lst].evenement_id}">
{$dataEcho[lst].evenement_type_libelle}
</a>
{else}
{$dataEcho[lst].evenement_type_libelle}
{/if}
</td>
<td>
{$dataEcho[lst].echographie_date}
</td>
<td>{$dataEcho[lst].stade_gonade_libelle}</td>
<td>{$dataEcho[lst].stade_oeuf_libelle}</td>
<td>{$dataEcho[lst].echographie_commentaire}</td>
</tr>
{/section}
</tbody>
</table>
