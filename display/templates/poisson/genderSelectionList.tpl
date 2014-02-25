<script>
setDataTables("cgender_selectionList");
</script>
<table id="cgender_selectionList" class="tableaffichage">
<thead>
<tr>
<th>Date de<br>détermination</th>
<th>Méthode</th>
<th>Sexe</th>
<th>Commentaire</th>
<th>Événement associé</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataGender}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=gender_selectionChange&poisson_id={$dataGender[lst].poisson_id}&gender_selection_id={$dataGender[lst].gender_selection_id}">
{$dataGender[lst].gender_selection_date}
</a>
{else}
{$dataGender[lst].gender_selection_date}
{/if}
</td>
<td>{$dataGender[lst].gender_methode_libelle}</td>
<td>{$dataGender[lst].sexe_libelle_court}</td>
<td>{$dataGender[lst].gender_selection_commentaire}</td>
<td>{$dataGender[lst].evenement_type_libelle}</td>
</tr>
{/section}
</tdata>
</table>