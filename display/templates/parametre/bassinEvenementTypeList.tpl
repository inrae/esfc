<h2>Types d'événements survenant dans les bassins</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=bassinEvenementTypeChange&bassin_evenement_type_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cbassinEvenementTypeList");
</script>
<table id="cbassinEvenementTypeList" class="tableaffichage">
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
<a href="index.php?module=bassinEvenementTypeChange&bassin_evenement_type_id={$data[lst].bassin_evenement_type_id}">
{$data[lst].bassin_evenement_type_libelle}
</a>
{else}
{$data[lst].bassin_evenement_type_libelle}
{/if}
</td>
</tr>
{/section}
</tdata>
</table>