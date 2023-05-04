{if $droits.reproGestion == 1}
<a href="index.php?module=biopsieChange&biopsie_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Nouvelle biopsie...
</a>
{/if}
<table class="table table-bordered table-hover datatable" id="cbiopsie" class="tableliste">
<thead>
<tr>
<th>Date</th>
<th>Diam. moyen<br>(écart-type)</th>
<th>Taux<br>OPI</th>
<th>Taux color<br>normale</th>
<th>Taux<br>éclatement</th>
<th>Ringer<br>T50</th>
<th>Ringer<br>Tmax</th>
<th>Ringer<br>commentaire</th>
<th>Leib<br>T50</th>
<th>Leib<br>Tmax</th>
<th>Leib<br>commentaire</th>
<th>Commentaire<br>général</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataBiopsie}
<tr>
<td>
{if $droits.reproGestion == 1}
<a href="index.php?module=biopsieChange&biopsie_id={$dataBiopsie[lst].biopsie_id}">
{$dataBiopsie[lst].biopsie_date}
</a>
{else}
{$dataBiopsie[lst].biopsie_date}
{/if}
</td>
<td>
{$dataBiopsie[lst].diam_moyen}
{if strlen($dataBiopsie[lst].diametre_ecart_type) > 0}
( {$dataBiopsie[lst].diametre_ecart_type})
{/if}
{if strlen($dataBiopsie[lst].biopsie_technique_calcul_libelle) > 0}
<br>
{$dataBiopsie[lst].biopsie_technique_calcul_libelle}
{/if}
</td>
<td class="right">{$dataBiopsie[lst].tx_opi}</td>
<td class="right">{$dataBiopsie[lst].tx_coloration_normal}</td>
<td class="right">{$dataBiopsie[lst].tx_eclatement}</td>
<td class="center">{$dataBiopsie[lst].ringer_t50}</td>
<td>
{$dataBiopsie[lst].ringer_tx_max}
{if strlen($dataBiopsie[lst].ringer_duree) > 0}
 en {$dataBiopsie[lst].ringer_duree}
 {/if}
</td>
<td >{$dataBiopsie[lst].ringer_commentaire}</td>
<td class="center">{$dataBiopsie[lst].leibovitz_t50}</td>
<td>
{$dataBiopsie[lst].leibovitz_tx_max}
{if strlen($dataBiopsie[lst].leibovitz_duree) > 0}
 en {$dataBiopsie[lst].leibovitz_duree}
 {/if}
</td>
<td >{$dataBiopsie[lst].leibovitz_commentaire}</td>
<td >{$dataBiopsie[lst].biopsie_commentaire}</td>
</tr>
{/section}
</tbody>
</table>
