<script>
setDataTables("cpathologieList");
</script>
<table id="cpathologieList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Date</th>
<th>Type de pathologie</th>
<th>Commentaire</th>


</tr>
</thead>
<tdata>
{section name=lst loop=$dataPatho}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataPatho[lst].poisson_id}&evenement_id={$dataPatho[lst].evenement_id}">
{$dataPatho[lst].evenement_type_libelle}
</a>
{else}
{$dataPatho[lst].evenement_type_libelle}
{/if}
</td>
<td>
{$dataPatho[lst].pathologie_date}
</td>
<td>{$dataPatho[lst].pathologie_type_libelle}</td>
<td>{$dataPatho[lst].pathologie_commentaire}</td>
</tr>
{/section}
</tdata>
</table>