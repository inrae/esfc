<script>
setDataTables("cventilationList");
</script>
{if $droits.poissonGestion==1 || $droits.reproGestion == 1}
<a href="index.php?module=ventilationChange&poisson_id={$dataPoisson.poisson_id}&ventilation_id=0&poisson_campagne_id={$poisson_campagne_id}">Nouvelle mesure...</a>
{/if}
<table id="cventilationList" class="tableliste">
<thead>
<tr>
<th>Date</th>
<th>Nombre de battements</th>
<th>Commentaire</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataVentilation}
<tr>
<td>
{if $droits.poissonGestion==1 || $droits.reproGestion == 1}
<a href="index.php?module=ventilationChange&poisson_id={$dataVentilation[lst].poisson_id}&ventilation_id={$dataVentilation[lst].ventilation_id}&poisson_campagne_id={$poisson_campagne_id}">
{$dataVentilation[lst].ventilation_date}
</a>
{else}
{$dataVentilation[lst].ventilation_date}
{/if}
</td>
<td>{$dataVentilation[lst].battement_nb}</td>
<td>{$dataVentilation[lst].ventilation_commentaire}</td>
</tr>
{/section}
</tbody>
</table>