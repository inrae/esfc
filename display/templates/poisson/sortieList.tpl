
<table class="table table-bordered table-hover datatable-nopaging-nosearch" id="csortieList" >
<thead>
<tr>
<th>{t}Événement associé{/t}</th>
<th>{t}Lieu{/t}</th>
<th>{t}Date{/t}</th>
<th>{t}Sevrage/Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataSortie}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataSortie[lst].poisson_id}&evenement_id={$dataSortie[lst].evenement_id}">
{$dataSortie[lst].evenement_type_libelle}
</a>
{else}
{$dataSortie[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataSortie[lst].localisation}</td>
<td>{$dataSortie[lst].sortie_date}</td>
<td>
{$dataSortie[lst].sevre}
{if strlen($dataSortie[lst].sevre) > 0 && strlen($dataSortie[lst].sortie_commentaire) > 0}
<br>
{/if}
{$dataSortie[lst].sortie_commentaire}</td>
</tr>
{/section}
</tbody>
</table>