{if $droits["reproGestion"] == 1}
<a href="index.php?module=spermeChange&sperme_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Nouveau prélèvement...
</a>
{/if}
<table class="table table-bordered table-hover datatable" id="csperme" class="tableliste">
<thead>
<tr>
<th>{t}Date/heure<br>du prélèvement{/t}</th>
<th>{t}Séquence{/t}</th>
<th>{t}Aspect / Qualité estimée{/t}</th>
<th>{t}Motilité<br>initiale{/t}</th>
<th>{t}Tx survie<br>initial{/t}</th>
<th>{t}Motilité<br>60"{/t}</th>
<th>{t}Tx survie<br>60"{/t}</th>
<th>{t}Temps survie<br>à 5% (en sec.){/t}</th>
<th>{t}pH{/t}</th>
<th>{t}Date<br>mesure{/t}</th>
<th>{t}Date<br>congélation{/t}</th>
<th>{t}Remarque{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$spermes}
<tr>
<td>
{if  $droits["reproGestion"] == 1}
<a href="index.php?module=spermeChange&sperme_id={$spermes[lst].sperme_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
{$spermes[lst].sperme_date}
</a>
{else}
{$spermes[lst].sperme_date}
{/if}
</td>
<td>{$spermes[lst].sequence_nom}</td>
<td>
{$spermes[lst].sperme_aspect_libelle} / 
{$spermes[lst].sperme_qualite_libelle}</td>
<td class="center">{$spermes[lst].motilite_initiale}</td>
<td class="right">{$spermes[lst].tx_survie_initial}</td>
<td class="center">{$spermes[lst].motilite_60}</td>
<td class="right">{$spermes[lst].tx_survie_60}</td>
<td class="right">{$spermes[lst].temps_survie}</td>
<td class="right">{$spermes[lst].sperme_ph}</td>
<td>{$spermes[lst].sperme_mesure_date}</td>
<td>{$spermes[lst].congelation_dates}</td>
<td>{$spermes[lst].sperme_commentaire}</td>
</tr>
{/section}
</tbody>
</table>