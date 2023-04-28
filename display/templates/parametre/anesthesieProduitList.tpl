<h2>Produits utilisés pour l'anesthésie</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=anesthesieProduitChange&anesthesie_produit_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cproduitList");
</script>
<table id="cproduitList" class="tableliste">
<thead>
<tr>
<th>Nom du produit</th>
<th>Utilisé actuellement ?</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1||$droits.reproAdmin == 1}
<a href="index.php?module=anesthesieProduitChange&anesthesie_produit_id={$data[lst].anesthesie_produit_id}">
{$data[lst].anesthesie_produit_libelle}
</a>
{else}
{$data[lst].anesthesie_produit_libelle}
{/if}
</td>
<td class="center">
{if $data[lst].anesthesie_produit_actif == 1}oui{else}non{/if}
</td>
</tr>
{/section}
</tbody>
</table>