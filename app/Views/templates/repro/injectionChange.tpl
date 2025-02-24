<a href="{$poissonDetailParent}&sequence_id={$sequence_id}">
	<img src="display/images/display.png" height="25">
	{t}Retour à la liste des poissons{/t}
</a>&nbsp;
<a href="poissonCampagneDisplay?poisson_campagne_id={$data.poisson_campagne_id}">
	<img src="display/images/fish.svg" height="25">
	{t}Retour au reproducteur{/t}
</a>
<h2>{t}Modification d'une injection{/t} {$dataPoisson.matricule}
	{$dataPoisson.categorie_libelle}
	{$dataPoisson.sexe_libelle}
	{$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})
</h2>

<div class="row">
	<div class="col-md-6">
		<form class="form-horizontal" id="injectionForm" method="post" action="injectionWrite">			
			<input type="hidden" name="moduleBase" value="injection">
			<input type="hidden" name="injection_id" value="{$data.injection_id}">
			<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
			<div class="form-group">
				<label for="injection_date" class="control-label col-md-4">
					{t}Date de l'injection :{/t}
					<span class="red">*</span>
				</label>
				<div class="col-md-8">
					<input id="injection_date" class="form-control datetimepicker" name="injection_date"
						required value="{$data.injection_date}">
				</div>
			</div>
			<div class="form-group">
				<label for="sequence_id" class="control-label col-md-4">
					{t}Séquence de reproduction :{/t}<span class="red">*</span>
				</label>
				<div class="col-md-8">
					<select id="sequence_id" class="form-control" name="sequence_id">
						{section name=lst loop=$sequences}
						<option value="{$sequences[lst].sequence_id}" {if
							$data.sequence_id==$sequences[lst].sequence_id}selected{/if}>
							{$sequences[lst].sequence_nom}
						</option>
						{/section}
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="hormone_id" class="control-label col-md-4">
					{t}Hormone utilisée :{/t}
				</label>
				<div class="col-md-8">
					<select id="hormone_id" class="form-control" name="hormone_id">
						<option value="" {if $data.hormone_id=="" }selected{/if}{t}Sélectionnez...{/t}/option>
							{section name=lst loop=$hormones}
						<option value="{$hormones[lst].hormone_id}" {if
							$data.hormone_id==$hormones[lst].hormone_id}selected{/if}>
							{$hormones[lst].hormone_nom} - unité : {$hormones[lst].hormone_unite}
						</option>
						{/section}
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="injection_dose" class="control-label col-md-4">
					{t}Dose injectée :{/t}
				</label>
				<div class="col-md-8">
					<input id="injection_dose" class="form-control" class="taux" name="injection_dose"
						value="{$data.injection_dose}">
				</div>
			</div>
			<div class="form-group">
				<label for="injection_commentaire" class="control-label col-md-4">{t}Commentaire :{/t}</label>
				<div class="col-md-8">
					<input id="injection_commentaire" class="form-control" class="commentaire"
						name="injection_commentaire" value="{$data.injection_commentaire}">
				</div>
				<div class="form-group center">
					<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
					{if $data.injection_id > 0 &&$rights["reproGestion"] == 1}
					<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
					{/if}
				</div>
			</div>
		{$csrf}</form>
	</div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>