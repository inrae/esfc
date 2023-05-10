<h2{t}Statuts des poissons{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=poissonStatutChange&poisson_statut_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cpoissonStatutList");
</script>
<table class="table table-bordered table-hover datatable" id="cpoissonStatutList" class="tableliste">
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
<a href="index.php?module=poissonStatutChange&poisson_statut_id={$data[lst].poisson_statut_id}">
{$data[lst].poisson_statut_libelle}
</a>
{else}
{$data[lst].poisson_statut_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>
