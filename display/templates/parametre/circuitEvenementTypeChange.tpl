<h2>Modification d'un type d'événement survenant dans les circuits d'eau</h2>

<a href="index.php?module=circuitEvenementTypeList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form id="circuitEvenementTypeForm" method="post" action="index.php?module=circuitEvenementTypeWrite">
<input type="hidden" name="circuit_evenement_type_id" value="{$data.circuit_evenement_type_id}">
<dl>
<dt>Type d'événement <span class="red">*</span> :</dt>
<dd><input name="circuit_evenement_type_libelle" size="40" value="{$data.circuit_evenement_type_libelle}" autofocus></dd>
</dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.circuit_evenement_type_id > 0 &&$droits["paramAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="circuit_evenement_type_id" value="{$data.circuit_evenement_type_id}">
<input type="hidden" name="module" value="circuitEvenementTypeDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>