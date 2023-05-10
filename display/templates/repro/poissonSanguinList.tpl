{if $droits.reproGestion == 1}
<a href="index.php?module=dosageSanguinChange&dosage_sanguin_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Nouvelle analyse...
</a>
{/if}
<table class="table table-bordered table-hover datatable" id="csanguin" class="tableliste">
<thead>
<tr>
<th>{t}Date{/t}</th>
<th>{t}Taux E2{/t}</th>
<th>{t}Taux<br>calcium{/t}</th>
<th>{t}Taux<br>hématocrite{/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataSanguin}
<tr>
<td>
{if $droits.reproGestion == 1}
<a href="index.php?module=dosageSanguinChange&dosage_sanguin_id={$dataSanguin[lst].dosage_sanguin_id}">
{$dataSanguin[lst].dosage_sanguin_date}
</a>
{else}
{$dataSanguin[lst].dosage_sanguin_date}
{/if}
</td>
<td class="right">{$dataSanguin[lst].tx_e2}{$dataSanguin[lst].tx_e2_texte}</td>
<td class="right">{$dataSanguin[lst].tx_calcium}</td>
<td class="right">{$dataSanguin[lst].tx_hematocrite}</td>
<td>{$dataSanguin[lst].dosage_sanguin_commentaire}</td>
</tr>
{/section}
</tbody>
</table>