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
<h3>Liste des poissons présents</h3>
{include file="bassin/bassinPoissonPresent.tpl"}
</td>
<td>
<h3>Évenements survenus</h3>
{include file="bassin/bassinEvenementList.tpl"}
<br>
<h3>Documents associés</h3>
{include file="document/documentList.tpl"}
</td>
</tr>
</table>
<h3>Aliments consommés</h3>
{include file="bassin/bassinAlimentConsomme.tpl"}