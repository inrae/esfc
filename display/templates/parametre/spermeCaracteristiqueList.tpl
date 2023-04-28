<h2>Caractéristiques particulières du sperme</h2>
{if $droits["paramAdmin"] == 1 || $droits.reproAdmin == 1}
<a href="index.php?module=spermeCaracteristiqueChange&sperme_caracteristique_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("ccaracteristiqueList");
</script>
<table id="ccaracteristiqueList" class="tableliste">
<thead>
<tr>
<th>Libellé</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1||$droits.reproAdmin == 1}
<a href="index.php?module=spermeCaracteristiqueChange&sperme_caracteristique_id={$data[lst].sperme_caracteristique_id}">
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