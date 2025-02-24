<h2>{t}Statuts des poissons{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="poissonStatutChange?poisson_statut_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cpoissonStatutList" class="tableliste">
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
<a href="poissonStatutChange?poisson_statut_id={$data[lst].poisson_statut_id}">
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
