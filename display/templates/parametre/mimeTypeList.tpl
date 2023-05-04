<h2{t}Types de fichiers importables{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=mimeTypeChange&mime_type_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cmimeTypeList");
</script>
<table class="table table-bordered table-hover datatable" id="cmimeTypeList" class="tableliste">
<thead>
<tr>
<th>extension</th>
<th>type mime</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=mimeTypeChange&mime_type_id={$data[lst].mime_type_id}">
{$data[lst].extension}
</a>
{else}
{$data[lst].extension}
{/if}
</td>
<td>
{$data[lst].content_type}
</td>
</tr>
{/section}
</tbody>
</table>