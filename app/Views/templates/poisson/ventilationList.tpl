
{if $rights.poissonGestion==1 || $rights.reproGestion == 1}
<a href="ventilationChange?poisson_id={$dataPoisson.poisson_id}&ventilation_id=0&poisson_campagne_id={$poisson_campagne_id}">Nouvelle mesure...</a>
{/if}
<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="cventilationList"  data-order='[[0,"desc"]]' data-tabicon="okreproduction">
<thead>
<tr>
<th>{t}Date{/t}</th>
<th>{t}Nombre de battements/s{/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataVentilation}
<tr>
<td>
{if $rights.poissonGestion==1 || $rights.reproGestion == 1}
<a href="ventilationChange?poisson_id={$dataVentilation[lst].poisson_id}&ventilation_id={$dataVentilation[lst].ventilation_id}&poisson_campagne_id={$poisson_campagne_id}">
{$dataVentilation[lst].ventilation_date}
</a>
{else}
{$dataVentilation[lst].ventilation_date}
{/if}
</td>
<td class="right">{$dataVentilation[lst].battement_nb}</td>
<td>{$dataVentilation[lst].ventilation_commentaire}</td>
</tr>
{/section}
</tbody>
</table>