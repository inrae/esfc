
<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="cgender_selectionList"  data-order='[[1,"desc"]]'  data-tabicon="okgenetique">
<thead>
<tr>
<th>{t}Événement associé{/t}</th>
<th>{t}Date de détermination{/t}</th>
<th>{t}Méthode{/t}</th>
<th>{t}Sexe{/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataGender}
<tr>
<td>
{if $rights["poissonGestion"]==1}
<a href="evenementChange?poisson_id={$dataGender[lst].poisson_id}&evenement_id={$dataGender[lst].evenement_id}">
{$dataGender[lst].evenement_type_libelle}
</a>
{else}
{$dataGender[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataGender[lst].gender_selection_date}</td>
<td>{$dataGender[lst].gender_methode_libelle}</td>
<td>{$dataGender[lst].sexe_libelle_court}</td>
<td>{$dataGender[lst].gender_selection_commentaire}</td>
</tr>
{/section}
</tbody>
</table>