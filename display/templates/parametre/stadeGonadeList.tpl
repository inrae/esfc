<h2>Stades de maturation des gonades</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=stadeGonadeChange&stade_gonade_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("stadeGonadeList");
</script>
<table id="stadeGonadeList" class="tableliste">
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
<a href="index.php?module=stadeGonadeChange&stade_gonade_id={$data[lst].stade_gonade_id}">
{$data[lst].stade_gonade_libelle}
</a>
{else}
{$data[lst].stade_gonade_libelle}
{/if}
</td>
</tr>
{/section}
</tdata>
</table>