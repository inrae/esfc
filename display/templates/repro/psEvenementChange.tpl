<script>
 
$(document).ready(function() { 
$( ".date" ).datepicker( { dateFormat: "dd/mm/yy" } );
$(".timepicker").timepicker( {
	timeFormat: "HH:mm:ss",
//	$.timepicker.regional['fr'],
	stepHour: "1",
	stepMinute: "10",
	size: "5"
} );
} );
</script>

<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="psEvenementForm" method="post" action="index.php?module=psEvenementWrite">
<input type="hidden" name="poisson_sequence_id" value="{$dataPsEvenement.poisson_sequence_id}">
<input type="hidden" name="ps_evenement_id" value="{$dataPsEvenement.ps_evenement_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="date" name="ps_date" required value="{$dataPsEvenement.ps_date}">
<input class="timepicker" name="ps_time" required value="{$dataPsEvenement.ps_time}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Libellé <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="commentaire" name="ps_libelle" required value="{$dataPsEvenement.ps_libelle}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Commentaire :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="commentaire" name="ps_commentaire" value="{$dataPsEvenement.ps_commentaire}">
</dd>
</div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.ps_evenement_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="psEvenementDelete">
<input type="hidden" name="poisson_sequence_id" value="{$data.poisson_sequence_id}">
<input type="hidden" name="ps_evenement_id" value="{$data.ps_evenement_id}">
<input type="hidden" name="sequence_id" value="{$sequence_id}">
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