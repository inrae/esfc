<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="csanguin"  data-order='[[1,"desc"]]' data-tabicon="okreproduction">
<thead>
<tr>
<th>{t}Événement associé{/t}</th>
<th>{t}Date{/t}</th>
<th>{t}Taux E2{/t}</th>
<th>{t}Taux calcium{/t}</th>
<th>{t}Taux hématocrite{/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataDosageSanguin}
<tr>
<td>
{if $rights["poissonGestion"]==1||$rights.reproGestion==1}
<a href="evenementChange?poisson_id={$dataDosageSanguin[lst].poisson_id}&evenement_id={$dataDosageSanguin[lst].evenement_id}">
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