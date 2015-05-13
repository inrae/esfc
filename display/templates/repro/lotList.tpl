
{if $droits.reproGestion == 1}
<a href="index.php?module=lotChange&lot_id=0">Nouveau lot de larves...</a>
{/if}
<table id="clotlist" class="tableliste">
<thead>
<tr>
<th>Nom du lot</th>
<th>Parents</th>
<th>Séquence</th>
<th>Bassin</th>
<th>Date<br>d'éclosion</th>
<th>Age<br>(jours)</th>
<th>Nbre de larves<br>initial</th>
<th>Nbre de larves<br>comptées</th>
<th>Marque VIE</th>
<th>Date de marquage<br>VIE</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$lots}
<tr>
<td>
<a href="index.php?module=lotDisplay&lot_id={$lots[lst].lot_id}">
{$lots[lst].lot_nom}
</a>
</td>
<td>{$lots[lst].parents}</td>
<td class="center">
<a href="index.php?module=sequenceDisplay&sequence_id={$lots[lst].sequence_id}">
{$lots[lst].sequence_nom}
&nbsp;
{$lots[lst].croisement_nom}
</a>
</td>
<td>{$lots[lst].bassin_nom}</td>
<td>{$lots[lst].eclosion_date}</td>
<td class="center">{$lots[lst].age}</td>
<td class="right">{$lots[lst].nb_larve_initial}</td>
<td class="right">{$lots[lst].nb_larve_compte}</td>
<td>
{if $lots[lst].vie_modele_id > 0}
{$lots[lst].couleur}, {$lots[lst].vie_implantation_libelle}, {$lots[lst].vie_implantation_libelle2}
{/if}
</td>
<td>{$lots[lst].vie_date_marquage}</td>
</tr>
{/section}
</tbody>
</table>
