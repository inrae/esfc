<script>
setDataTables("cgender_selectionList");
</script>
<table class="table table-bordered table-hover datatable" id="cgender_selectionList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Date de<br>détermination</th>
<th>Méthode</th>
<th>Sexe</th>
<th>Commentaire</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataGender}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataGender[lst].poisson_id}&evenement_id={$dataGender[lst].evenement_id}">
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