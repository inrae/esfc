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
{if $droits.reproGestion == 1}
<a href="index.php?module=profilThermiqueChange&profil_thermique_id=0&bassin_campagne_id={$dataBassinCampagne.bassin_campagne_id}">
Nouvelle température prévue/relevée...
</a>
{/if}
{include file="repro/profilThermiqueList.tpl"}
</td>
<td>
<h3>Évenements survenus</h3>
{include file="bassin/bassinEvenementList.tpl"}
</td>
</tr>
</table>