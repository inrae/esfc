<h2>{t}Conservateurs du sperme utilisés pour la congélation{/t}</h2>
{if $rights["paramAdmin"] == 1 || $rights.reproAdmin == 1}
<a href="spermeConservateurChange?sperme_conservateur_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cconservateurList" class="tableliste">
<thead>
<tr>
<th>{t}Nom du produit conservateur{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $rights["paramAdmin"] == 1||$rights.reproAdmin == 1}
<a href="spermeConservateurChange?sperme_conservateur_id={$data[lst].sperme_conservateur_id}">
{$data[lst].sperme_conservateur_libelle}
</a>
{else}
{$data[lst].sperme_conservateur_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>
