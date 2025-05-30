<script>
	$(document).ready(function () {
		$("input[type='text']").change(function () {
			// Check input( $( this ).val() ) for validity here
			var name = $(this).attr('name');
			var valeur = $(this).val();
			if (name == "nh4") {
				if (valeur > 0) {
					$("#n_nh4").val(valeur * 0.77648);
				}
			} else if (name == "n_nh4") {
				if (valeur > 0) {
					$("#nh4").val(valeur * 1.28786);
				}
			} else if (name == 'no2') {
				if (valeur > 0) {
					$('#n_no2').val(valeur * 0.300447);
				}
			} else if (name == 'n_no2') {
				if (valeur > 0) {
					$("#no2").val(valeur * 3.28443);
				}
			} else if (name == "no3") {
				if (valeur > 0) {
					$("#n_no3").val(valeur * 0.22590);
				}
			} else if (name == "n_no3") {
				if (valeur > 0) {
					$("#no3").val(valeur * 4.42664);
				}
			} else if (name == "riviere_mls") {
				if (valeur > 0) {
					$("#debit_eau_riviere").val(Math.floor(valeur * 6 / 100));
				}
			} else if (name == "mer_mls") {
				if (valeur > 0) {
					$("#debit_eau_mer").val(Math.floor(valeur * 6 / 100));
				}
			} else if (name == "forage_mls") {
				if (valeur > 0) {
					$("#debit_eau_forage").val(Math.floor(valeur * 6 / 100));
				}
			}
		});
	});
</script>

<h2>{t}Saisie-modification d'une analyse d'eau{/t}</h2>
<a href="circuitEauList?circuit_eau_id={$data.circuit_eau_id}">
	{t}Retour à la liste des circuits d'eau{/t}
</a> >
<a href="circuitEauDisplay?circuit_eau_id={$data.circuit_eau_id}">
	{t}Retour au circuit d'eau{/t} {$dataCircuitEau.circuit_eau_libelle}
