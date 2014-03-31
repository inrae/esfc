<h2>Types d'anomalie_dbs</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=anomalieDbTypeChange&anomalie_db_type_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("canomalie_dbTypeList");
</script>
<table id="canomalie_dbTypeList" class="tableaffichage">
<thead>
<tr>
{if $droits["paramAdmin"] == 1}
<th>Modifier</th>
{/if}
<th>libellé</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$data}
<tr>
{if $droits["paramAdmin"] == 1}
<td style="text-align:center;">
<a href="index.php?module=anomalieDbTypeChange&anomalie_db_type_id={$data[lst].anomalie_db_type_id}">
<img src="display/images/edit.gif" height="20">
</a>
</td>
{/if}
<td>
{$data[lst].anomalie_db_type_libelle}
</td>
</tr>
{/section}
</tdata>
</table>
