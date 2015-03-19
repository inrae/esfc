{if $droits.reproGestion == 1}
<a href="index.php?module=dosageSanguinChange&dosage_sanguin_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Nouvelle analyse...
</a>
{/if}
<table id="csanguin" class="tableliste">
<thead>
<tr>
<th>Date</th>
<th>Taux E2</th>
<th>Taux<br>calcium</th>
<th>Commentaire</th>
</tr>
</thead>
<tdata>
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
<td>{$dataSanguin[lst].commentaire}</td>
</tr>
{/section}
</tdata>
</table>