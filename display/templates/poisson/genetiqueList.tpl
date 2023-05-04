<script>
setDataTables("cgenetiqueList");
</script>
<table class="table table-bordered table-hover datatable" id="cgenetiqueList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Date</th>
<th>Référence</th>
<th>Nageoire</th>
<th>Commentaire</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataGenetique}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataGenetique[lst].poisson_id}&evenement_id={$dataGenetique[lst].evenement_id}">
{$dataGenetique[lst].evenement_type_libelle}
</a>
{else}
{$dataGenetique[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataGenetique[lst].genetique_date}</td>
<td>{$dataGenetique[lst].genetique_reference}</td>
<td>{$dataGenetique[lst].nageoire_libelle}</td>
<td>{$dataGenetique[lst].genetique_commentaire}</td>
</tr>
{/section}
</tbody>
</table>