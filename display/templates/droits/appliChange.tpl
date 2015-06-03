<h2>Modification d'une application (module de gestion des droits)</h2>

<a href="index.php?module=appliList">Retour à la liste des applications</a>
<div class="formSaisie">
<div>

<form id="appliForm" method="post" action="index.php?module=appliWrite">
<input type="hidden" name="aclappli_id" value="{$data.aclappli_id}">
<dl>
<dt>Nom de l'application <span class="red">*</span> :</dt>
<dd><input name="appli" value="{$data.appli}" autofocus required></dd>
</dl>
<dl>
<dt>Description : </dt>
<dd><input name="applidetail" value="{$data.applidetail}"></dd>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.aclappli_id > 0 }
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="aclappli_id" value="{$data.aclappli_id}">
<input type="hidden" name="module" value="appliDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>