<h2{t}Circuits d'alimentation en eau{/t}</h2>
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
<table class="table table-bordered table-hover datatable" class="tablemulticolonne">
<tr>
<td>
<table class="table table-bordered table-hover datatable" id="ccircuitEauList" class="tableliste">
<thead>
<tr>
<th>libellé</th>
<th>En service</th>
{if $droits["bassinGestion"] == 1}
<th>Nouvelles<br>Données</th>
{/if}
<th>Dernière<br>analyse</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
<a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data[lst].circuit_eau_id}">
{$data[lst].circuit_eau_libelle}
</a>
</td>
<td class="center">
{if $data[lst].circuit_eau_actif == 1}oui{else}non{/if}
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
</tbody>
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
