<h2>{t}Méthodes de détermination de la cohorte{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="cohorteTypeChange?cohorte_type_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="ccohorteTypeList" class="tableliste">
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
<a href="cohorteTypeChange?cohorte_type_id={$data[lst].cohorte_type_id}">
{$data[lst].cohorte_type_libelle}
</a>
{else}
{$data[lst].cohorte_type_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>