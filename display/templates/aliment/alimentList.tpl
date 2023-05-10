<h2{t}Aliments distribués{/t}</h2>
{if $droits["bassinAdmin"] == 1}
<a href="index.php?module=alimentChange&aliment_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable" id="calimentList" >
<thead>
<tr>
<th>{t}libellé{/t}<th>
<th>{t}Nom court pour éditions{/t}<th>
<th>{t}Type d'aliment{/t}<th>
<th>{t}Actuellement utilisé ?{/t}<th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["bassinAdmin"] == 1}
<a href="index.php?module=alimentChange&aliment_id={$data[lst].aliment_id}">
{$data[lst].aliment_libelle}
</a>
{else}
{$data[lst].aliment_libelle}
{/if}
</td>
<td>{$data[lst].aliment_libelle_court}</td>
<td>
{$data[lst].aliment_type_libelle}
</td>
<td class="center">
{if $data[lst].actif == 1}oui{else}non{/if}
</td>
</tr>
{/section}
</tbody>
</table>