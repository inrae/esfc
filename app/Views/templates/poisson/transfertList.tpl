
<table class="table table-bordered table-hover datatable ok" id="ctransfertList"  data-order='[[1,"desc"]]' data-tabicon="oktransfert">
<thead>
<tr>
<th>{t}Événement associé{/t}</th>
<th>{t}Date de transfert{/t}</th>
<th>{t}Bassin d'origine{/t}</th>
<th>{t}Bassin de destination{/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataTransfert}
<tr>
<td>
{if $rights["poissonGestion"]==1}
<a href="evenementChange?poisson_id={$dataTransfert[lst].poisson_id}&evenement_id={$dataTransfert[lst].evenement_id}">
{$dataTransfert[lst].evenement_type_libelle}
</a>
{else}
{$dataTransfert[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataTransfert[lst].transfert_date}</td>
<td>
{if $dataTransfert[lst].bassin_origine > 0}
<a href="bassinDisplay?bassin_id={$dataTransfert[lst].bassin_origine}">
{$dataTransfert[lst].bassin_origine_nom}</a>
{/if}
</td>
<td>
{if $dataTransfert[lst].bassin_destination > 0}
<a href="bassinDisplay?bassin_id={$dataTransfert[lst].bassin_destination}">
{$dataTransfert[lst].bassin_destination_nom}</a>
{/if}
</td>
<td>{$dataTransfert[lst].transfert_commentaire}</td>
</tr>
{/section}
</tbody>
</table>