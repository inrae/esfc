
<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="ccohorteList" data-order='[[3,"desc"]]'  data-tabicon="okgenetique">
<thead>
<tr>
<th>{t}Événement associé{/t}</th>
<th>{t}Type de détermination{/t}</th>
<th>{t}Cohorte déterminée{/t}</th>
<th>{t}Date{/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataCohorte}
<tr>
<td>
{if $rights["poissonGestion"]==1}
<a href="evenementChange?poisson_id={$dataCohorte[lst].poisson_id}&evenement_id={$dataCohorte[lst].evenement_id}">
{$dataCohorte[lst].evenement_type_libelle}
</a>
{else}
{$dataCohorte[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataCohorte[lst].cohorte_type_libelle}</td>
<td>{$dataCohorte[lst].cohorte_determination}</td>
<td>{$dataCohorte[lst].cohorte_date}</td>
<td>{$dataCohorte[lst].cohorte_commentaire}</td>
</tr>
{/section}
</tbody>
</table>