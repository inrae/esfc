{if $droits["reproGestion"] == 1}
<a href="index.php?module=spermeCongelationChange&sperme_congelation_id=0&sperme_id={$data.sperme_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Nouvelle congélation de sperme...
</a>
{/if}
<table class="table table-bordered table-hover datatable" id="csperme" class="tableliste">
<thead>
<tr>
<th>{t}Date<br>de congélation{/t}</th>
<th>{t}Volume<br>total (ml){/t}</th>
<th>{t}Volume<br>sperme (ml){/t}</th>
<th>{t}Nb<br>paillettes{/t}</th>
<th>{t}Nb<br>visiotubes{/t}</th>
<th>{t}Dilueur{/t}</th>
<th>{t}Conservateur{/t}</th>
<th>{t}Nb<br>paillettes<br>utilisées{/t}</th>
<th>{t}Remarque{/t}</th>
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
<td>{$congelation[lst].nb_paillettes_utilisees}</td>
<td >{$congelation[lst].sperme_congelation_commentaire}</td>
</tr>
{/section}
</tbody>
</table>