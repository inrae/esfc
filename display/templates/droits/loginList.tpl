<h2>Liste des logins déclarés dans le module de gestion des droits</h2>
<a href="index.php?module=aclloginChange&acllogin_id=0">
Nouveau login...
</a>
<script>setDataTables("loginListe", true, true, true);</script>
<table id="loginListe" class="tableliste">
<thead>
<tr>
<th>Utilisateur</th>
<th>Login employé</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
<a href="index.php?module=aclloginChange&acllogin_id={$data[lst].acllogin_id}">
{$data[lst].logindetail}
</a>
</td>
<td>{$data[lst].login}</td>
</tr>
{/section}
</tbody>
</table>