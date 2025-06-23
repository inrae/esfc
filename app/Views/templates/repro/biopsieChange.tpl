<script src="display/javascript/jquery.inputmask.js"></script>

<script>
	$(document).ready(function() {
		$(".duration").inputmask("99:99");
	});
</script>
<a href="{$poissonDetailParent}?sequence_id={$sequence_id}">
	<img src="display/images/display.png" height="25">
	{t}Retour à la liste des poissons{/t}
</a>&nbsp;
<a href="poissonCampagneDisplay?poisson_campagne_id={$data.poisson_campagne_id}">
	<img src="display/images/fish.svg" height="25">
	{t}Retour au reproducteur{/t}
</a>
<h2>{t}Modification d'une biopsie{/t} {$dataPoisson.matricule}
	{$dataPoisson.categorie_libelle}
	{$dataPoisson.sexe_libelle}
	{$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})
</h2>

<div class="row">
	<div class="col-md-6">
		<form class="form-horizontal" id="biopsieForm" method="post" action="biopsieWrite" enctype="multipart/form-data">			
			<input type="hidden" name="moduleBase" value="biopsie">
			<input type="hidden" name="biopsie_id" value="{$data.biopsie_id}">
			<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
			<div class="form-group">
				<label for="biopsie_date" class="control-label col-md-4">
					{t}Date du prélèvement :{/t}
					<span class="red">*</span>
				</label>
				<div class="col-md-8">
					<input id="biopsie_date" class="form-control datetimepicker" name="biopsie_date" required
						value="{$data.biopsie_date}">
				</div>
			</div>
			<div class="form-group">
				<label for="diam_moyen" class="control-label col-md-4">
					{t}Diamètre moyen (mm) :{/t}
				</label>
				<div class="col-md-8">
					<input id="" class="form-control taux" name="diam_moyen" value="{$data.diam_moyen}">
				</div>
			</div>
			<div class="form-group">
				<label for="diametre_ecart_type" class="control-label col-md-4">
					{t}Écart type du diamètre moyen :{/t}
				</label>
				<div class="col-md-8">
					<input id="diametre_ecart_type" class="form-control taux" name="diametre_ecart_type"
						value="{$data.diametre_ecart_type}">

				</div>
			</div>
			<div class="form-group">
				<label for="biopsie_technique_calcul_id" class="control-label col-md-4">
					{t}Technique de mesure utilisée :{/t}
				</label>
				<div class="col-md-8">
					<select id="biopsie_technique_calcul_id" class="form-control" name="biopsie_technique_calcul_id">
						<option value="" {if $data.biopsie_technique_calcul_id=="" }selected{/if}>
							{t}Sélectionnez...{/t}
						</option>
						{section name=lst loop=$techniqueCalcul}
						<option value="{$techniqueCalcul[lst].biopsie_technique_calcul_id}" {if
							$techniqueCalcul[lst].biopsie_technique_calcul_id==$data.biopsie_technique_calcul_id}selected{/if}>
							{$techniqueCalcul[lst].biopsie_technique_calcul_libelle}
						</option>
						{/section}
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="documentName" class="control-label col-md-4">
					{t}Image(s) utilisée(s) pour le calcul du diamètre :{/t}</label>
				<div class="col-md-8">
					<input type="file" name="documentName[]" multiple class="form-control">
				</div>
			</div>
			<div class="form-group">
				<label for="tx_opi" class="control-label col-md-4">
					{t}Taux OPI :{/t}
				</label>
				<div class="col-md-8">
					<input id="tx_opi" class="form-control taux" name="tx_opi" value="{$data.tx_opi}">
				</div>
			</div>
			<div class="form-group">
				<label for="tx_coloration_normal" class="control-label col-md-4">
					{t}Taux de coloration normale :{/t}
				</label>
				<div class="col-md-8">
					<input id="tx_coloration_normal" class="form-control taux" name="tx_coloration_normal"
						value="{$data.tx_coloration_normal}">
				</div>
			</div>
			<div class="form-group">
				<label for="tx_eclatement" class="control-label col-md-4">
					{t}Taux d'éclatement :{/t}
				</label>
				<div class="col-md-8">
					<input id="tx_eclatement" class="form-control taux" name="tx_eclatement"
						value="{$data.tx_eclatement}">
				</div>
			</div>
			<fieldset>
				<legend>{t}Maturation Ringer{/t}</legend>
				<div class="form-group">
					<label for="ringer_t50" class="control-label col-md-4">
						{t}T50 (heures) :{/t}
					</label>
					<div class="col-md-8">
						<input id="ringer_t50" class="form-control duration" name="ringer_t50" value="{$data.ringer_t50}">
					</div>
				</div>
				<div class="form-group">
					<label for="ringer_tx_max" class="control-label col-md-4">
						{t}% maximal de maturation observé :{/t}
					</label>
					<div class="col-md-8">
						<div class="form-inline">
							<input id="ringer_tx_max" class="form-control taux" name="ringer_tx_max"
								value="{$data.ringer_tx_max}">
							{t}en (heures){/t}
							<input class="duration form-control" name="ringer_duree" value="{$data.ringer_duree}">
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="ringer_commentaire" class="control-label col-md-4">
						{t}Commentaires :{/t}
					</label>
					<div class="col-md-8">
						<input id="ringer_commentaire" class="form-control" name="ringer_commentaire"
							value="{$data.ringer_commentaire}">
					</div>
				</div>
			</fieldset>
			<fieldset>
				<legend>{t}Maturation Leibovitz{/t}</legend>
				<div class="form-group">
					<label for="leibovitz_t50" class="control-label col-md-4">
						{t}T50 (heures) :{/t}
					</label>
					<div class="col-md-8">
						<input id="leibovitz_t50" class="form-control duration" name="leibovitz_t50"
							value="{$data.leibovitz_t50}">
					</div>
				</div>
				<div class="form-group">
					<label for="leibovitz_tx_max" class="control-label col-md-4">
						{t}% maximal de maturation observé :{/t}
					</label>
					<div class="col-md-8">
						<div class="form-inline">
							<input id="leibovitz_tx_max" class="taux form-control" name="leibovitz_tx_max"
								value="{$data.leibovitz_tx_max}">
							{t}en (heures){/t}
							<input class="duration form-control" name="leibovitz_duree"
								value="{$data.leibovitz_duree}">
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="leibovitz_commentaire" class="control-label col-md-4">
						{t}Commentaires :{/t}</label>
					<div class="col-md-8">
						<input id="leibovitz_commentaire" class="form-control" name="leibovitz_commentaire"
							value="{$data.leibovitz_commentaire}">
					</div>
				</div>
			</fieldset>
			<div class="form-group">
				<label for="biopsie_commentaire" class="control-label col-md-4">
					{t}Commentaire général :{/t}
				</label>
				<div class="col-md-8">
					<input id="biopsie_commentaire" class="form-control" name="biopsie_commentaire"
						value="{$data.biopsie_commentaire}">
				</div>
			</div>

			<div class="form-group center">
				<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
				{if $data.biopsie_id > 0 &&$rights["reproAdmin"] == 1}
				<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
				{/if}
			</div>
		{$csrf}</form>
	</div>
	{if $data.biopsie_id > 0}
	<div class="col-md-6">
		<fieldset>
			<legend>{t}Documents associés{/t}</legend>
			{include file="document/documentListOnly.tpl"}
		</fieldset>
	</div>
	{/if}
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>