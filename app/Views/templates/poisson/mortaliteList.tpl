
<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="cmortaliteList" data-order='[[2,"desc"]]'  data-tabicon="oksortie">
<thead>
<tr>
<th>{t}Événement associé{/t}</th>
<th>{t}Type de mortalite{/t}</th>
<th>{t}Date{/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataMortalite}
<tr>
<td>
{if $rights["poissonGestion"]==1}
<a href="evenementChange?poisson_id={$dataMortalite[lst].poisson_id}&evenement_id={$dataMortalite[lst].evenement_id}">
{$dataMortalite[lst].evenement_type_libelle}
</a>
{else}
{$dataMortalite[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataMortalite[lst].mortalite_type_libelle}</td>
<td>{$dataMortalite[lst].mortalite_date}</td>
<td>{$dataMortalite[lst].mortalite_commentaire}</td>
</tr>
{/section}
</tbody>
</table>