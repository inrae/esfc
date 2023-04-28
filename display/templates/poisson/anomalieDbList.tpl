<script>
setDataTables("canomalie_dbList");
</script>
<table id="canomalie_dbList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Type d'anomalie</th>
<th>Date</th>
<th>Commentaire</th>
<th>Date de<br>traitement</th>
<th>État</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataAnomalie}
<tr>
<td>
{if $dataAnomalie[lst].evenement_id > 0 && $droits["poissonGestion"] == 1}
<a href="index.php?module=evenementChange&poisson_id={$dataAnomalie[lst].poisson_id}&evenement_id={$dataAnomalie[lst].evenement_id}">
{$dataAnomalie[lst].evenement_type_libelle}
</a>
{else}
{$dataAnomalie[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataAnomalie[lst].anomalie_db_type_libelle}</td>
<td>{$dataAnomalie[lst].anomalie_db_date}</td>
<td>{$dataAnomalie[lst].anomalie_db_commentaire}</td>
<td>{$dataAnomalie[lst].anomalie_db_date_traitement}</td>
<td>
<div class="center">
{if $dataAnomalie[lst].anomalie_db_statut == 1}
<img src="display/images/ok_icon.png" height="20">
{else}
<img src="display/images/warning_icon.png" height="20">
{/if}
</div>
</td>
</tr>
{/section}
</tdata>
</table>