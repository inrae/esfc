<h2>Utilisations des bassins</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=bassinUsageChange&bassin_usage_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cbassinUsageList");
</script>
<table id="cbassinUsageList" class="tableaffichage">
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
<a href="index.php?module=bassinUsageChange&bassin_usage_id={$data[lst].bassin_usage_id}">
{$data[lst].bassin_usage_libelle}
</a>
{else}
{$data[lst].bassin_usage_libelle}
{/if}
</td>
<td>
</tr>
{/section}
</tdata>
</table>