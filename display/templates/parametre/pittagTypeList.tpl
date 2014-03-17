<h2>Types de pittag</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=pittagTypeChange&pittag_type_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("pittagList");
</script>
<table id="pittagList" class="tableaffichage">
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
<a href="index.php?module=pittagTypeChange&pittag_type_id={$data[lst].pittag_type_id}">
{$data[lst].pittag_type_libelle}
</a>
{else}
{$data[lst].pittag_type_libelle}
{/if}
</td>
</tr>
{/section}
</tdata>
</table>
