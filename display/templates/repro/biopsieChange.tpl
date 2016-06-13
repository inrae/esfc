<script>
$(document).ready(function() {
	$(".taux").attr( {
		pattern: "[0-9]+(\.[0-9]+)?",
		title: "valeur numérique",
		size: "5em",
		maxlength: "10"
	});
	$(".date").datepicker( { dateFormat: "dd/mm/yy" } );
	$(".time").attr( {
		pattern: "[0-9][0-9]\:[0-9][0-9]",
		placeholder: "hh:mm",
		size: "5em",
		autocomplete: "false"
	});
	$(".timepicker").timepicker( {
		timeFormat: "HH:mm:ss",
//		$.timepicker.regional['fr'],
		stepHour: "1",
		stepMinute: "5",
		size: "5",
		pattern: "[0-9][0-9]\:[0-9][0-9]\:[0-9][0-9]"
	} );
	$(".commentaire").attr("size","30");
});
</script>
<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2>Modification d'une biopsie</h2>
<div class="formSaisie">
<div>
<form id="biopsieForm" method="post" action="index.php?module=biopsieWrite" enctype="multipart/form-data" >
<input type="hidden" name="biopsie_id" value="{$data.biopsie_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<dl>
<dt>Date du prélèvement <span class="red">*</span> :</dt>
<dd>
<input class="datetimepicker" name="biopsie_date" required value="{$data.biopsie_date}">
</dd>
</dl>
<dl>
<dt>Diamètre moyen (mm) :</dt>
<dd>
<input class="taux" name="diam_moyen" value="{$data.diam_moyen}">
</dd>
</dl>
<dl>
<dt>Écart type du diamètre moyen :</dt>
<dd>
<input class="taux" name="diametre_ecart_type" value="{$data.diametre_ecart_type}">
</dd>
</dl>
<dl>
<dt>Technique de mesure utilisée :</dt>
<dd>
<select name="biopsie_technique_calcul_id">
<option value="" {if $data.biopsie_technique_calcul_id == ""}selected{/if}>
Sélectionnez...
</option>
{section name=lst loop=$techniqueCalcul}
<option value="{$techniqueCalcul[lst].biopsie_technique_calcul_id}" {if $techniqueCalcul[lst].biopsie_technique_calcul_id == $data.biopsie_technique_calcul_id}selected{/if}>
{$techniqueCalcul[lst].biopsie_technique_calcul_libelle}
</option>
{/section}
</select>
</dl>
<dl>
<dt>Image utilisée pour le calcul du diamètre :
</dt>
<dt><input type="file" name="documentName[]" size="40" multiple></dt>
</dl>
<dl>
<dt>Taux OPI :</dt>
<dd>
<input class="taux" name="tx_opi" value="{$data.tx_opi}">
</dd>
</dl>
<dl>
<dt>Taux de coloration normale :</dt>
<dd>
<input class="taux" name="tx_coloration_normal" value="{$data.tx_coloration_normal}">
</dd>
</dl>
<dl>
<dt>Taux d'éclatement :</dt>
<dd>
<input class="taux" name="tx_eclatement" value="{$data.tx_eclatement}">
</dd>
</dl>
<fieldset>
<legend>Maturation Ringer</legend>
<dl>
<dt>T50 :</dt>
<dd>
<input class="time" name="ringer_t50" value="{$data.ringer_t50}">
</dd>
</dl>
<dl>
<dt>% maximal de maturation observé :</dt>
<dd>
<input class="taux" name="ringer_tx_max" value="{$data.ringer_tx_max}">
 en 
 <input class="time" name="ringer_duree" value="{$data.ringer_duree}">
</dd>
</dl>
<dl>
<dt>Commentaires :</dt>
<dd>
<input class="commentaire" name="ringer_commentaire" value="{$data.ringer_commentaire}">
</dd>
</dl>
</fieldset>
<fieldset>
<legend>Maturation Leibovitz</legend>
<dl>
<dt>T50 :</dt>
<dd>
<input class="time" name="leibovitz_t50" value="{$data.leibovitz_t50}">
</dd>
</dl><dl>
<dt>% maximal de maturation observé :</dt>
<dd>
<input class="taux" name="leibovitz_tx_max" value="{$data.leibovitz_tx_max}">
 en 
 <input class="time" name="leibovitz_duree" value="{$data.leibovitz_duree}">
</dd>
</dl>
<dl>
<dt>Commentaires :</dt>
<dd>
<input class="commentaire" name="leibovitz_commentaire" value="{$data.leibovitz_commentaire}">
</dd>
</dl>
</fieldset>
<dl>
<dt>Commentaire général :</dt>
<dd>
<input class="commentaire" name="biopsie_commentaire" value="{$data.biopsie_commentaire}">
</dd>
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.biopsie_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="biopsieDelete">
<input type="hidden" name="biopsie_id" value="{$data.biopsie_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
{if $data.biopsie_id > 0}

<h3>Documents associés</h3>
{include file="document/documentListOnly.tpl"}
{/if}
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>