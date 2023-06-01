
<table class="table table-bordered table-hover datatable" id="cpathologieList" class="tableliste">
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
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataPatho[lst].poisson_id}&evenement_id={$dataPatho[lst].evenement_id}">
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