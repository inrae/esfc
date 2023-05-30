<h2>{t}Stades de maturation des œufs{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=stadeOeufChange&stade_oeuf_id=0">
Nouveau...
</a>
{/if}
<script>

</script>
<table class="table table-bordered table-hover datatable" id="stadeOeufList" class="tableliste">
<thead>
<tr>
<th>{t}libellé{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=stadeOeufChange&stade_oeuf_id={$data[lst].stade_oeuf_id}">
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