<h2>Liste des requêtes</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=requeteChange&requete_id=0">
Nouvelle requête...
</a>
{/if}
<script>
setDataTables("crequeteList");
</script>
<table id="crequeteList" class="tableliste">
<thead>
<tr>
<th>Id</th>
<th>Description</th>
<th>Date création</th>
<th>Date dernière<br>exécution</th>
<th>Créateur (login)</th>
<th>Exec</th>
{if $droits["paramAdmin"] == 1}
<th>Copy</th>
{/if}
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=requeteChange&metal_id={$data[lst].requete_id}">
{$data[lst].title}
</a>
{else}
{$data[lst].title}
{/if}
</td>
<td class="center">
{$data[lst].creation_date}
</td>
<td class="center">
 {$data[lst].last_exec}
</td>
<td>{$data[lst].login}</td>
<td class="center">
<a href="index.php?module=requeteExecListe&requete_id={$data[lst].requete_id}">
<img src="display/images/exec.png" height="25">
</a>
</td>
{if $droits["paramAdmin"] == 1}
<td class="center">
<a href="index.php?module=requeteCopy&requete_id={$data[lst].requete_id}">
<img src="display/images/copy.png" height="25">
</a>
</td>
{/if}
</tr>
{/section}
</tbody>
</table>