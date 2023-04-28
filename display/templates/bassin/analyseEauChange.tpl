<script>
$(document).ready(function() { 
$( "input[type='text']" ).change(function() {
	  // Check input( $( this ).val() ) for validity here
	var name = $(this).attr('name');
	var valeur = $( this ).val() ;
	if (name == "nh4") {
		if (valeur > 0) {
			$("#n_nh4").val( valeur * 0.77648 );
		}
	} else if (name == "n_nh4") {
		if (valeur > 0) {
			$("#nh4").val( valeur * 1.28786 );
		}
	} else if (name == 'no2') {
		if (valeur > 0) {
			$('#n_no2').val( valeur * 0.300447 );
		}
	} else if (name == 'n_no2') {
		if (valeur > 0) {
			$("#no2").val( valeur * 3.28443 );
		}
	} else if (name == "no3") {
		if (valeur > 0) {
			$("#n_no3").val( valeur * 0.22590 );
		}
	} else if (name == "n_no3") {
		if (valeur > 0) {
			$("#no3").val( valeur * 4.42664 );
		}
	} else if (name == "riviere_mls") {
		if (valeur > 0) {
			$("#debit_eau_riviere").val(Math.floor(valeur * 6 / 100));
		}
	}else if (name == "mer_mls") {
		if (valeur > 0) {
			$("#debit_eau_mer").val(Math.floor(valeur * 6 / 100));
		}
	}else if (name == "forage_mls") {
		if (valeur > 0) {
			$("#debit_eau_forage").val(Math.floor(valeur * 6 / 100));
		}
	}
	} );
} );
</script>

<h2>Saisie-modification d'une analyse d'eau</h2>
<a href="index.php?module=circuitEauList&circuit_eau_id={$data.circuit_eau_id}">
Retour à la liste des circuits d'eau
</a> > 
<a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data.circuit_eau_id}">
Retour au circuit d'eau {$dataCircuitEau.circuit_eau_libelle}
</a>
<div class="formSaisie">
<div>
<form id="analyseEauForm" method="post" action="index.php?module=analyseEauWrite{$origine}">
<input type="hidden" name="analyse_eau_id" value="{$data.analyse_eau_id}">
<input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
<dl>
<dt>Date d'analyse <span class="red">*</span> : </dt>
<dd><input class="datetimepicker" id="canalyse_eau_date" name="analyse_eau_date" value="{$data.analyse_eau_date}" required size="10">
</dd></dl>
<dl>
<dt>Température : </dt>
<dd><input name="temperature" value="{$data.temperature}" class="taux">
</dd></dl>
<dl>
<dt>Oxygène (mg/l) : </dt>
<dd><input name="oxygene" value="{$data.oxygene}" class="taux">
</dd>
</dl>
<dl>
<dt>Oxygène (% sat) : </dt>
<dd><input name="o2_pc" value="{$data.o2_pc}" class="taux">
</dd>
</dl>
<dl>
<dt>salinité : </dt>
<dd><input name="salinite" value="{$data.salinite}" class="taux">
</dd></dl>
<dl>
<dt>pH : </dt>
<dd><input name="ph" value="{$data.ph}" class="taux">
</dd></dl>

<dl>
<dt>Laboratoire : </dt>
<dd>
<select name="laboratoire_analyse_id">
<option value="">Sélectionnez le laboratoire...</option>
{section name=lst loop=$laboratoire}
<option value="{$laboratoire[lst].laboratoire_analyse_id}" {if $data.laboratoire_analyse_id == $laboratoire[lst].laboratoire_analyse_id}selected{/if}>
{$laboratoire[lst].laboratoire_analyse_libelle}
</option>
{/section}
</select>
</dd>
</dl>

