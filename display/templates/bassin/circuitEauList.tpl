<h2>Circuits d'alimentation en eau</h2>
{if $droits["admin"] == 1}
<a href="index.php?module=circuitEauChange&circuit_eau_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("ccircuitEauList");
</script>
<table id="ccircuitEauList" class="tableaffichage">
<thead>
<tr>
<th>libellé</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["admin"] == 1}
<a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data[lst].circuit_eau_id}">
{$data[lst].circuit_eau_libelle}
</a>
{else}
{$data[lst].circuit_eau_libelle}
{/if}
</td>
</tr>
{/section}
</tdata>
</table>