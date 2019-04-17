{if $droits["reproGestion"] == 1}
<a href="index.php?module=spermeFreezingMeasureChange&sperme_freezing_measure_id=0&sperme_congelation_id={$data.sperme_congelation_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Nouvelle mesure de température...
</a>
{/if}
<table id="csperme" class="tableliste">
<thead>
<tr>
<th>Date/heure</th>
<th>Température</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$freezingMeasure}
<tr>
<td>
{if  $droits["reproGestion"] == 1}
<a href="index.php?module=spermeFreezingMeasureChange&sperme_freezing_measure_id={$freezingMeasure[lst].sperme_freezing_measure_id}&sperme_congelation_id={$data.sperme_congelation_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
{$freezingMeasure[lst].measure_date}
</a>
{else}
{$freezingMeasure[lst].measure_date}
{/if}
</td>
<td class="center">
{$freezingMeasure[lst].measure_temp}</td>
</tr>
{/section}
</tbody>
</table>
