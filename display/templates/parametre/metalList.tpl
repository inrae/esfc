<h2>Liste des métaux analysés</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=metalChange&metal_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("cmetalList");
</script>
<table id="cmetalList" class="tableliste">
<thead>
<tr>
<th>Nom du metal</th>
<th>Unité utilisée pour la mesure</th>
<th>Actif ?</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1||$droits.reproAdmin == 1}
<a href="index.php?module=metalChange&metal_id={$data[lst].metal_id}">
{$data[lst].metal_nom}
</a>
{else}
{$data[lst].metal_nom}
{/if}
</td>
<td>
{$data[lst].metal_unite}
</td>
<td class="center">
{if $data[lst].metal_actif == 1}oui
{elseif $data[lst].metal_actif == 0}non
{/if}
</td>
</tr>
{/section}
</tbody>
</table>