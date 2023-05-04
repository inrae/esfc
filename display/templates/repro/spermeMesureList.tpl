{if $droits.reproGestion == 1}
<a href="index.php?module=spermeMesureChange&sperme_mesure_id=0&sperme_id={$data.sperme_id}&sperme_congelation_id={$data.sperme_congelation_id}">Nouvelle analyse...</a>
{/if}
<table class="table table-bordered table-hover datatable" class="tableaffichage">
<thead>
<tr>
<th>Date</th>
<th>Qualité</th>
<th>Motilité<br>initiale</th>
<th>Tx survie<br>initial</th>
<th>Motilité 60"</th>
<th>Tx survie<br>60"</th>
<th>Temps<br>survie</th>
<th>pH</th>
<th>Nbre paillettes<br>utilisées</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataMesure}
<tr>
<td>
{if $droits.reproGestion == 1}
<a href="index.php?module=spermeMesureChange&sperme_mesure_id={$dataMesure[lst].sperme_mesure_id}&sperme_id={$data.sperme_id}&sperme_congelation_id={$dataMesure[lst].sperme_congelation_id}">
{$dataMesure[lst].sperme_mesure_date}
</a>
{else}
{$dataMesure[lst].sperme_mesure_date}
{/if}
</td>
<td>{$dataMesure[lst].sperme_qualite_libelle}</td>
<td class="center">{$dataMesure[lst].motilite_initiale}</td>
<td class="center">{$dataMesure[lst].tx_survie_initial}</td>
<td class="center">{$dataMesure[lst].motilite_60}</td>
<td class="center">{$dataMesure[lst].tx_survie_60}</td>
<td class="center">{$dataMesure[lst].temps_survie}</td>
<td class="center">{$dataMesure[lst].sperme_ph}</td>
<td class="center">{$dataMesure[lst].nb_paillette_utilise}</td>
</tr>
{/section}
</tbody>
</table>