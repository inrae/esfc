{if $droits["reproGestion"] == 1}
<a href="index.php?module=spermeFreezingPlaceChange&sperme_freezing_place_id=0&sperme_congelation_id={$data.sperme_congelation_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Nouvel emplacement de congélation...
</a>
{/if}
<table class="table table-bordered table-hover datatable" id="csperme" class="tableliste">
<thead>
<tr>
<th>{t}Cuve{/t}</th>
<th>{t}Numéro<br>canister{/t}</th>
<th>{t}Position<br>canister{/t}</th>
<th>{t}Nb<br>visiotubes{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$place}
<tr>
<td>
{if  $droits["reproGestion"] == 1}
<a href="index.php?module=spermeFreezingPlaceChange&sperme_freezing_place_id={$place[lst].sperme_freezing_place_id}&sperme_congelation_id={$data.sperme_congelation_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
{$place[lst].cuve_libelle}
</a>
{else}
{$place[lst].cuve_libelle}
{/if}
</td>
<td class="center">
{$place[lst].canister_numero}</td>
<td class="center">{if $place[lst].position_canister == 1}bas{/if}
{if $place[lst].position_canister == 2}haut{/if}
</td>
<td class="center">{$place[lst].nb_visiotube}</td>
</tr>
{/section}
</tbody>
</table>



