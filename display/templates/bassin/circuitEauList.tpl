<h2>Circuits d'alimentation en eau</h2>
{include file="bassin/circuitEauSearch.tpl"}
{if $isSearch == 1}
{if $droits["bassinAdmin"] == 1}
<a href="index.php?module=circuitEauChange&circuit_eau_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("ccircuitEauList");
</script>
<table class="tablemulticolonne">
<tr>
<td>
<table id="ccircuitEauList" class="tableliste">
<thead>
<tr>
<th>libellé</th>
{if $droits["bassinGestion"] == 1}
<th>Nouvelles<br>Données</th>
{/if}
<th>Dernière<br>analyse</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$data}
<tr>
<td>
<a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data[lst].circuit_eau_id}">
{$data[lst].circuit_eau_libelle}
</a>
</td>
{if $droits["bassinGestion"] == 1}
<td>
<div class="center">
<a href="index.php?module=analyseEauChange&analyse_eau_id=0&circuit_eau_id={$data[lst].circuit_eau_id}&origine=List">
<img src="display/images/sonde.png" height="20" border="0">
</a>
</div>
</td>
{/if}
<td>
<div class="center">
<a href="index.php?module=circuitEauList&circuit_eau_id={$data[lst].circuit_eau_id}">
<img src="display/images/eprouvette.png" height="20" border="0">
</a>
</div>
</td>
</tr>
{/section}
</tdata>
</table>
</td>
<td>
{if $dataAnalyse.analyse_eau_id > 0}
{include file="bassin/analyseEauDetail.tpl"}
{/if}
</td>
</tr>
</table>
{/if}
