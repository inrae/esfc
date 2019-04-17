<h2>Nageoires (prélèvements génétiques)</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=nageoireChange&nageoire_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("ccaracteristiqueList");
</script>
<table id="cnageoireList" class="tableliste">
<thead>
<tr>
<th>Libellé</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1||$droits.reproAdmin == 1}
<a href="index.php?module=nageoireChange&nageoire_id={$data[lst].nageoire_id}">
{$data[lst].nageoire_libelle}
</a>
{else}
{$data[lst].nageoire_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>