<dl>
<dt>NH4 : </dt>
<dd><input type='text' id="nh4" name="nh4" value="{$data.nh4}" class="taux">
</dd></dl>
<dl>
<dt>N-NH4 : </dt>
<dd><input type='text' id="n_nh4" name="n_nh4" value="{$data.n_nh4}" class="taux">
</dd></dl>
<dl>
<dt>NH4 - valeur seuil : </dt>
<dd><input id="nh4_seuil" name="nh4_seuil" value="{$data.nh4_seuil}"  size="10">
</dd></dl>
<dl>
<dt>NO2 : </dt>
<dd><input type='text' id="no2" name="no2" value="{$data.no2}" class="taux">
</dd></dl>
<dl>
<dt>N-NO2 : </dt>
<dd><input type='text' id="n_no2" name="n_no2" value="{$data.n_no2}" class="taux">
</dd></dl>
<dl>
<dt>NO2 - valeur seuil : </dt>
<dd><input id="no2_seuil" name="no2_seuil" value="{$data.no2_seuil}" size="10">
</dd></dl>
<dl>
<dt>NO3 : </dt>
<dd><input type='text' id="no3" name="no3" value="{$data.no3}" class="taux">
</dd></dl>
<dl>
<dt>N-NO3: </dt>
<dd><input type='text' id="n_no3" name="n_no3" value="{$data.n_no3}" class="taux">
</dd></dl>
<dl>
<dt>NO3 - valeur seuil : </dt>
<dd><input id="no3_seuil" name="no3_seuil" value="{$data.no3_seuil}" size="10">
</dd></dl>
<dl>
<dt>Backwash mécanique : </dt>
<dd>
<input type="radio" name="backwash_mecanique" value="1" {if $data.backwash_mecanique == 1}checked{/if}>Oui
<input type="radio" name="backwash_mecanique" value="0" {if $data.backwash_mecanique == 0}checked{/if}>Non
</dd></dl>
<dl>
<dt>Backwash biologique : </dt>
<dd>
<input type="radio" name="backwash_biologique" value="1" {if $data.backwash_biologique == 1}checked{/if}>Oui
<input type="radio" name="backwash_biologique" value="0" {if $data.backwash_biologique == 0}checked{/if}>Non
</dd></dl>
<dl>
<dt>Commentaire backwash bio : </dt>
<dd><input name="backwash_biologique_commentaire" value="{$data.backwash_biologique_commentaire}" class="commentaire">
</dd></dl>
<dl>
<dt>Débit d'eau de rivière (l/mn) : </dt>
<dd><input id="debit_eau_riviere" name="debit_eau_riviere" value="{$data.debit_eau_riviere}" class="taux">
<input type='text' id="riviere_mls" name="riviere_mls" class="taux" placeholder="ml/s">
</dd></dl>
<dl>
<dt>Débit d'eau de forage (l/mn) : </dt>
<dd><input id="debit_eau_forage" name="debit_eau_forage" value="{$data.debit_eau_forage}" class="taux">
<input type='text' id="forage_mls" name="forage_mls" class="taux" placeholder="ml/s">
</dd></dl>
<dl>
<dt>Débit d'eau de mer (l/mn) : </dt>
<dd><input id="debit_eau_mer" name="debit_eau_mer" value="{$data.debit_eau_mer}" class="taux">
<input type='text' id="mer_mls" name="mer_mls" class="taux" placeholder="ml/s">
</dd></dl>
<dl></dl>
<fieldset>
<legend>Analyse des métaux lourds</legend>
{section name=lst loop=$dataMetal}
<dl>
<dt>{$dataMetal[lst].metal_nom} ({$dataMetal[lst].metal_unite}) :</dt>
<dd>
<input class="taux" name="mesure-{$dataMetal[lst].analyse_metal_id}-{$dataMetal[lst].metal_id}" value="{$dataMetal[lst].mesure}">
<input name="mesure_seuil-{$dataMetal[lst].analyse_metal_id}-{$dataMetal[lst].metal_id}" value="{$dataMetal[lst].mesure_seuil}" placeholder="valeur seuil">
</dd>
</dl>
{/section}
</fieldset>
<dl>
<dt>Observations : </dt>
<dd><input name="observations" value="{$data.observations}" class="commentaire">
</dd></dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.analyse_eau_id > 0 &&$droits["bassinAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="analyse_eau_id" value="{$data.analyse_eau_id}">
<input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
<input type="hidden" name="module" value="analyseEauDelete{$origine}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>
