<h2>Modification d'un type d'anomalie dans la base de données</h2>

<a href="index.php?module=anomalieDbTypeList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form id="anomalieDbTypeForm" method="post" action="index.php?module=anomalieDbTypeWrite">
<input type="hidden" name="anomalie_db_type_id" value="{$data.anomalie_db_type_id}">
<dl>
<dt>Type d'anomalieDb <span class="red">*</span> :</dt>
<dd><input name="anomalie_db_type_libelle" size="40" value="{$data.anomalie_db_type_libelle}" autofocus></dd>
</dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.anomalie_db_type_id > 0 &&$droits["paramAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="anomalie_db_type_id" value="{$data.anomalie_db_type_id}">
<input type="hidden" name="module" value="anomalieDbTypeDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>