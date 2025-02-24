<h2>{t}Méthodes de détermination du sexe{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="genderMethodeChange?gender_methode_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cgenderMethodeList" class="tableliste">
<thead>
<tr>
<th>{t}libellé{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $rights["paramAdmin"] == 1}
<a href="genderMethodeChange?gender_methode_id={$data[lst].gender_methode_id}">
{$data[lst].gender_methode_libelle}
</a>
{else}
{$data[lst].gender_methode_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>