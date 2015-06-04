<h2>Modification du droit d'une application (module de gestion des droits)</h2>

<a href="index.php?module=appliList">Retour à la liste des applications</a>
&nbsp;<a href="index.php?module=appliDisplay&aclappli_id={$dataAppli.aclappli_id}">
Retour à {$dataAppli.appli} ({$dataAppli.applidetail})
</a>
<div class="formSaisie">
<div>

<form id="acoForm" method="post" action="index.php?module=acoWrite">
<input type="hidden" name="aclaco_id" value="{$data.aclaco_id}">
<input type="hidden" name="aclappli_id" value="{$data.aclappli_id}">
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
<dl>
<dt>Nom du droit utilisé dans l'application <span class="red">*</span> :</dt>
<dd><input name="aco" value="{$data.aco}" autofocus required></dd>
</dl>
<dl>
<dt>Groupes disposant du droit :</dt>
<dd>
<table class="tablenoborder">
{section name=lst loop=$groupes}
<tr><td>
{for $boucle = 1 to $groupes[lst].level}
&nbsp;&nbsp;&nbsp;
{/for}
{$groupes[lst].groupe}
</td>
<td>
<input type="checkbox" name="groupes[]" value="{$groupes[lst].aclgroup_id}" {if $groupes[lst].checked == 1}checked{/if}>
</td>
</tr>
{/section}
</table>
</dl>
<dl></dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.aclaco_id > 0}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="aclaco_id" value="{$data.aclaco_id}">
<input type="hidden" name="aclappli_id" value="{$data.aclappli_id}">
<input type="hidden" name="module" value="acoDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>