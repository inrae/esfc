<script>
setDataTables("ccohorteList");
</script>
<table id="ccohorteList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Type de<br>détermination</th>
<th>Cohorte<br>déterminée</th>
<th>Date</th>
<th>Commentaire</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataCohorte}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataCohorte[lst].poisson_id}&evenement_id={$dataCohorte[lst].evenement_id}">
{$dataCohorte[lst].evenement_type_libelle}
</a>
{else}
{$dataCohorte[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataCohorte[lst].cohorte_type_libelle}</td>
<td>{$dataCohorte[lst].cohorte_determination}</td>
<td>{$dataCohorte[lst].cohorte_date}</td>
<td>{$dataCohorte[lst].cohorte_commentaire}</td>
</tr>
{/section}
</tdata>
</table>