<h2>Types d'aliments</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=alimentTypeChange&aliment_type_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("calimentTypeList");
</script>
<table id="calimentTypeList" class="tableliste">
<thead>
<tr>
<th>libellé</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=alimentTypeChange&aliment_type_id={$data[lst].aliment_type_id}">
{$data[lst].aliment_type_libelle}
</a>
{else}
{$data[lst].aliment_type_libelle}
{/if}
</td>
</tr>
{/section}
</tdata>
</table>