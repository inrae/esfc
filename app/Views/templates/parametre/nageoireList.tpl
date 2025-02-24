<h2>{t}Nageoires (prélèvements génétiques){/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="nageoireChange?nageoire_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cnageoireList" class="tableliste">
<thead>
<tr>
<th>{t}Libellé{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $rights["paramAdmin"] == 1||$rights.reproAdmin == 1}
<a href="nageoireChange?nageoire_id={$data[lst].nageoire_id}">
{$data[lst].nageoire_libelle}
</a>
{else}
{$data[lst].nageoire_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>