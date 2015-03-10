<h2>Détail d'un bassin</h2>
<a href="index.php?module={$bassinParentModule}">Retour à la liste des bassins</a>
<table class="tablemulticolonne">
<tr>
<td>
<h3>Identification du bassin</h3>
{include file="bassin/bassinDetail.tpl"}
<h3>Liste des poissons présents</h3>
{include file="bassin/bassinPoissonPresent.tpl"}
<br>
<h3>Profil thermique</h3>
</td>
<td>
<h3>Évenements survenus</h3>
{include file="bassin/bassinEvenementList.tpl"}
</td>
</tr>
</table>