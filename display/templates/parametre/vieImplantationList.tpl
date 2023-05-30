<h2>{t}Emplacements d'implantation des marques VIE{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=vieImplantationChange&vie_implantation_id=0">
Nouveau...
</a>
{/if}
<script>

</script>
<table class="table table-bordered table-hover datatable" id="cvie_implantationList" class="tableliste">
<thead>
<tr>
<th>{t}Nom de l'emplacement d'implantation{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1||$droits.reproAdmin == 1}
<a href="index.php?module=vieImplantationChange&vie_implantation_id={$data[lst].vie_implantation_id}">
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