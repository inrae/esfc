<h2>Modification d'un type d'événement survenant dans les bassins</h2>

<a href="index.php?module=bassinEvenementTypeList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form id="bassinEvenementTypeForm" method="post" action="index.php?module=bassinEvenementTypeWrite">
<input type="hidden" name="bassin_evenement_type_id" value="{$data.bassin_evenement_type_id}">
<dl>
<dt>Type d'événement <span class="red">*</span> :</dt>
<dd><input name="bassin_evenement_type_libelle" size="40" value="{$data.bassin_evenement_type_libelle}" autofocus></dd>
</dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.bassin_evenement_type_id > 0 &&$droits["paramAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="bassin_evenement_type_id" value="{$data.bassin_evenement_type_id}">
<input type="hidden" name="module" value="bassinEvenementTypeDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>