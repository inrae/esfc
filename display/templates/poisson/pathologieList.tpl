<script>
setDataTables("cpathologieList");
</script>
<table id="cpathologieList" class="tableaffichage">
<thead>
<tr>
<th>Date</th>
<th>Type de pathologie</th>
<th>Commentaire</th>
<th>Événement associé</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataPatho}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=pathologieChange&poisson_id={$dataPatho[lst].poisson_id}&pathologie_id={$dataPatho[lst].pathologie_id}">
{$dataPatho[lst].pathologie_date}
</a>
{else}
{$dataPatho[lst].pathologie_date}
{/if}
</td>
<td>{$dataPatho[lst].pathologie_type_libelle}</td>
<td>{$dataPatho[lst].pathologie_commentaire}</td>
<td>{$dataPatho[lst].evenement_type_libelle}</td>
</tr>
{/section}
</tdata>
</table>