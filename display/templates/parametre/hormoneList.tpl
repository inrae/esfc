<h2>Hormones utilisées pour la reproduction</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=hormoneChange&hormone_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("chormonList");
</script>
<table id="chormoneList" class="tableliste">
<thead>
<tr>
<th>Nom de l'hormone</th>
<th>Unité utilisée pour l'injection</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1||$droits.reproAdmin == 1}
<a href="index.php?module=hormoneChange&hormone_id={$data[lst].hormone_id}">
{$data[lst].hormone_nom}
</a>
{else}
{$data[lst].hormone_nom}
{/if}
</td>
<td>
{$data[lst].hormone_unite}
</td>
</tr>
{/section}
</tbody>
</table>