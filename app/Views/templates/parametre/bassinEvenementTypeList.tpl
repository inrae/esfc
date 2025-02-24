<h2>{t}Types d'événements survenant dans les bassins{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="bassinEvenementTypeChange?bassin_evenement_type_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cbassinEvenementTypeList" class="tableliste">
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
<a href="bassinEvenementTypeChange?bassin_evenement_type_id={$data[lst].bassin_evenement_type_id}">
{$data[lst].bassin_evenement_type_libelle}
</a>
{else}
{$data[lst].bassin_evenement_type_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>