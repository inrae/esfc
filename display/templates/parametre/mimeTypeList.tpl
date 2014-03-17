<h2>Types de fichiers importables</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=mimeTypeChange&mime_type_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cmimeTypeList");
</script>
<table id="cmimeTypeList" class="tableaffichage">
<thead>
<tr>
<th>extension</th>
<th>type mime</th>
</tr>
</thead>
<tdata>
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
</tdata>
</table>