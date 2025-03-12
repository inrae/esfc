<a href="{$poissonDetailParent}?sequence_id={$sequence_id}">
    <img src="display/images/list.png" height="25">
    {t}Retour à la liste des poissons{/t}
</a>
<a
    href="poissonCampagneDisplay?poisson_campagne_id={$dataPoisson.poisson_campagne_id}&sequence_id={$sequence_id}">
    <img src="display/images/fish.svg" height="25">
    {t}Retour au reproducteur{/t}
</a>
<a href="poissonSequenceChange?poisson_sequence_id={$dataPsEvenement.poisson_sequence_id}&sequence_id={$sequence_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
	<img src="display/images/repro.png" height="25">
	{t}Retour à la séquence{/t}
</a>
<h2>{t}Événement concernant le poisson pour la séquence considérée{/t} {$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur} -
	{$dataPoisson.sexe_libelle}
	{if $dataPoisson.poisson_statut_id != 1}- {$dataPoisson.poisson_statut_libelle}{/if}</h2>

<div class="row">
	<div class="col-md-6">
		<form class="form-horizontal" id="psEvenementForm" method="post" action="psEvenementWrite">
			<input type="hidden" name="moduleBase" value="psEvenement">
			<input type="hidden" name="poisson_sequence_id" value="{$dataPsEvenement.poisson_sequence_id}">
			<input type="hidden" name="ps_evenement_id" value="{$dataPsEvenement.ps_evenement_id}">
			<input type="hidden" name="poisson_campagne_id" value="{$dataPsEvenement.poisson_campagne_id}">
			<div class="form-group">
				<label for="ps_datetime" class="control-label col-md-4">{t}Date/heure :{/t}<span class="red">*</span></label>
				<div class="col-md-8">
					<input id="ps_datetime" class="form-control datetimepicker" name="ps_datetime" required
						value="{$dataPsEvenement.ps_datetime}">
				</div>
			</div>
			<div class="form-group">
				<label for="ps_libelle" class="control-label col-md-4">{t}Description :{/t}<span
						class="red">*</span></label>
				<div class="col-md-8">
					<input id="ps_libelle" class="form-control" name="ps_libelle" required
						value="{$dataPsEvenement.ps_libelle}">

				</div>
			</div>
			<div class="form-group">
				<label for="ps_commentaire" class="control-label col-md-4">{t}Commentaire :{/t}</label>
				<div class="col-md-8">
					<input id="ps_commentaire" class="form-control" name="ps_commentaire"
						value="{$dataPsEvenement.ps_commentaire}">
				</div>
			</div>
			<div class="form-group center">
				<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
				{if $dataPsEvenement.ps_evenement_id > 0 &&$rights["reproAdmin"] == 1}
				<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
				{/if}
			</div>
			{$csrf}
		</form>
	</div>
</div>