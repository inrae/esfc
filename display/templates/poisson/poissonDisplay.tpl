<h2>Détail d'un poisson</h2>
<a href="index.php?module=poissonList">Retour à la liste des poissons</a>
<table class="tablemulticolonne">
<tr>
<td>
<h3>Identification du poisson</h3>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=poissonChange&poisson_id={$dataPoisson.poisson_id}">
Modifier les informations...
</a>
{/if}
{include file="poisson/poissonDetail.tpl"}
</td>
<td>
<h3>Liste des (pit)tags attribués</h3>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=pittagChange&poisson_id={$dataPoisson.poisson_id}&pittag_id=0">
Nouveau pittag ou étiquette...
</a>
{/if}
{include file="poisson/pittagList.tpl"}
</td>
</tr>

<tr>
<td>
<h3>Événements associés</h3>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataPoisson.poisson_id}&evenement_id=0">
Nouvel événement...
</a>
{/if}
{include file="poisson/evenementList.tpl"}
</td>
<td>
<h3>Données morphologiques</h3>
{include file="poisson/morphologieList.tpl"}
</td>
</tr>
<tr>
<td>
<h3>Pathologies</h3>
{include file="poisson/pathologieList.tpl"}
</td>
<td>
<h3>Détermination du sexe</h3>
{include file="poisson/genderSelectionList.tpl"}
</td>

</tr>
</table>
