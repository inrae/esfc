<h2>Liste des sites</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=siteChange&site_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cbassinUsageList");
</script>
<table id="csiteList" class="tableliste">
<thead>
<tr>
<th>Nom du site</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=siteChange&site_id={$data[lst].site_id}">
{$data[lst].site_name}
</a>
{else}
{$data[lst].site_name}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>