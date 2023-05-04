<h2{t}Laboratoires d'analyse{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=laboratoireAnalyseChange&laboratoire_analyse_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("claboratoireAnalyseList");
</script>
<table class="table table-bordered table-hover datatable" id="claboratoireAnalyseList" class="tableliste">
<thead>
<tr>
<th>libellé</th>
<th>Actif ?</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=laboratoireAnalyseChange&laboratoire_analyse_id={$data[lst].laboratoire_analyse_id}">
{$data[lst].laboratoire_analyse_libelle}
</a>
{else}
{$data[lst].laboratoire_analyse_libelle}
{/if}
</td>
<td>
{if $data[lst].laboratoire_analyse_actif == 1}oui{else}non{/if}
</tr>
{/section}
</tbody>
</table>