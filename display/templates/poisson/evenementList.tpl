<script>
setDataTables("cevenementList");
</script>
<table class="table table-bordered table-hover datatable" id="cevenementList" class="tableliste">
<thead>
<tr>
<th>{t}Nature{/t}<th>
<th>{t}Date{/t}<th>
<th>{t}Commentaire{/t}<th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataEvenement}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataEvenement[lst].poisson_id}&evenement_id={$dataEvenement[lst].evenement_id}">
{$dataEvenement[lst].evenement_type_libelle}
</a>
{else}
{$dataEvenement[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataEvenement[lst].evenement_date}</td>
<td>{$dataEvenement[lst].evenement_commentaire}</td>
</tr>
{/section}
</tbody>
</table>