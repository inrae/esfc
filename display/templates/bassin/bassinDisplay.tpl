<h2>Détail d'un bassin</h2>
<a href="index.php?module=bassinList">Retour à la liste des bassins</a>
<table class="tablemulticolonne">
<tr>
<td>
<h3>Identification du bassin</h3>
{if $droits["bassinGestion"]==1}
<a href="index.php?module=bassinChange&bassin_id={$dataBassin.bassin_id}">
Modifier les informations...
</a>
{/if}
{include file="bassin/bassinDetail.tpl"}
</td>
</tr>
<tr>
<td>
<h3>Liste des poissons présents</h3>
{include file="bassin/bassinPoissonPresent.tpl"}
</td>
</tr>
</table>