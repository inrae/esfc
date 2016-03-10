<script>
setDataTables("canesthesieList");
</script>
<table id="canesthesieList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Date</th>
<th>Produit utilisé</th>
<th>Dosage (mg/l)</th>
<th>Commentaire</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataAnesthesie}
<tr>
<td>
{if $droits["poissonGestion"]==1||$droits.reproGestion==1}
<a href="index.php?module=evenementChange&poisson_id={$dataAnesthesie[lst].poisson_id}&evenement_id={$dataAnesthesie[lst].evenement_id}">
{$dataAnesthesie[lst].evenement_type_libelle}
</a>
{else}
{$dataAnesthesie[lst].evenement_type_libelle}
{/if}
</td>
<td>
{$dataAnesthesie[lst].anesthesie_date}
</td>
<td>{$dataAnesthesie[lst].anesthesie_produit_libelle}</td>
<td class="center">{$dataAnesthesie[lst].anesthesie_dosage}</td>
<td>{$dataAnesthesie[lst].anesthesie_commentaire}</td>
</tr>
{/section}
</tbody>
</table>
