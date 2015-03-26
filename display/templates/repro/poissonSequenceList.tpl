{if $droits.reproGestion == 1}
<a href="index.php?module=poissonSequenceChange&poisson_sequence_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Rattacher une nouvelle séquence...
</a>
{/if}
<table id="csequence" class="tableliste">
<thead>
<tr>
<th>Date<br>début</th>
<th>Nom</th>
<th>Masse<br>ovocyte</th>
<th>Statut du poisson<br>pour la séquence</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataSequence}
<tr>
<td>
<a href="index.php?module=poissonSequenceChange&poisson_sequence_id={$dataSequence[lst].poisson_sequence_id}&sequence_id={$dataSequence[lst].sequence_id}">
{$dataSequence[lst].sequence_date_debut}
</a>
</td>
<td>
<a href="index.php?module=poissonSequenceChange&poisson_sequence_id={$dataSequence[lst].poisson_sequence_id}&sequence_id={$dataSequence[lst].sequence_id}">
{$dataSequence[lst].sequence_nom}
</a></td>
<td class="right">{$dataSequence[lst].ovocyte_masse}</td>
<td>{$dataSequence[lst].ps_statut_libelle}</td>
</tr>
{/section}
</tdata>
</table>
<br>