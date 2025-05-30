<h2>{t}Hormones utilisées pour la reproduction{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="hormoneChange?hormone_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="chormoneList" class="tableliste">
<thead>
<tr>
<th>{t}Nom de l'hormone{/t}</th>
<th>{t}Unité utilisée pour l'injection{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $rights["paramAdmin"] == 1||$rights.reproAdmin == 1}
<a href="hormoneChange?hormone_id={$data[lst].hormone_id}">
{$data[lst].hormone_nom}
</a>
{else}
{$data[lst].hormone_nom}
{/if}
</td>
<td>
{$data[lst].hormone_unite}
</td>
</tr>
{/section}
</tbody>
</table>