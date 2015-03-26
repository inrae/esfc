<script>
$(document).ready(function() {
	$(".taux").attr( {
		pattern: "[0-9]+(\.[0-9]+)?",
		title: "valeur numérique",
		size: "10",
		maxlength: "10"
	});
	$(".numeric").attr( {
		pattern: "[0-9]+",
		title: "valeur numérique",
		size: "5",
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
<a href="index.php?module={$poissonDetailParent}&sperme_qualite_id={$sperme_qualite_id}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2>Modification d'un prélèvement de sperme</h2>
<div class="formSaisie">
<div>
<form id="spermeForm" method="post" action="index.php?module=spermeWrite">
<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<dl>
<dt>Date du prélèvement <span class="red">*</span> :</dt>
<dd>
<input class="date" name="sperme_date" required size="10" maxlength="10" value="{$data.sperme_date}">
<input class="timepicker" name="sperme_time" required value="{$data.sperme_time}">
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
<dt>Qualité globale :</dt>
<dd>
<select name="sperme_qualite_id">
<option value="" {if $data.sperme_qualite_id == ""}selected{/if}>
Sélectionnez...
</option>
{section name=lst loop=$spermeQualites}
<option value="{$spermeQualites[lst].sperme_qualite_id}" {if $data.sperme_qualite_id == $spermeQualites[lst].sperme_qualite_id}selected{/if}>
{$spermeQualites[lst].sperme_qualite_libelle}
</option>
{/section}
</select>
</dl>


<dl>
<dt>Motilité initiale (1 à 5) :</dt>
<dd>
<input class="taux" name="motilite_initiale" value="{$data.motilite_initiale}">
</dd>
</dl>
<dl>
<dt>Taux de survie (en %) :</dt>
<dd>
<input class="taux" name="tx_survie_initial" value="{$data.tx_survie_initial}">
</dd>
</dl>
<dl>
<dt>Motilité à 60" (1 à 5):</dt>
<dd>
<input class="taux" name="motilite_60" value="{$data.motilite_60}">
</dd>
</dl>
<dl>
<dt>taux de survie à 60" (en %) :</dt>
<dd>
<input class="taux" name="tx_survie_60" value="{$data.tx_survie_60}">
</dd>
</dl>
<dl>
<dt>Temps de survie à 5%<br>(en secondes) :</dt>
<dd>
<input class="numeric" name="temps_survie" value="{$data.temps_survie}">
</dd>
</dl>
<dl>
<dt>Commentaire :</dt>
<dd>
<input class="commentaire" name="sperme_commentaire" value="{$data.sperme_commentaire}">
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.sperme_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="spermeDelete">
<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>