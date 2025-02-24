<h2>{t}Stades de maturation des œufs{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="stadeOeufChange?stade_oeuf_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="stadeOeufList" class="tableliste">
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
<a href="stadeOeufChange?stade_oeuf_id={$data[lst].stade_oeuf_id}">
{$data[lst].stade_oeuf_libelle}
</a>
{else}
{$data[lst].stade_oeuf_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>