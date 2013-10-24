<h2>Détail EXEMPLE</h2>
{if $droits.gestion == 1}
<a href="index.php?module=exampleModif&idExample={$data.idExample}">
Modifier...
</a>
{/if}
<table class="tableaffichage">
<tr>
<td class="libelleSaisie">Date :</td>
<td>{$data.dateExample}</td>
</tr>
tr>
<td class="libelleSaisie">Commentaire :</td>
<td>{$data.comment}</td>
</tr>
</table>