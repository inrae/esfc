{if $droits.reproGestion == 1}
<a href="index.php?module=poissonSequenceChange&poisson_sequence_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Rattacher une nouvelle séquence...
</a>
{/if}
<table class="table table-bordered table-hover datatable" id="csequence" class="tableliste">
<thead>
<tr>
<th>{t}Date<br>début{/t}</th>
<th>{t}Nom{/t}</th>
<th>{t}Masse des<br>ovocytes{/t}</th>
<th>{t}Date d'expulsion{/t}</th>
<th>{t}Statut du poisson<br>pour la séquence{/t}</th>
</tr>
</thead>
<tbody>
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
<td>{$dataSequence[lst].ovocyte_expulsion_date}</td>
<td>{$dataSequence[lst].ps_statut_libelle}</td>
</tr>
{/section}
</tbody>
</table>
<br>