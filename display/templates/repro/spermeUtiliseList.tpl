{if $droits["reproGestion"] == 1}
<a href="index.php?module=spermeUtiliseChange&sperme_utilise_id=0&croisement_id={$data.croisement_id}">
Nouveau...
</a>
{/if}
<table class="table table-bordered table-hover datatable" id="cspermeUtilise" class="tableliste">
<thead>
<tr>
<th>{t}Poisson{/t}</th>
<th>{t}Date de la semence{/t}</th>
<th>{t}Date de congélation{/t}</th>
<th>{t}Volume utilisé (ml){/t}</th>
<th>{t}Nb de paillettes utilisées{/t}</th>
</thead>
<tbody>
{section name=lst loop=$spermesUtilises}
<tr>
<td>
{if $droits["reproGestion"] == 1}
<a href="index.php?module=spermeUtiliseChange&sperme_utilise_id={$spermesUtilises[lst].sperme_utilise_id}&croisement_id={$data.croisement_id}">
{$spermesUtilises[lst].matricule} {$spermesUtilises[lst].prenom}
</a>
{else}
{$spermesUtilises[lst].matricule} {$spermesUtilises[lst].prenom}
{/if}
</td>
<td>{$spermesUtilises[lst].sperme_date}</td>
<td>{$spermesUtilises[lst].congelation_date}</td>
<td>{$spermesUtilises[lst].volume_utilise}</td>
<td>{$spermesUtilises[lst].nb_paillette_croisement}</td>
</tr>
{/section}
</tbody>
</table>