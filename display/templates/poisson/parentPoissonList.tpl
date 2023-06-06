
<table class="table table-bordered table-hover datatable-nopaging-nosearch" id="cparentList" >
<thead>
<tr>
{if $droits.poissonGestion == 1}
<th>{t}Modif{/t}</th>
{/if}
<th>{t}Parent{/t}</th>
<th>{t}Sexe{/t}</th>
<th>{t}Cohorte{/t}</th>
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