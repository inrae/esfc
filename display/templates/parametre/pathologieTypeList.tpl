<h2>Types de pathologies</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=pathologieTypeChange&pathologie_type_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cpathologieTypeList");
</script>
<table id="cpathologieTypeList" class="tableaffichage">
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
<a href="index.php?module=pathologieTypeChange&pathologie_type_id={$data[lst].pathologie_type_id}">
{$data[lst].pathologie_type_libelle}
</a>
{else}
{$data[lst].pathologie_type_libelle}
{/if}
</td>
</tr>
{/section}
</tdata>
</table>