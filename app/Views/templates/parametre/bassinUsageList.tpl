<h2>{t}Utilisations des bassins{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="bassinUsageChange?bassin_usage_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cbassinUsageList" class="tableliste">
<thead>
<tr>
<th>{t}libellé{/t}</th>
<th>{t}Catégorie d'alimentation{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $rights["paramAdmin"] == 1}
<a href="bassinUsageChange?bassin_usage_id={$data[lst].bassin_usage_id}">
{$data[lst].bassin_usage_libelle}
</a>
{else}
{$data[lst].bassin_usage_libelle}
{/if}
</td>
<td>
{$data[lst].categorie_libelle}
</td>
</tr>
{/section}
</tbody>
</table>