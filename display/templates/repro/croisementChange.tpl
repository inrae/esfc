<script>
$(document).ready(function() {
	$(".taux").attr( {
		pattern: "[0-9]+(\.[0-9]+)?",
		title: "valeur numérique",
		size: "5em",
		maxlength: "10"
	});

	$(".nombre").attr( { 
		pattern: "[0-9]+",
		title: "valeur numérique",
		size: "5em", 
		maxlength: "10"
	});
	$(".timepicker").timepicker( {
		timeFormat: "HH:mm:ss",
//		$.timepicker.regional['fr'],
		stepHour: "1",
		stepMinute: "5",
		size: "5",
		pattern: "[0-9][0-9]\:[0-9][0-9]\:[0-9][0-9]"
	} );
	$(".date").datepicker( { dateFormat: "dd/mm/yy" } );
	$(".commentaire").attr("size","30");
} );
</script>
<a href="index.php?module=sequenceList">
Retour à la liste des séquences
</a>
&nbsp;
<a href="index.php?module=sequenceDisplay&sequence_id={$data.sequence_id}">
Retour à la séquence
</a>
{include file="repro/sequenceDetail.tpl"}
<div class="formSaisie">
<div>
<form id="croisementForm" method="post" action="index.php?module=croisementWrite">
<input type="hidden" name="croisement_id" value="{$data.croisement_id}">
<input type="hidden" name="sequence_id" value="{$data.sequence_id}">
<dl>
<dt>Date/heure de la fécondation <span class="red">*</span> :</dt>
<dd>
<input class="date" name="croisement_date" required size="10" maxlength="10" value="{$data.croisement_date}">
<input class="timepicker" name="croisement_time" required value="{$data.croisement_time}">
</dd>
</dl>
<dl>
<dt>Nom du croisement <span class="red">*</span> :</dt>
<dd>
<input class="commentaire" name="croisement_nom" value={$data.croisement_nom}>
</dd>
</dl>
<dl>
<dt>Masse des ovocytes :</dt>
<dd><input class="taux" name="ovocyte_masse" value="{$data.ovocyte_masse}">
</dd>
</dl>
<dl>
<dt>Nbre ovocytes par gramme :</dt>
<dd><input class="taux" name="ovocyte_densite" value="{$data.ovocyte_densite}">
</dd>
</dl>
<dl>
<dt>Taux de fécondation :</dt>
<dd><input class="taux" name="tx_fecondation" value="{$data.tx_fecondation}">
</dd>
</dl>
<dl>
<dt>Taux de survie estimé :</dt>
<dd><input class="taux" name="tx_survie_estime" value="{$data.tx_survie_estime}">
</dd>
</dl>
<dl>
<dt>Qualité génétique du croisement :</dt>
<dd>
<select name="croisement_qualite_id" >
<option value="" {if $data.croisement_qualite_id == ''}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$croisementQualite}
<option value="{$croisementQualite[lst].croisement_qualite_id}" {if $data.croisement_qualite_id == $croisementQualite[lst].croisement_qualite_id}selected{/if}>
{$croisementQualite[lst].croisement_qualite_libelle}
</option>
{/section}
</select>
</dl>
<dl>
<dt>Poissons utilisés pour la reproduction :</dt>
<dd>
<table>
<tr>
<th>Poisson</th>
<th>Sexe</th>
<th>Sélectionné</th>
</tr>
{section name=lst loop=$poissonSequence}
<tr>
<td>{$poissonSequence[lst].matricule} {$poissonSequence[lst].prenom} {$poissonSequence[lst].pittag_valeur}</td>
<td class="center">{$poissonSequence[lst].sexe_libelle_court}</td>
<td class="center">
<input name="poisson_campagne_id[]" type="checkbox" value="{$poissonSequence[lst].poisson_campagne_id}" {if $poissonSequence[lst].selected == 1}checked{/if}>
</td>
</tr>
{/section}
</table>
</dd>
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.controle_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="controleDelete">
<input type="hidden" name="controle_id" value="{$data.controle_id}">
<input type="hidden" name="sequence_id" value="{$data.sequence_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>