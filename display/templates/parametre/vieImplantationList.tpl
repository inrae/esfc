<h2>Emplacements d'implantation des marques VIE</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=vieImplantationChange&vie_implantation_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("chormonList");
</script>
<table id="cvie_implantationList" class="tableliste">
<thead>
<tr>
<th>Nom de l'emplacement d'implantation</th>
</tr>
</thead>
<tdata>
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
</tdata>
</table>