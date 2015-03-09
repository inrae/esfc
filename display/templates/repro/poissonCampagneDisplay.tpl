<h2>Détail d'un reproducteur</h2>
<a href="index.php?module=poissonCampagneList">Retour à la liste des poissons</a>
{if $droits["reproGestion"]==1}
&nbsp;
<a href="index.php?module=poissonCampagneChange&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Modifier les taux de croissance...
</a>
{/if}
<table class="tablemulticolonne">
<tr>
<td>
{include file="repro/poissonCampagneDetail.tpl"}
</td>
<td>
{include file="repro/poissonSequenceList.tpl"}
</td>
</tr>
<tr>
<td colspan="2">
{include file="repro/poissonEchographieList.tpl"}
<br>
{include file="repro/poissonSanguinList.tpl"}
<br>
{include file="repro/poissonBiopsieList.tpl"}
</td>
</tr>
</table>