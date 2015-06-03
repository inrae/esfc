<h2>Liste des applications disponibles dans le module de gestion des droits</h2>
<a href="index.php?module=appliChange&aclappli_id=0">
Nouvelle application...
</a>
<table id="appliListe" class="tableliste">
<thead>
<tr>
<th>Nom de l'application</th>
<th>Description</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
<a href="index.php?module=appliDisplay&aclappli_id={$data[lst].aclappli_id}">
{$data[lst].appli}
</a>
</td>
<td>{$data[lst].applidetail}</td>
</tr>
{/section}
</tbody>
</table>