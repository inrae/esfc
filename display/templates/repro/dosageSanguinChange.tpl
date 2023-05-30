<script>
$(document).ready(function() {
	$(".taux").attr( {
		pattern: "[0-9]+(\.[0-9]+)?",
		title: "valeur numérique",
		size: "10",
		maxlength: "10"
	});
	$( ".date" ).datepicker( { dateFormat: "dd/mm/yy" } );
});
</script>
<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2>{t}Modification d'un dosage sanguin{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="dosageSanguinForm" method="post" action="index.php?module=dosageSanguinWrite">
<input type="hidden" name="dosage_sanguin_id" value="{$data.dosage_sanguin_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<fieldset>
<legend>{t}Dosage sanguin{/t}</legend>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date du prélèvement :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" class="date" name="dosage_sanguin_date" required size="10" maxlength="10" value="{$data.dosage_sanguin_date}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Taux E2 :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="tx_e2" value="{$data.tx_e2}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Taux E2 (forme textuelle, pour des fourchettes ou des tendances) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="tx_e2_texte" size="20" value="{$data.tx_e2_texte}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Taux de calcium :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="tx_calcium" value="{$data.tx_calcium}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Taux d'hématocrite :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="tx_hematocrite" value="{$data.tx_hematocrite}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Commentaires :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="dosage_sanguin_commentaire" size="30" value="{$data.dosage_sanguin_commentaire}">
</div>
</fieldset>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.dosage_sanguin_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="dosageSanguinDelete">
<input type="hidden" name="dosage_sanguin_id" value="{$data.dosage_sanguin_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
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
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>