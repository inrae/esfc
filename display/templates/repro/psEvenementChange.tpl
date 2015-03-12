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
<form id="psEvenementForm" method="post" action="index.php?module=psEvenementWrite">
<input type="hidden" name="poisson_sequence_id" value="{$dataPsEvenement.poisson_sequence_id}">
<input type="hidden" name="ps_evenement_id" value="{$dataPsEvenement.ps_evenement_id}">
<dl>
<dt>Date <span class="red">*</span> :</dt>
<dd>
<input class="date" name="ps_date" required value="{$dataPsEvenement.ps_date}">
<input class="timepicker" name="ps_time" required value="{$dataPsEvenement.ps_time}">
</dd>
</dl>
<dl>
<dt>Libellé <span class="red">*</span> :</dt>
<dd>
<input class="commentaire" name="ps_libelle" required value="{$dataPsEvenement.ps_libelle}">
</dd>
</dl>
<dl>
<dt>Commentaire :</dt>
<dd>
<input class="commentaire" name="ps_commentaire" value="{$dataPsEvenement.ps_commentaire}">
</dd>
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.ps_evenement_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="psEvenementDelete">
<input type="hidden" name="poisson_sequence_id" value="{$data.poisson_sequence_id}">
<input type="hidden" name="ps_evenement_id" value="{$data.ps_evenement_id}">
<input type="hidden" name="sequence_id" value="{$sequence_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>