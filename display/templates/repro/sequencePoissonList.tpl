

<table id="csequence" class="tableliste">
<thead>
<tr>
<th>Données générales<br>de reproduction</th>
<th>Nom du poisson</th>
<th>Sexe</th>
<th>Qualité<br>semence</th>
<th>Masse totale des<br>ovocytes</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataPoissons}
<tr>
<td class="center">
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$dataPoissons[lst].poisson_campagne_id}">
<img src="display/images/fish.png" height="25" title="Données de reproduction pour la campagne">
</a>
<td>
<a href="index.php?module=poissonSequenceChange&poisson_sequence_id={$dataPoissons[lst].poisson_sequence_id}&sequence_id={$dataPoissons[lst].sequence_id}">
{$dataPoissons[lst].matricule} {$dataPoissons[lst].prenom} {$dataPoissons[lst].pittag_valeur}
</a>
</td>
<td class="center">{$dataPoissons[lst].sexe_libelle_court}</td>
<td>{$dataPoissons[lst].qualite_semence}</td>
<td class="right">{$dataPoissons[lst].ovocyte_masse}</td>
</tr>
{/section}
</tdata>
</table>
