<table id="cpsEvenement" class="tableliste">
<thead>
<tr>
<th>Séquence</th>
<th>Date</th>
<th>Libellé</th>
<th>Commentaire</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataPsEvenement}
<tr>
<td>
<a href="index.php?module=poissonSequenceChange&poisson_sequence_id={$dataPsEvenement[lst].poisson_sequence_id}&sequence_id={$dataSequence[lst].sequence_id}">
{$dataPsEvenement[lst].sequence_nom}
</a>
</td>
<td>{$dataPsEvenement[lst].ps_datetime}</td>
<td>{$dataPsEvenement[lst].ps_libelle}</td>
<td>{$dataPsEvenement[lst].ps_commentaire}</td>
</tr>
{/section}
</tdata>
</table>
