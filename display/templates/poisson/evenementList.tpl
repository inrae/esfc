<script>
setDataTables("cevenementList");
</script>
<table id="cevenementList" class="tableaffichage">
<thead>
<tr>
<th>Date</th>
<th>Nature</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataEvenement}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataEvenement[lst].poisson_id}&evenement_id={$dataEvenement[lst].evenement_id}">
{$dataEvenement[lst].evenement_date}
</a>
{else}
{$dataEvenement[lst].evenement_date}
{/if}
</td>
<td>{$dataEvenement[lst].evenement_type_libelle}</td>
</tr>
{/section}
</tdata>
</table>