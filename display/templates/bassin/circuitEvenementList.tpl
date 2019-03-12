<script>
setDataTables("ccircuitEvenementList", true, false, false, 3);
</script>
{if $droits["bassinGestion"] == 1}
<a href="index.php?module=circuitEvenementChange&circuit_evenement_id=0&circuit_eau_id={$data.circuit_eau_id}">
Nouvel événement...
</a>
{/if}
<table id="ccircuitEvenementList" class="tableliste">
<thead>
<tr>
<th>Évenement</th>
<th>Date</th>
<th>Commentaire</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataCircuitEvnt}
<tr>
<td>
{if $droits["bassinGestion"] == 1}
<a href="index.php?module=circuitEvenementChange&circuit_evenement_id={$dataCircuitEvnt[lst].circuit_evenement_id}&circuit_eau_id={$dataCircuitEvnt[lst].circuit_eau_id}">
{$dataCircuitEvnt[lst].circuit_evenement_type_libelle}
</a>
{else}
{$dataCircuitEvnt[lst].circuit_evenement_type_libelle}
{/if}
</td>
<td>
{$dataCircuitEvnt[lst].circuit_evenement_date}
</td>
<td>{$dataCircuitEvnt[lst].circuit_evenement_commentaire}</td>
</tr>
{/section}
</tbody>
</table>