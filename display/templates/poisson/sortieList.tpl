<script>
setDataTables("csortieList");
</script>
<table id="csortieList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Lieu</th>
<th>Date</th>
<th>Sevrage/Commentaire</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataSortie}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataSortie[lst].poisson_id}&evenement_id={$dataSortie[lst].evenement_id}">
{$dataSortie[lst].evenement_type_libelle}
</a>
{else}
{$dataSortie[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataSortie[lst].localisation}</td>
<td>{$dataSortie[lst].sortie_date}</td>
<td>
{$dataSortie[lst].sevre}
{if strlen($dataSortie[lst].sevre) > 0 && strlen($dataSortie[lst].sortie_commentaire) > 0}
<br>
{/if}
{$dataSortie[lst].sortie_commentaire}</td>
</tr>
{/section}
</tdata>
</table>