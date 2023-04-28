<h2>Modification d'un type d'aliment</h2>

<a href="index.php?module=alimentTypeList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form id="alimentTypeForm" method="post" action="index.php?module=alimentTypeWrite">
<input type="hidden" name="aliment_type_id" value="{$data.aliment_type_id}">
<dl>
<dt>Type d'aliment <span class="red">*</span> :</dt>
<dd><input name="aliment_type_libelle" size="40" value="{$data.aliment_type_libelle}" autofocus></dd>
</dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.aliment_type_id > 0 &&$droits["paramAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="aliment_type_id" value="{$data.aliment_type_id}">
<input type="hidden" name="module" value="alimentTypeDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>