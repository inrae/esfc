<h2{t}Aliments distribués{/t}</h2>
{if $droits["bassinAdmin"] == 1}
<a href="index.php?module=alimentChange&aliment_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("calimentList");
</script>
<table class="table table-bordered table-hover datatable" id="calimentList" class="tableliste">
<thead>
<tr>
<th>libellé</th>
<th>Nom court<br>pour éditions</th>
<th>Type d'aliment</th>
<th>Actuellement<br>utilisé ?</th>
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
<td>
<div class="center">
{if $data[lst].actif == 1}oui{else}non{/if}
</div>
</td>
</tr>
{/section}
</tbody>
</table>