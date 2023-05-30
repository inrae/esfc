<h2{t}Modification d'un type d'événement survenant dans les circuits d'eau{/t}</h2>

<a href="index.php?module=circuitEvenementTypeList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="circuitEvenementTypeForm" method="post" action="index.php?module=circuitEvenementTypeWrite">
<input type="hidden" name="circuit_evenement_type_id" value="{$data.circuit_evenement_type_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Type d'événement <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="circuit_evenement_type_libelle" size="40" value="{$data.circuit_evenement_type_libelle}" autofocus>
</div>


<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>

{if $data.circuit_evenement_type_id > 0 &&$droits["paramAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="circuit_evenement_type_id" value="{$data.circuit_evenement_type_id}">
<input type="hidden" name="module" value="circuitEvenementTypeDelete">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>