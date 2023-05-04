<h2{t}Types de bassins{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=bassinTypeChange&bassin_type_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cbassinTypeList");
</script>
<table class="table table-bordered table-hover datatable" id="cbassinTypeList" class="tableliste">
<thead>
<tr>
<th>libellé</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=bassinTypeChange&bassin_type_id={$data[lst].bassin_type_id}">
{$data[lst].bassin_type_libelle}
</a>
{else}
{$data[lst].bassin_type_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>