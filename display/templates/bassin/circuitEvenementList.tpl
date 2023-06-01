
{if $droits["bassinGestion"] == 1}
<a href="index.php?module=circuitEvenementChange&circuit_evenement_id=0&circuit_eau_id={$data.circuit_eau_id}">
Nouvel événement...
</a>
{/if}
<table class="table table-bordered table-hover datatable" id="ccircuitEvenementList" class="tableliste">
<thead>
<tr>
<th>{t}Évenement{/t}</th>
<th>{t}Date{/t}</th>
<th>{t}Commentaire{/t}</th>
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