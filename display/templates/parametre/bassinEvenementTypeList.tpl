<h2>{t}Types d'événements survenant dans les bassins{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=bassinEvenementTypeChange&bassin_evenement_type_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cbassinEvenementTypeList");
</script>
<table class="table table-bordered table-hover datatable" id="cbassinEvenementTypeList" class="tableliste">
<thead>
<tr>
<th>{t}libellé{/t}</th>
</tr>
</thead>
<tbody>
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
</tbody>
</table>