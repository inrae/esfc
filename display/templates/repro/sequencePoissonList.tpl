<fieldset>
<legend>Poissons rattachés à la séquence</legend>

<table id="csequence" class="tableaffichage">
<thead>
<tr>
<th>Nom du poisson</th>
<th>Sexe</th>
<th>Qualité<br>semence</th>
<th>Masse<br>Ovocyte</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataPoissons}
<tr>
<td>
<a href="index.php?module=poissonSequenceChange&poisson_sequence_id={$dataPoissons[lst].poisson_sequence_id}&sequence_id={$dataPoissons[lst].sequence_id}">
{$dataPoissons[lst].matricule} {$dataPoissons[lst].prenom} {$dataPoissons[lst].pittag_valeur}
</a>
</td>
<td>{$dataPoissons[lst].sexe_libelle_court}</td>
<td>{$dataPoissons[lst].qualite_semence}</td>
<td>{$dataPoissons[lst].ovocyte_masse}</td>
</tr>
{/section}
</tdata>
</table>
</fieldset>