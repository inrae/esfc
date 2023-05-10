<h2{t}Stades de maturation des gonades{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=stadeGonadeChange&stade_gonade_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("stadeGonadeList");
</script>
<table class="table table-bordered table-hover datatable" id="stadeGonadeList" class="tableliste">
<thead>
<tr>
<th>{t}libellé{/t}<th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=stadeGonadeChange&stade_gonade_id={$data[lst].stade_gonade_id}">
{$data[lst].stade_gonade_libelle}
</a>
{else}
{$data[lst].stade_gonade_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>