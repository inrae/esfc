<h2>Types de mortalité</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=mortaliteTypeChange&mortalite_type_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cmortaliteTypeList");
</script>
<table id="cmortaliteTypeList" class="tableaffichage">
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
<a href="index.php?module=mortaliteTypeChange&mortalite_type_id={$data[lst].mortalite_type_id}">
{$data[lst].mortalite_type_libelle}
</a>
{else}
{$data[lst].mortalite_type_libelle}
{/if}
</td>
</tr>
{/section}
</tdata>
</table>