<h2>Détail d'un séquence</h2>
<a href="index.php?module=sequenceList">
Retour à la liste des séquences
</a>
{if $droits["reproGestion"]==1}
&nbsp;
<a href="index.php?module=sequenceChange&sequence_id={$data.sequence_id}">
Modifier les informations générales de la séquence...
</a>
{/if}
<table class="tablemulticolonne">
<tr>
<td>

{include file="repro/sequenceDetail.tpl"}
</td>
</tr>
</table>
