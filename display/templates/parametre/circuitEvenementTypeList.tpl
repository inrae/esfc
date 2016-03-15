<h2>Types d'événements survenant dans les circuits d'eau</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=circuitEvenementTypeChange&circuit_evenement_type_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("ccircuitEvenementTypeList");
</script>
<table id="ccircuitEvenementTypeList" class="tableliste">
<thead>
<tr>
<th>libellé</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=circuitEvenementTypeChange&circuit_evenement_type_id={$data[lst].circuit_evenement_type_id}">
{$data[lst].circuit_evenement_type_libelle}
</a>
{else}
{$data[lst].circuit_evenement_type_libelle}
{/if}
</td>
</tr>
{/section}
</tdata>
</table>