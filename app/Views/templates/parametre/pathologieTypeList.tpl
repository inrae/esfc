<h2>{t}Types de pathologies{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="pathologieTypeChange?pathologie_type_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cpathologieTypeList" class="tableliste">
<thead>
<tr>
<th>{t}libellé{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $rights["paramAdmin"] == 1}
<a href="pathologieTypeChange?pathologie_type_id={$data[lst].pathologie_type_id}">
{$data[lst].pathologie_type_libelle}
</a>
{else}
{$data[lst].pathologie_type_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>