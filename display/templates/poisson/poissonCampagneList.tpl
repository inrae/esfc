
<table class="table table-bordered table-hover datatable" id="creproList" data-order='[[0,"desc"]]'>
<thead>
<tr>
<th>{t}Année{/t}</th>
<th>{t}Statut{/t}</th>
<th>{t}masse{/t}</th>
<th>{t}Tx croissance journalier{/t}</th>
<th>{t}Specific growth rate{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataRepro}
<tr>
<td>
{if $droits.reproConsult==1}
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$dataRepro[lst].poisson_campagne_id}">
{$dataRepro[lst].annee}
</a>
{else}
{$dataRepro[lst].annee}
{/if}
</td>
<td>
{$dataRepro[lst].repro_statut_libelle}
</td>
<td class="right">{$dataRepro[lst].masse}</td>
<td class="{if $dataRepro[lst].tx_croissance_journalier > 0.02}green {/if}right">{$dataRepro[lst].tx_croissance_journalier}</td>
<td class="{if $dataRepro[lst].specific_growth_rate > 0.02}green {/if}right">{$dataRepro[lst].specific_growth_rate}</td>
</tr>
{/section}
</tbody>
</table>
