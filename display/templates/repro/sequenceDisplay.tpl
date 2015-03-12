<h2>Détail d'un séquence</h2>
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
{include file="repro/sequencePoissonList.tpl"}
<br>
{include file="repro/croisementList.tpl"}
</td>
</tr>
</table>
<br>