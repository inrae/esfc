<div class="row">
	<div class="col-md-6">
		<form class="form-horizontal" id="psEvenementForm" method="post" action="psEvenementWrite">
			<input type="hidden" name="moduleBase" value="psEvenement">
			<input type="hidden" name="poisson_sequence_id" value="{$dataPsEvenement.poisson_sequence_id}">
			<input type="hidden" name="ps_evenement_id" value="{$dataPsEvenement.ps_evenement_id}">
			<input type="hidden" name="poisson_campagne_id" value="{$dataPsEvenement.poisson_campagne_id}">
			<div class="form-group">
				<label for="ps_date" class="control-label col-md-4">{t}Date :{/t}<span class="red">*</span></label>
				<div class="col-md-8">
					<input id="ps_date" class="form-control datepicker" class="date" name="ps_date" required
						value="{$dataPsEvenement.ps_date}">
					<input class="timepicker form-control" name="ps_time" required value="{$dataPsEvenement.ps_time}">
				</div>
			</div>
			<div class="form-group">
				<label for="ps_libelle" class="control-label col-md-4">{t}Libellé :{/t}<span
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