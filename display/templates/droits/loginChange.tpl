<h2>Modification d'un login (module de gestion des droits)</h2>

<a href="index.php?module=aclloginList">Retour à la liste des logins</a>
<div class="formSaisie">
<div>

<form id="loginForm" method="post" action="index.php?module=aclloginWrite">
<input type="hidden" name="acllogin_id" value="{$data.acllogin_id}">
<dl>
<dt>Nom de l'utilisateur <span class="red">*</span> :</dt>
<dd><input name="logindetail" value="{$data.logindetail}" autofocus required></dd>
</dl>
<dl>
<dt>Login utilisé <span class="red">*</span> : </dt>
<dd><input name="login" value="{$data.login}" required></dd>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.acllogin_id > 0 }
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="acllogin_id" value="{$data.acllogin_id}">
<input type="hidden" name="module" value="aclloginDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>

<table class="tableliste">
<tr>
<th>Droits attribués</th>
</tr>
{foreach $loginDroits as $droit=>$value}
<tr><td>{$droit}</td></tr>
{/foreach}

</table>