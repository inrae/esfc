<table id="cpsEvenement" class="tableaffichage">
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
<td>{$dataPsEvenement[lst].sequence_nom}</td>
<td>{$dataPsEvenement[lst].ps_date}</td>
<td>{$dataPsEvenement[lst].ps_libelle}</td>
<td>{$dataPsEvenement[lst].ps_commentaire}</td>
</tr>
{/section}
</tdata>
</table>
