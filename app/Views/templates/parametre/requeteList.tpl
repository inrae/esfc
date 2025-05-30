<h2>{t}Liste des requêtes{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="requeteChange?requete_id=0">
Nouvelle requête...
</a>
&nbsp;
{/if}
<a href="getStructureDatabase" target="_blank">Description des tables de la base de données</a>
<a href="getSchemaDatabase" target="_blank">Schéma d'organisation des tables</a>

<table class="table table-bordered table-hover datatable display" id="crequeteList" class="tableliste">
<thead>
<tr>
<th>{t}Id{/t}</th>
<th>{t}Description{/t}</th>
<th>{t}Date création{/t}</th>
<th>{t}Date dernière exécution{/t}</th>
<th>{t}Créateur (login){/t}</th>
<th><img src="display/images/exec.png" height="25"></th>
{if $rights["paramAdmin"] == 1}
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
{if $rights["requeteAdmin"] == 1}
<a href="requeteChange?requete_id={$data[lst].requete_id}">
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
<a href="requeteExecList?requete_id={$data[lst].requete_id}" title="Exécuter la requête">
<img src="display/images/exec.png" height="25">
</a>
</td>
{if $rights["paramAdmin"] == 1}
<td class="center">
<a href="requeteCopy&requete_id={$data[lst].requete_id}" title="Créer une nouvelle requête">
<img src="display/images/copy.png" height="25">
</a>
</td>
{/if}
</tr>
{/section}
</tbody>
</table>