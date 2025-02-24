<h2>{t}Emplacements d'implantation des marques VIE{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="vieImplantationChange?vie_implantation_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cvie_implantationList" class="tableliste">
<thead>
<tr>
<th>{t}Nom de l'emplacement d'implantation{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $rights["paramAdmin"] == 1||$rights.reproAdmin == 1}
<a href="vieImplantationChange?vie_implantation_id={$data[lst].vie_implantation_id}">
{$data[lst].vie_implantation_libelle}
</a>
{else}
{$data[lst].vie_implantation_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>