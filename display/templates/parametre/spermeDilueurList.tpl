<h2>Dilueurs du sperme utilisés pour la congélation</h2>
{if $droits["paramAdmin"] == 1 || $droits.reproAdmin == 1}
<a href="index.php?module=spermeDilueurChange&sperme_dilueur_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cdilueurList");
</script>
<table id="cdilueurList" class="tableliste">
<thead>
<tr>
<th>Nom du produit dilueur</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1||$droits.reproAdmin == 1}
<a href="index.php?module=spermeDilueurChange&sperme_dilueur_id={$data[lst].sperme_dilueur_id}">
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