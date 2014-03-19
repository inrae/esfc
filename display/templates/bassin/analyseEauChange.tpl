<script>
$(document).ready(function() { 
$( "#canalyse_eau_date" ).datepicker( { dateFormat: "dd/mm/yy" } );
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
<table class="tablesaisie">
<form id="analyseEauForm" method="post" action="index.php?module=analyseEauWrite{$origine}">
<input type="hidden" name="analyse_eau_id" value="{$data.analyse_eau_id}">
<input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
<tr>
<td class="libelleSaisie">Date d'analyse <span class="red">*</span> : </td>
<td><input id="canalyse_eau_date" name="analyse_eau_date" value="{$data.analyse_eau_date}" required size="10"></td>
</tr>
<tr>
<td class="libelleSaisie">Température : </td>
<td><input name="temperature" value="{$data.temperature}" pattern="[0-9]+(\.[0-9]+)?" title="valeur numérique" size="5"></td>
</tr>
<tr>
<td class="libelleSaisie">Oxygène : </td>
<td><input name="oxygene" value="{$data.oxygene}" pattern="[0-9]+(\.[0-9]+)?" title="valeur numérique" size="5"></td>
</tr>
<tr>
<td class="libelleSaisie">salinité : </td>
<td><input name="salinite" value="{$data.salinite}" pattern="[0-9]+(\.[0-9]+)?" title="valeur numérique" size="5"></td>
</tr>
<tr>
<td class="libelleSaisie">pH : </td>
<td><input name="ph" value="{$data.ph}" pattern="[0-9]+(\.[0-9]+)?" title="valeur numérique" size="5"></td>
</tr>

<tr>
<td class="libelleSaisie">NH4 : </td>
<td><input type='text' id="nh4" name="nh4" value="{$data.nh4}" pattern="[0-9]+(\.[0-9]+)?" title="valeur numérique" size="5"></td>
</tr>
<tr>
<td class="libelleSaisie">N-NH4 : </td>
<td><input type='text' id="n_nh4" name="n_nh4" value="{$data.n_nh4}" pattern="[0-9]+(\.[0-9]+)?" title="valeur numérique" size="5"></td>
</tr>
<tr>
<td class="libelleSaisie">NH4 - valeur seuil : </td>
<td><input id="nh4_seuil" name="nh4_seuil" value="{$data.nh4_seuil}"  size="10"></td>
</tr>
<tr>
<td class="libelleSaisie">NO2 : </td>
<td><input type='text' id="no2" name="no2" value="{$data.no2}" pattern="[0-9]+(\.[0-9]+)?" title="valeur numérique" size="5"></td>
</tr>
<tr>
<td class="libelleSaisie">N-NO2 : </td>
<td><input type='text' id="n_no2" name="n_no2" value="{$data.n_no2}" pattern="[0-9]+(\.[0-9]+)?" title="valeur numérique" size="5"></td>
</tr>
<tr>
<td class="libelleSaisie">NO2 - valeur seuil : </td>
<td><input id="no2_seuil" name="no2_seuil" value="{$data.no2_seuil}" size="10"></td>
</tr>
<tr>
<td class="libelleSaisie">NO3 : </td>
<td><input type='text' id="no3" name="no3" value="{$data.no3}" pattern="[0-9]+(\.[0-9]+)?" title="valeur numérique" size="5"></td>
</tr>
<tr>
<td class="libelleSaisie">N-NO3: </td>
<td><input type='text' id="n_no3" name="n_no3" value="{$data.n_no3}" pattern="[0-9]+(\.[0-9]+)?" title="valeur numérique" size="5"></td>
</tr>
<tr>
<td class="libelleSaisie">NO3 - valeur seuil : </td>
<td><input id="no3_seuil" name="no3_seuil" value="{$data.no3_seuil}" size="10"></td>
</tr>
<tr>
<td class="libelleSaisie">Backwash mécanique : </td>
<td>
<input type="radio" name="backwash_mecanique" value="1" {if $data.backwash_mecanique == 1}checked{/if}>Oui
<input type="radio" name="backwash_mecanique" value="0" {if $data.backwash_mecanique == 0}checked{/if}>Non
</td>
</tr>
<tr>
<td class="libelleSaisie">Baskwash biologique : </td>
<td><input name="backwash_biologique" value="{$data.backwash_biologique}" size="40"></td>
</tr>
<tr>
<td class="libelleSaisie">Débit d'eau de rivière (l/mn) : </td>
<td><input id="debit_eau_riviere" name="debit_eau_riviere" value="{$data.debit_eau_riviere}" pattern="[0-9]+(\.[0-9]+)?" title="valeur numérique" size="5"></td>
</tr>
<tr>
<td class="libelleSaisie">Débit d'eau de forage (l/mn) : </td>
<td><input id="debit_eau_forage" name="debit_eau_forage" value="{$data.debit_eau_forage}" pattern="[0-9]+(\.[0-9]+)?" title="valeur numérique" size="5"></td>
</tr>
<tr>
<td class="libelleSaisie">Observations : </td>
<td><input name="observations" value="{$data.observations}" size="40"></td>
</tr>

<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
</form>

{if $data.analyse_eau_id > 0 &&$droits["admin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="analyse_eau_id" value="{$data.analyse_eau_id}">
<input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
<input type="hidden" name="module" value="analyseEauDelete{$origine}">
<input class="submit" type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>
