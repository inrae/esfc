<h2>Zones d'implantation des bassins</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=bassinZoneChange&bassin_zone_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cbassinZoneList");
</script>
<table id="cbassinZoneList" class="tableaffichage">
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
<a href="index.php?module=bassinZoneChange&bassin_zone_id={$data[lst].bassin_zone_id}">
{$data[lst].bassin_zone_libelle}
</a>
{else}
{$data[lst].bassin_zone_libelle}
{/if}
</td>
<td>
</tr>
{/section}
</tdata>
</table>