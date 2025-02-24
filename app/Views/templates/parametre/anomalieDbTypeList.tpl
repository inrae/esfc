<h2>{t}Types d'anomalie_dbs{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="anomalieDbTypeChange?anomalie_db_type_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="canomalie_dbTypeList" class="tableliste">
<thead>
<tr>
{if $rights["paramAdmin"] == 1}
<th>{t}Modifier{/t}</th>
{/if}
<th>{t}libellé{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
{if $rights["paramAdmin"] == 1}
<td style="text-align:center;">
<a href="anomalieDbTypeChange?anomalie_db_type_id={$data[lst].anomalie_db_type_id}">
<img src="display/images/edit.gif" height="20">
</a>
</td>
{/if}
<td>
{$data[lst].anomalie_db_type_libelle}
</td>
</tr>
{/section}
</tbody>
</table>
