<h2>Modification d'un groupe et rattachement des logins</h2>

<a href="index.php?module=groupList">Retour à la liste des groupes</a>
<div class="formSaisie">
<div>

<form id="groupForm" method="post" action="index.php?module=groupWrite">
<input type="hidden" name="aclgroup_id" value="{$data.aclgroup_id}">
<input type="hidden" name="aclgroup_id_parent" value="{$data.aclgroup_id_parent}">
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
<dl>
<dt>Nom du groupe <span class="red">*</span> :</dt>
<dd><input name="groupe" value="{$data.groupe}" autofocus required></dd>
</dl>
<dl>
<dt>Logins rattachés <span class="red">*</span> : </dt>
<dd>
<table class="tablenoborder">
{section name=lst loop=$logins}
<tr><td>
{$logins[lst].logindetail}
</td>
<td>
<input type="checkbox" name="logins[]" value="{$logins[lst].acllogin_id}" {if $logins[lst].checked == 1}checked{/if}>
</td>
</tr>
{/section}
</table>
</dd>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.aclgroup_id > 0 }
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="aclgroup_id" value="{$data.aclgroup_id}">
<input type="hidden" name="module" value="groupDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>