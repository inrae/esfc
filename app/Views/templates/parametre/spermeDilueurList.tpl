<h2>{t}Dilueurs du sperme utilisés pour la congélation{/t}</h2>
{if $rights["paramAdmin"] == 1 || $rights.reproAdmin == 1}
<a href="spermeDilueurChange?sperme_dilueur_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cdilueurList" class="tableliste">
<thead>
<tr>
<th>{t}Nom du produit dilueur{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $rights["paramAdmin"] == 1||$rights.reproAdmin == 1}
<a href="spermeDilueurChange?sperme_dilueur_id={$data[lst].sperme_dilueur_id}">
{$data[lst].sperme_dilueur_libelle}
</a>
{else}
{$data[lst].sperme_dilueur_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>