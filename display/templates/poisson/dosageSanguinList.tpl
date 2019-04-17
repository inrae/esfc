<table id="csanguin" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Date</th>
<th>Taux E2</th>
<th>Taux<br>calcium</th>
<th>Taux<br>hématocrite</th>
<th>Commentaire</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataDosageSanguin}
<tr>
<td>
{if $droits["poissonGestion"]==1||$droits.reproGestion==1}
<a href="index.php?module=evenementChange&poisson_id={$dataDosageSanguin[lst].poisson_id}&evenement_id={$dataDosageSanguin[lst].evenement_id}">
{$dataDosageSanguin[lst].evenement_type_libelle}
</a>
{else}
{$dataDosageSanguin[lst].evenement_type_libelle}
{/if}
</td>
<td>
{$dataDosageSanguin[lst].dosage_sanguin_date}
</td>
<td class="right">{$dataDosageSanguin[lst].tx_e2}{$dataDosageSanguin[lst].tx_e2_texte}</td>
<td class="right">{$dataDosageSanguin[lst].tx_calcium}</td>
<td class="right">{$dataDosageSanguin[lst].tx_hematocrite}</td>
<td>{$dataDosageSanguin[lst].dosage_sanguin_commentaire}</td>
</tr>
{/section}
</tbody>
</table>