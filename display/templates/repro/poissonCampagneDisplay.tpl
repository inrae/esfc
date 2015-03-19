<h2>Détail d'un reproducteur</h2>
<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">Retour à la liste des poissons</a>
{if $droits["reproGestion"]==1}
&nbsp;
<a href="index.php?module=poissonCampagneChange&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&poisson_id={$dataPoisson.poisson_id}">
Modifier les informations générales...
</a>
{/if}
<table class="tablemulticolonne">
<tr>
<td colspan="2">
{include file="repro/poissonCampagneDetail.tpl"}
</td>
</tr>
<tr>
<td>
<fieldset>
<legend>Séquences de reproduction</legend>
{include file="repro/poissonSequenceList.tpl"}
</fieldset>
</td>
<td>
<fieldset>
<legend>Événements liés aux séquences</legend>
{include file="repro/psEvenementList.tpl"}
</fieldset>
</td>
</tr>
<tr>
<td>
<fieldset>
<legend>Échographies de l'année</legend>
{if $droits.reproGestion == 1}
<a href="index.php?module=evenementChange&evenement_id=0&poisson_id={$dataPoisson.poisson_id}">
Nouvelle échographie (nouvel événement)...
</a>
{/if}
{include file="poisson/echographieList.tpl"}
</fieldset>
</td>
<td>
<fieldset>
<legend>Analyses sanguines</legend>
{include file="repro/poissonSanguinList.tpl"}
</fieldset>
</td>
<tr>
<td colspan="2">
<fieldset>
<legend>Biopsies</legend>
{include file="repro/poissonBiopsieList.tpl"}
</fieldset>
</td>
</tr>

</table>