</a>
<div class="row">
	<div class="col-md-6">
		<form class="form-horizontal" id="analyseEauForm" method="post" action="analyseEauWrite{$origine}">
			<input type="hidden" name="analyse_eau_id" value="{$data.analyse_eau_id}">
			<input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
			<div class="form-group center">
				<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
			</div>
			<div class="form-group">
				<label for="" class="control-label col-md-4">{t}Date d'analyse :{/t}<span class="red">*</span></label>
				<div class="col-md-8">
					<input class="form-control datetimepicker" id="canalyse_eau_date" name="analyse_eau_date"
						value="{$data.analyse_eau_date}" required>
				</div>
			</div>
			<div class="form-group">
				<label for="temperature" class="control-label col-md-4">{t}Température :{/t}</label>
				<div class="col-md-8">
					<input id="temperature" class="form-control" name="temperature" value="{$data.temperature}"
						class="taux">
				</div>
			</div>
			<div class="form-group">
				<label for="oxygene" class="control-label col-md-4">{t}Oxygène (mg/l) :{/t}</label>
				<div class="col-md-8">
					<input id="oxygene" class="form-control" name="oxygene" value="{$data.oxygene}" class="taux">
				</div>
			</div>
			<div class="form-group">
				<label for="o2_pc" class="control-label col-md-4">{t}Oxygène (% sat) :{/t}</label>
				<div class="col-md-8">
					<input id="o2_pc" class="form-control" name="o2_pc" value="{$data.o2_pc}" class="taux">
				</div>
			</div>
			<div class="form-group">
				<label for="salinite" class="control-label col-md-4">{t}salinité :{/t}</label>
				<div class="col-md-8">
					<input id="salinite" class="form-control" name="salinite" value="{$data.salinite}" class="taux">
				</div>
			</div>
			<div class="form-group">
				<label for="ph" class="control-label col-md-4">{t}pH :{/t}</label>
				<div class="col-md-8">
					<input id="ph" class="form-control" name="ph" value="{$data.ph}" class="taux">
				</div>
			</div>

			<div class="form-group">
				<label for="laboratoire_analyse_id" class="control-label col-md-4">{t}Laboratoire : {/t}</label>
				<div class="col-md-8">
					<select id="laboratoire_analyse_id" class="form-control" name="laboratoire_analyse_id">
						<option value="">{t}Sélectionnez le laboratoire...{/t}</option>
						{section name=lst loop=$laboratoire}
						<option value="{$laboratoire[lst].laboratoire_analyse_id}" {if
							$data.laboratoire_analyse_id==$laboratoire[lst].laboratoire_analyse_id}selected{/if}>
							{$laboratoire[lst].laboratoire_analyse_libelle}
						</option>
						{/section}
					</select>
				</div>
			</div>

			<div class="form-group">
				<label for="nh4" class="control-label col-md-4">{t}NH4 : {/t}</label>
				<div class="col-md-8">
					<input class="form-control" type='text' id="nh4" name="nh4" value="{$data.nh4}" class="taux">
				</div>
			</div>
			<div class="form-group">
				<label for="n_nh4" class="control-label col-md-4">{t}N-NH4 : {/t}</label>
				<div class="col-md-8">
					<input class="form-control" type='text' id="n_nh4" name="n_nh4" value="{$data.n_nh4}" class="taux">
				</div>
			</div>
			<div class="form-group">
				<label for="nh4_seuil" class="control-label col-md-4">{t}NH4 - valeur seuil : {/t}</label>
				<div class="col-md-8">
					<input class="form-control" id="nh4_seuil" name="nh4_seuil" value="{$data.nh4_seuil}">
				</div>
			</div>
			<div class="form-group">
				<label for="no2" class="control-label col-md-4">{t}NO2 :{/t}</label>
				<div class="col-md-8">
					<input class="form-control" type='text' id="no2" name="no2" value="{$data.no2}" class="taux">
				</div>
			</div>
			<div class="form-group">
				<label for="n_no2" class="control-label col-md-4">{t}N-NO2 :{/t}</label>
				<div class="col-md-8">
					<input class="form-control" type='text' id="n_no2" name="n_no2" value="{$data.n_no2}" class="taux">
				</div>
			</div>
			<div class="form-group">
				<label for="no2_seuil" class="control-label col-md-4">{t}NO2 - valeur seuil :{/t}</label>
				<div class="col-md-8">
					<input class="form-control" id="no2_seuil" name="no2_seuil" value="{$data.no2_seuil}">
				</div>
			</div>
			<div class="form-group">
				<label for="no3" class="control-label col-md-4">{t}NO3 :{/t}</label>
				<div class="col-md-8">
					<input class="form-control" type='text' id="no3" name="no3" value="{$data.no3}" class="taux">
				</div>
			</div>
			<div class="form-group">
				<label for="n_no3" class="control-label col-md-4">{t}N-NO3:{/t}</label>
				<div class="col-md-8">
					<input class="form-control" type='text' id="n_no3" name="n_no3" value="{$data.n_no3}" class="taux">
				</div>
			</div>
			<div class="form-group">
				<label for="no3_seuil" class="control-label col-md-4">{t}NO3 - valeur seuil :{/t}</label>
				<div class="col-md-8">
					<input class="form-control" id="no3_seuil" name="no3_seuil" value="{$data.no3_seuil}">
				</div>
			</div>
			<div class="form-group">
				<label for="" class="control-label col-md-4">{t}Backwash mécanique :{/t}</label>
				<div class="col-md-8">
					<label class="radio-inline"><input type="radio" name="backwash_mecanique" value="1" {if
							$data.backwash_mecanique==1}checked{/if}>{t}Oui{/t}</label>
					<label class="radio-inline"><input type="radio" name="backwash_mecanique" value="0" {if
							$data.backwash_mecanique==0}checked{/if}>{t}Non{/t}</label>
				</div>
			</div>
			<div class="form-group">
				<label for="" class="control-label col-md-4">{t}Backwash biologique :{/t}</label>
				<div class="col-md-8">
					<label class="radio-inline"><input type="radio" name="backwash_biologique" value="1" {if
							$data.backwash_biologique==1}checked{/if}>{t}Oui{/t}</label>
					<label class="radio-inline"><input type="radio" name="backwash_biologique" value="0" {if
							$data.backwash_biologique==0}checked{/if}>{t}Non{/t}</label>
				</div>
			</div>
			<div class="form-group">
				<label for="" class="control-label col-md-4">{t}Commentaire backwash bio :{/t}</label>
				<div class="col-md-8">
					<input class="form-control" name="backwash_biologique_commentaire"
						value="{$data.backwash_biologique_commentaire}" class="commentaire">
				</div>
			</div>
			<div class="form-group">
				<label for="" class="control-label col-md-4">{t}Débit d'eau de rivière (l/mn) :{/t}</label>
				<div class="col-md-8">
					<input class="form-control taux" id="debit_eau_riviere" name="debit_eau_riviere"
						value="{$data.debit_eau_riviere}">
					<input type='text' id="riviere_mls" name="riviere_mls" class="form-control taux" placeholder="ml/s">
				</div>
			</div>
			<div class="form-group">
				<label for="" class="control-label col-md-4">{t}Débit d'eau de forage (l/mn) : {/t}</label>
				<div class="col-md-8">
					<input class="form-control" id="debit_eau_forage" name="debit_eau_forage"
						value="{$data.debit_eau_forage}" class="taux">
					<input type='text' id="forage_mls" name="forage_mls" class="form-control taux" placeholder="ml/s">
				</div>
			</div>
			<div class="form-group">
				<label for="" class="control-label col-md-4">{t}Débit d'eau de mer (l/mn) : {/t}</label>
				<div class="col-md-8">
					<input class="form-control" id="debit_eau_mer" name="debit_eau_mer" value="{$data.debit_eau_mer}"
						class="taux">
					<input type='text' id="mer_mls" name="mer_mls" class="form-control taux" placeholder="ml/s">
				</div>
			</div>
			<div class="form-group"></div>
			<fieldset>
				<legend>{t}Analyse des métaux lourds{/t}</legend>
				{section name=lst loop=$dataMetal}
				<div class="form-group">
					<label for="" class="control-label col-md-4">
						{t}{$dataMetal[lst].metal_nom} ({$dataMetal[lst].metal_unite}) :{/t}
					</label>
					<div class="col-md-8">
						<input class="form-control taux"
							name="mesure-{$dataMetal[lst].analyse_metal_id}-{$dataMetal[lst].metal_id}"
							value="{$dataMetal[lst].mesure}">
						<input name="mesure_seuil-{$dataMetal[lst].analyse_metal_id}-{$dataMetal[lst].metal_id}"
							value="{$dataMetal[lst].mesure_seuil}" placeholder="valeur seuil" class="form-control taux">

					</div>
					{/section}
			</fieldset>
			<div class="form-group">
				<label for="" class="control-label col-md-4">{t}Observations :{/t}</label>
				<div class="col-md-8">
					<input class="form-control" name="observations" value="{$data.observations}" class="commentaire">
				</div>

				<div class="form-group center">
					<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
					{if $data.analyse_eau_id > 0 &&$rights["bassinAdmin"] == 1}
					<button id="delete" class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
					{/if}
				</div>
			</div>
		{$csrf}</form>
	</div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>