
<h2>Saisie des restes</h2>
<a href="index.php?module=repartitionList">Retour à la liste</a>
<a href="index.php?module=repartitionPrint&repartition_id={$data.repartition_id}" id="repartitionPrint">Imprimer la répartition</a>
<div class="formSaisie">
Période du : {$data.date_debut_periode} au {$data.date_fin_periode}
<div>
<form id="repartitionForm" method="post" action="index.php?module=repartitionWrite">
<input type="hidden" name="repartition_id" value="{$data.repartition_id}">
<table>
<tr>
<th>Bassin</th>
{section name=lst loop=$dateArray}
<th>{$dateArray[lst].libelle}</th>
{/section}
<th>Total</th>
</tr>
{section name=lst loop=$dataBassin}
<tr>
<td>{$dataBassin[lst].bassin_nom}</td>
{section name=jr loop=$dataBassin[lst].reste}
<td>
<input name="reste_{$dateArray[jr].numJour}_{$dataBassin[lst].distribution_id}" id="reste_{$dateArray[jr].numJour}_{$dataBassin[lst].distribution_id}" class="reste" value="{$dataBassin[lst][reste][jr]}">
</td>
{/section}
<td>
<input name="reste_total_{$dataBassin[lst].distribution_id}" id="reste_total_{$dataBassin[lst].distribution_id}" value="{$dataBassin[lst].reste_total}">
</td>
</tr>
{/section}


</table>
</form>
</div>
</div>
