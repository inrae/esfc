<h2>Modification d'un type d'utilisation des bassins</h2>

<a href="index.php?module=hormoneList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="hormoneForm" method="post" action="index.php?module=hormoneWrite">
<input type="hidden" name="hormone_id" value="{$data.hormone_id}">
<dl>
<dt>
Nom de l'hormone <span class="red">*</span> :
</dt>
<dd>
<input name="hormone_nom" type="text" value="{$data.hormone_nom}" required autofocus/>
</dd>
</dl>
<dl>
<dt>Unité utilisée pour<br>quantifier les injections :</dt>
<dd>
<input name="hormone_unite" type="text" value="{$data.hormone_unite}">
</dd>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>

{if $data.hormone_id > 0 &&($droits["paramAdmin"] == 1 || $droits.reproAdmin == 1)}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="hormone_id" value="{$data.hormone_id}">
<input type="hidden" name="module" value="hormoneDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
</form>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>