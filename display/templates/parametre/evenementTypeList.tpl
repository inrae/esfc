<h2>Types d'événements</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=evenementTypeChange&evenement_type_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cevenementTypeList");
</script>
<table id="cevenementTypeList" class="tableliste">
<thead>
<tr>
<th>libellé</th>
<th>Actif ?</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=evenementTypeChange&evenement_type_id={$data[lst].evenement_type_id}">
{$data[lst].evenement_type_libelle}
</a>
{else}
{$data[lst].evenement_type_libelle}
{/if}
</td>
<td>
{if $data[lst].evenement_type_actif == 1}oui
{elseif $data[lst].evenement_type_actif == 0}non
{/if}
</td>
</tr>
{/section}
</tdata>
</table>