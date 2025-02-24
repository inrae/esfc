
<table class="table table-bordered table-hover datatable ok" id="cechographieList" data-order='[[1,"desc"]]' data-tabicon="okreproduction">
<thead>
<tr>
<th>{t}Événement associé{/t}</th>
<th>{t}Date{/t}</th>
<th>{t}Stade gonade{/t}</th>
<th>{t}Stade œufs{/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataEcho}
<tr>
<td>
{if $rights["poissonGestion"]==1||$rights.reproGestion==1}
<a href="evenementChange?poisson_id={$dataEcho[lst].poisson_id}&evenement_id={$dataEcho[lst].evenement_id}">
{$dataEcho[lst].evenement_type_libelle}
</a>
{else}
{$dataEcho[lst].evenement_type_libelle}
{/if}
</td>
<td>
{$dataEcho[lst].echographie_date}
</td>
<td>{$dataEcho[lst].stade_gonade_libelle}</td>
<td>{$dataEcho[lst].stade_oeuf_libelle}</td>
<td>{$dataEcho[lst].echographie_commentaire}</td>
</tr>
{/section}
</tbody>
</table>
