
<table class="table table-bordered table-hover datatable ok" id="cevenementList"  data-order='[[1,"desc"]]'  data-tabicon="okevent">
<thead>
<tr>
<th>{t}Nature{/t}</th>
<th>{t}Date{/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataEvenement}
<tr>
<td>
{if $rights["poissonGestion"]==1}
<a href="evenementChange?poisson_id={$dataEvenement[lst].poisson_id}&evenement_id={$dataEvenement[lst].evenement_id}">
{$dataEvenement[lst].evenement_type_libelle}
</a>
{else}
{$dataEvenement[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataEvenement[lst].evenement_date}</td>
<td>{$dataEvenement[lst].evenement_commentaire}</td>
</tr>
{/section}
</tbody>
</table>