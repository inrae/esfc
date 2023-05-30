<a href="index.php?module=circuitEauList">Retour à la liste des circuits d'eau</a>
> <a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data.circuit_eau_id}">Retour au circuit d'eau</a>
<h2{t}Modification d'un événement survenu dans le circuit d'eau {$dataCircuit.circuit_eau_libelle}{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="circuitEvenementForm" method="post" action="index.php?module=circuitEvenementWrite">
<input type="hidden" name="circuit_evenement_id" value="{$data.circuit_evenement_id}">
<input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Type d'événement <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="circuit_evenement_type_id">
{section name=lst loop=$dataEvntType}
<option value="{$dataEvntType[lst].circuit_evenement_type_id}" {if $dataEvntType[lst].circuit_evenement_type_id == $data.circuit_evenement_type_id}selected{/if}>
{$dataEvntType[lst].circuit_evenement_type_libelle}
</option>
{/section}
</select>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="date" name="circuit_evenement_date" value="{$data.circuit_evenement_date}">
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Commentaires :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="circuit_evenement_commentaire" value="{$data.circuit_evenement_commentaire}" style="size:40;">

</div>


<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>

{if $data.circuit_evenement_id > 0 &&$droits["bassinAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="circuit_evenement_id" value="{$data.circuit_evenement_id}">
<input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
<input type="hidden" name="module" value="circuitEvenementDelete">
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