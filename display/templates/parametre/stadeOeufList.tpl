<h2>Stades de maturation des œufs</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=stadeOeufChange&stade_oeuf_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("stadeOeufList");
</script>
<table id="stadeOeufList" class="tableliste">
<thead>
<tr>
<th>libellé</th>
</tr>
</thead>
<tdata>
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
</tdata>
</table>