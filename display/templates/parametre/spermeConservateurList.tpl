<h2>Conservateurs du sperme utilisés pour la congélation</h2>
{if $droits["paramAdmin"] == 1 || $droits.reproAdmin == 1}
<a href="index.php?module=spermeConservateurChange&sperme_conservateur_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cconservateurList");
</script>
<table id="cconservateurList" class="tableliste">
<thead>
<tr>
<th>Nom du produit conservateur</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1||$droits.reproAdmin == 1}
<a href="index.php?module=spermeConservateurChange&sperme_conservateur_id={$data[lst].sperme_conservateur_id}">
{$data[lst].sperme_conservateur_libelle}
</a>
{else}
{$data[lst].sperme_conservateur_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>