<h2>Méthodes de détermination de la cohorte</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=cohorteTypeChange&cohorte_type_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("ccohorteTypeList");
</script>
<table id="ccohorteTypeList" class="tableliste">
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
<a href="index.php?module=cohorteTypeChange&cohorte_type_id={$data[lst].cohorte_type_id}">
{$data[lst].cohorte_type_libelle}
</a>
{else}
{$data[lst].cohorte_type_libelle}
{/if}
</td>
</tr>
{/section}
</tdata>
</table>