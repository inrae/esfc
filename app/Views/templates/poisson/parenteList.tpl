
<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="cparenteList"  data-order='[[2,"asc"]]'  data-tabicon="okgenetique">
<thead>
<tr>
<th>{t}Événement associé{/t}</th>
<th>{t}Type de parente{/t}</th>
<th>{t}Date{/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataParente}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataParente[lst].poisson_id}&evenement_id={$dataParente[lst].evenement_id}">
{$dataParente[lst].evenement_type_libelle}
</a>
{else}
{$dataParente[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataParente[lst].determination_parente_libelle}</td>
<td>{$dataParente[lst].parente_date}</td>
<td>{$dataParente[lst].parente_commentaire}</td>
</tr>
{/section}
</tbody>
</table>