{if $droits["reproGestion"] == 1}
<a href="index.php?module=spermeUtiliseChange&sperme_utilise_id=0&croisement_id={$data.croisement_id}">
Nouveau...
</a>
{/if}
<table id="cspermeUtilise" class="tableliste">
<thead>
<tr>
<th>Poisson</th>
<th>Date de la semence</th>
<th>Date de congélation</th>
<th>Volume utilisé (ml)</th>
<th>Nb de paillettes utilisées</th>
</thead>
<tbody>
{section name=lst loop=$spermesUtilises}
<tr>
<td>{$spermesUtilises[lst].matricule} $spermesUtilises[lst].prenom}</td>
<td>{$spermesUtilises[lst].sperme_date}</td>
<td>{$spermesUtilises[lst].congelation_date}</td>
<td>{$spermesUtilises[lst].volume_utilise}</td>
<td>{$spermesUtilises[lst].nb_paillette_croisement}</td>
</tr>
{/section}
</tbody>
</table>