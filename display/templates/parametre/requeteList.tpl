<h2>Liste des requêtes</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=requeteChange&requete_id=0">
Nouvelle requête...
</a>
&nbsp;
{/if}
<a href="index.php?module=getStructureDatabase" target="_blank">Description des tables de la base de données</a>
<a href="index.php?module=getSchemaDatabase" target="_blank">Schéma d'organisation des tables</a>
<script>
setDataTables("crequeteList", true, true, true, 50);
</script>
<table id="crequeteList" class="tableliste">
<thead>
<tr>
<th>Id</th>
<th>Description</th>
<th>Date création</th>
<th>Date dernière<br>exécution</th>
<th>Créateur (login)</th>
<th><img src="display/images/exec.png" height="25"></th>
{if $droits["paramAdmin"] == 1}
<th><img src="display/images/copy.png" height="25"></th>
{/if}
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{$data[lst].requete_id}
</td>
<td>
{if $droits["requeteAdmin"] == 1}
<a href="index.php?module=requeteChange&requete_id={$data[lst].requete_id}">
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
<a href="index.php?module=requeteExecList&requete_id={$data[lst].requete_id}" title="Exécuter la requête">
<img src="display/images/exec.png" height="25">
</a>
</td>
{if $droits["paramAdmin"] == 1}
<td class="center">
<a href="index.php?module=requeteCopy&requete_id={$data[lst].requete_id}" title="Créer une nouvelle requête">
<img src="display/images/copy.png" height="25">
</a>
</td>
{/if}
</tr>
{/section}
</tbody>
</table>