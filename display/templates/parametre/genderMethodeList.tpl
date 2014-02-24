<h2>Méthodes de détermination du sexe</h2>
{if $droits["admin"] == 1}
<a href="index.php?module=genderMethodeChange&gender_methode_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cgenderMethodeList");
</script>
<table id="cgenderMethodeList" class="tableaffichage">
<thead>
<tr>
<th>libellé</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["admin"] == 1}
<a href="index.php?module=genderMethodeChange&gender_methode_id={$data[lst].gender_methode_id}">
{$data[lst].gender_methode_libelle}
</a>
{else}
{$data[lst].gender_methode_libelle}
{/if}
</td>
</tr>
{/section}
</tdata>
</table>