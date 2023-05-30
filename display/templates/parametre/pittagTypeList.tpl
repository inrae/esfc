<h2>{t}Types de pittag{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=pittagTypeChange&pittag_type_id=0">
Nouveau...
</a>
{/if}
<script>

</script>
<table class="table table-bordered table-hover datatable" id="pittagList" class="tableliste">
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
<a href="index.php?module=pittagTypeChange&pittag_type_id={$data[lst].pittag_type_id}">
{$data[lst].pittag_type_libelle}
</a>
{else}
{$data[lst].pittag_type_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>
