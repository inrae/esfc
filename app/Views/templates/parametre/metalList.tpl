<h2>{t}Liste des métaux analysés{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="metalChange?metal_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cmetalList" class="tableliste">
<thead>
<tr>
<th>{t}Nom du metal{/t}</th>
<th>{t}Unité utilisée pour la mesure{/t}</th>
<th>{t}Actif ?{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $rights["paramAdmin"] == 1||$rights.reproAdmin == 1}
<a href="metalChange?metal_id={$data[lst].metal_id}">
{$data[lst].metal_nom}
</a>
{else}
{$data[lst].metal_nom}
{/if}
</td>
<td>
{$data[lst].metal_unite}
</td>
<td class="center">
{if $data[lst].metal_actif == 1}oui
{elseif $data[lst].metal_actif == 0}non
{/if}
</td>
</tr>
{/section}
</tbody>
</table>