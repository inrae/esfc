<script>
setDataTables("creproList");
</script>
<table class="table table-bordered table-hover datatable" id="creproList" class="tableliste">
<thead>
<tr>
<th>Année</th>
<th>Statut</th>
<th>masse</th>
<th>Tx croissance<br>journalier</th>
<th>Specific<br>growth rate</th>
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
<td>{$dataRepro[lst].masse}</td>
<td class="{if $dataRepro[lst].tx_croissance_journalier > 0.02}etat3{else}right{/if}">{$dataRepro[lst].tx_croissance_journalier}</td>
<td class="{if $dataRepro[lst].specific_growth_rate > 0.02}etat3{else}right{/if}">{$dataRepro[lst].specific_growth_rate}</td>
</tr>
{/section}
</tbody>
</table>
