<h2>{t}Méthodes de détermination du sexe{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=genderMethodeChange&gender_methode_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable" id="cgenderMethodeList" class="tableliste">
<thead>
<tr>
<th>{t}libellé{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=genderMethodeChange&gender_methode_id={$data[lst].gender_methode_id}">
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