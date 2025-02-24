<h2>{t}Caractéristiques particulières du sperme{/t}</h2>
{if $rights["paramAdmin"] == 1 || $rights.reproAdmin == 1}
<a href="spermeCaracteristiqueChange?sperme_caracteristique_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="ccaracteristiqueList" class="tableliste">
<thead>
<tr>
<th>{t}Libellé{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $rights["paramAdmin"] == 1||$rights.reproAdmin == 1}
<a href="spermeCaracteristiqueChange?sperme_caracteristique_id={$data[lst].sperme_caracteristique_id}">
{$data[lst].sperme_caracteristique_libelle}
</a>
{else}
{$data[lst].sperme_caracteristique_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>