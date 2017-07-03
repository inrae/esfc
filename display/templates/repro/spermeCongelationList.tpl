{if $droits["reproGestion"] == 1}
<a href="index.php?module=spermeCongelationChange&sperme_congelation_id=0&sperme_id={$data.sperme_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Nouvelle congélation de sperme...
</a>
{/if}
<table id="csperme" class="tableliste">
<thead>
<tr>
<th>Date<br>de congélation</th>
<th>Volume<br>total (ml)</th>
<th>Volume<br>sperme (ml)</th>
<th>Nb<br>paillettes</th>
<th>Nb<br>visiotubes</th>
<th>Dilueur</th>
<th>Conservateur</th>
<th>Remarque</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$congelation}
<tr>
<td>
{if  $droits["reproGestion"] == 1}
<a href="index.php?module=spermeCongelationChange&sperme_congelation_id={$congelation[lst].sperme_congelation_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
{$congelation[lst].congelation_date}
</a>
{else}
{$congelation[lst].congelation_date}
{/if}
</td>
<td class="center">
{$congelation[lst].congelation_volume}</td>
<td class="center">{$congelation[lst].volume_sperme}</td>
<td class="center">{$congelation[lst].nb_paillette}</td>
<td class="center">{$congelation[lst].nb_visiotube}</td>
<td>{$congelation[lst].sperme_dilueur_libelle} : {$congelation[lst].volume_dilueur} ml</td>
<td>{$congelation[lst].sperme_conservateur_libelle} : {$congelation[lst].volume_conservateur} ml</td>
<td >{$congelation[lst].sperme_congelation_commentaire}</td>
</tr>
{/section}
</tbody>
</table>