
<table class="table table-bordered table-hover datatable ok" id="cpathologieList"  data-order='[[1,"desc"]]' data-tabicon="okpathologie">
<thead>
<tr>
<th>{t}Événement associé{/t}</th>
<th>{t}Date{/t}</th>
<th>{t}Type de pathologie{/t}</th>
<th>{t}Commentaire{/t}</th>


</tr>
</thead>
<tbody>
{section name=lst loop=$dataPatho}
<tr>
<td>
{if $rights["poissonGestion"]==1}
<a href="evenementChange?poisson_id={$dataPatho[lst].poisson_id}&evenement_id={$dataPatho[lst].evenement_id}">
{$dataPatho[lst].evenement_type_libelle}
</a>
{else}
{$dataPatho[lst].evenement_type_libelle}
{/if}
</td>
<td>
{$dataPatho[lst].pathologie_date}
</td>
<td>{$dataPatho[lst].pathologie_type_libelle}</td>
<td>{$dataPatho[lst].pathologie_commentaire}</td>
</tr>
{/section}
</tbody>
</table>