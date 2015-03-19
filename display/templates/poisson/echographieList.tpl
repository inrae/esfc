<script>
setDataTables("cechographieList");
</script>
<table id="cechographieList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Date</th>
<th>Commentaire</th>
</tr>
</thead>
<tdata>
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
<td>{$dataEcho[lst].echographie_commentaire}</td>
</tr>
{/section}
</tdata>
</table>
