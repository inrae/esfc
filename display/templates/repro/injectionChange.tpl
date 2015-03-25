<script>
$(document).ready(function() {
	$(".taux").attr( {
		pattern: "[0-9]+(\.[0-9]+)?",
		title: "valeur numérique",
		size: "10",
		maxlength: "10"
	});
	$( ".date" ).datepicker( { 
		dateFormat: "dd/mm/yy",
		parseTime: "dd/mm/yy hh:mm:ss" } );
	$(".time").attr( {
		pattern: "[0-9][0-9]\:[0-9][0-9]",
		placeholder: "hh:mm",
		size: "5"
	} );
	$(".timepicker").timepicker( {
		timeFormat: "HH:mm:ss",
//		$.timepicker.regional['fr'],
		stepHour: "1",
		stepMinute: "5",
		size: "5"
	} );
	$(".commentaire").attr("size","30");
});
</script>
<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2>Modification d'une injection</h2>
<div class="formSaisie">
<div>
<form id="injectionForm" method="post" action="index.php?module=injectionWrite">
<input type="hidden" name="injection_id" value="{$data.injection_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<dl>
<dt>Date de l'injection <span class="red">*</span> :</dt>
<dd>
<input class="date" name="injection_date" required size="10" maxlength="10" value="{$data.injection_date}">
<input class="timepicker" name="injection_time" required value="{$data.injection_time}">
</dd>
</dl>
<dl>
<dt>Séquence de reproduction <span class="red">*</span> :</dt>
<dd>
<select name="sequence_id">
{section name=lst loop=$sequences}
<option value="{$sequences[lst].sequence_id}" {if $data.sequence_id == $sequences[lst].sequence_id}selected{/if}>
{$sequences[lst].sequence_nom}
</option>
{/section}
</select>
</dl>
<dl>
<dt>Hormone utilisée :</dt>
<dd>
<select name="hormone_id">
<option value="" {if $data.hormone_id==""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$hormones}
<option value="{$hormones[lst].hormone_id}" {if $data.hormone_id == $hormones[lst].hormone_id}selected{/if}>
{$hormones[lst].hormone_nom} - unité : {$hormones[lst].hormone_unite}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Dose injectée :</dt>
<dd>
<input class="taux" name="injection_dose" value="{$data.injection_dose}"></dl>
<dl>
<dt>Commentaire :</dt>
<dd>
<input class="commentaire" name="injection_commentaire" value="{$data.injection_commentaire}">
</dd>
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.injection_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="injectionDelete">
<input type="hidden" name="injection_id" value="{$data.injection_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>