<script>
setDataTables("canomalie_dbList");
</script>
<table id="canomalie_dbList" class="tableaffichage">
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
<td>{$dataAnomalie[lst].evenement_type_libelle}</td>
<td>{$dataAnomalie[lst].anomalie_db_type_libelle}</td>
<td>{$dataAnomalie[lst].anomalie_db_date}</td>
<td>{$dataAnomalie[lst].anomalie_db_commentaire}</td>
<td>{$dataAnomalie[lst].anomalie_db_date_traitement}</td>
<td>
{if $dataAnomalie[lst].anomalie_db_statut == 1}
<img src="display/images/ok_icon.png" height="20">
{else}
<img src="display/images/warning_icon.png" height="20">
{/if}
</td>
</tr>
{/section}
</tdata>
</table>