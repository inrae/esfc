<h2{t}Utilisations des bassins{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=bassinUsageChange&bassin_usage_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cbassinUsageList");
</script>
<table class="table table-bordered table-hover datatable" id="cbassinUsageList" class="tableliste">
<thead>
<tr>
<th>libellé</th>
<th>Catégorie<br>d'alimentation</th>
</tr>
</thead>
<tbody>
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
{$data[lst].categorie_libelle}
</td>
</tr>
{/section}
</tbody>
</table>