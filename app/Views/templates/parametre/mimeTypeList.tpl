<h2>{t}Types de fichiers importables{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="mimeTypeChange?mime_type_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cmimeTypeList" class="tableliste">
<thead>
<tr>
<th>{t}extension{/t}</th>
<th>{t}type mime{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $rights["paramAdmin"] == 1}
<a href="mimeTypeChange?mime_type_id={$data[lst].mime_type_id}">
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