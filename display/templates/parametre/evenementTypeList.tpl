<h2>{t}Types d'événements{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=evenementTypeChange&evenement_type_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable" id="cevenementTypeList" class="tableliste">
<thead>
<tr>
<th>{t}libellé{/t}</th>
<th>{t}Actif ?{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=evenementTypeChange&evenement_type_id={$data[lst].evenement_type_id}">
{$data[lst].evenement_type_libelle}
</a>
{else}
{$data[lst].evenement_type_libelle}
{/if}
</td>
<td>
{if $data[lst].evenement_type_actif == 1}oui
{elseif $data[lst].evenement_type_actif == 0}non
{/if}
</td>
</tr>
{/section}
</tbody>
</table>