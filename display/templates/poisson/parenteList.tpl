<script>
setDataTables("cparenteList");
</script>
<table class="table table-bordered table-hover datatable" id="cparenteList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Type de parente</th>
<th>Date</th>
<th>Commentaire</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataParente}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataParente[lst].poisson_id}&evenement_id={$dataParente[lst].evenement_id}">
{$dataParente[lst].evenement_type_libelle}
</a>
{else}
{$dataParente[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataParente[lst].determination_parente_libelle}</td>
<td>{$dataParente[lst].parente_date}</td>
<td>{$dataParente[lst].parente_commentaire}</td>
</tr>
{/section}
</tbody>
</table>