
<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="canesthesieList" data-order='[[1,"desc"]]' data-tabicon="okreproduction">
<thead>
<tr>
<th>{t}Événement associé{/t}</th>
<th>{t}Date{/t}</th>
<th>{t}Produit utilisé{/t}</th>
<th>{t}Dosage (mg/l){/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataAnesthesie}
<tr>
<td>
{if $droits["poissonGestion"]==1||$droits.reproGestion==1}
<a href="index.php?module=evenementChange&poisson_id={$dataAnesthesie[lst].poisson_id}&evenement_id={$dataAnesthesie[lst].evenement_id}">
{$dataAnesthesie[lst].evenement_type_libelle}
</a>
{else}
{$dataAnesthesie[lst].evenement_type_libelle}
{/if}
</td>
<td>
{$dataAnesthesie[lst].anesthesie_date}
</td>
<td>{$dataAnesthesie[lst].anesthesie_produit_libelle}</td>
<td class="center">{$dataAnesthesie[lst].anesthesie_dosage}</td>
<td>{$dataAnesthesie[lst].anesthesie_commentaire}</td>
</tr>
{/section}
</tbody>
</table>
