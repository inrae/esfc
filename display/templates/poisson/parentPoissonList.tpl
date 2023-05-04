<script>
setDataTables("cparentList");
</script>
<table class="table table-bordered table-hover datatable" id="cparentList" class="tableliste">
<thead>
<tr>
{if $droits.poissonGestion == 1}
<th>Modif</th>
{/if}
<th>Parent</th>
<th>Sexe</th>
<th>Cohorte</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataParent}
<tr>
{if $droits.poissonGestion == 1}
<td>
<div class="center">
<a href="index.php?module=parentPoissonChange&poisson_id={$dataPoisson.poisson_id}&parent_poisson_id={$dataParent[lst].parent_poisson_id}">
<img src="display/images/edit.gif" height="20">
</a>
</div>
</td>
{/if}
<td>
<a href="index.php?module=poissonDisplay&poisson_id={$dataParent[lst].parent_id}">
{$dataParent[lst].matricule}
{if strlen($dataParent[lst].pittag_valeur) > 0}
 {$dataParent[lst].pittag_valeur}
{if strlen($dataParent[lst].prenom) > 0 }
 {$dataParent[lst].prenom}
{/if}
{/if}
</a>
</td>
<td>{$dataParent[lst].sexe_libelle}</td>
<td>{$dataParent[lst].cohorte}</td>
</tr>
{/section}
</tbody>
</table>