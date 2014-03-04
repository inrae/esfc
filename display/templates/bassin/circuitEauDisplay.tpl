<h2>Données physico-chimiques du circuit d'eau {$data.circuit_eau_libelle}</h2>
<a href="index.php?module=circuitEauList">Retour à la liste des circuits d'eau</a>
{if $droits["bassinGestion"]==1}
<a href="index.php?module=circuitEauChange&circuit_eau_id={$data.circuit_eau_id}">
Modifier le nom du circuit d'eau...
</a>
{/if}
<table class="tablemulticolonne">
<tr>
<td>
</td>
</tr>
</table>