<h2{t}Détail d'un séquence{/t}</h2>
<a href="index.php?module=sequenceList">
Retour à la liste des séquences
</a>
{if $droits["reproGestion"]==1}
&nbsp;
<a href="index.php?module=sequenceChange&sequence_id={$dataSequence.sequence_id}">
Modifier les informations générales de la séquence...
</a>
{/if}
<table class="tablemulticolonne">
<tr>
<td>

{include file="repro/sequenceDetail.tpl"}
<br>
<fieldset>
<legend>Poissons rattachés à la séquence</legend>
{include file="repro/sequencePoissonList.tpl"}
</fieldset>
<br>
<fieldset>
<legend>Croisements effectués</legend>
{include file="repro/croisementList.tpl"}
</fieldset>
<br>
<fieldset>
<legend>Lots issus des croisements</legend>
{include file="repro/lotList.tpl"}
</fieldset>
</td>
</tr>
</table>
<br>