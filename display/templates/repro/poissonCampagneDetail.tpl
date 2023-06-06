<script>
	$(document).ready(function () {
		$("#recalcul").submit(function (event) {
			if (!confirm("Confirmez le recalcul des taux de croissance")) {
				event.preventDefault();
			}
		});
	});

</script>
<div class="row">
	<form class="form-horizontal" id="recalcul" method="post" action="index.php">
		<input type="hidden" name="module" value="poissonCampagneRecalcul">
		<input type="hidden" name="poisson_id" value="{$dataPoisson.poisson_id}">
		<input type="hidden" name="annee" value="{$dataPoisson.annee}">
		<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
		<div class="col-lg-8 form-display">
			<div class="form-group">
				<label for="displayIdent" class="control-label col-md-4">{t}Identification :{/t}</label>
				<div class="col-md-8">
					<div class="form-control" id="displayIdent">
						{$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur} -
						{$dataPoisson.sexe_libelle}
						{if $dataPoisson.poisson_statut_id != 1}- {$dataPoisson.poisson_statut_libelle}{/if}
						<a href=index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}>
							<img src="display/images/fish.png" height="2"
								title="{t}Accéder à la fiche détaillée du poisson{/t}">
						</a>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label for="anneeStatut" class="control-label col-md-4">
					{t}Année de reproduction :{/t}
				</label>
				<div class="col-md-8">
					<div class="form-control" id="anneeStatut">
						{$dataPoisson.annee} {$dataPoisson.repro_statut_libelle}
					</div>
				</div>
			</div>
			<label for="txCroissance" class="control-label col-md-4">
				{t}Taux de croissance journalier / spécifique :{/t}
			</label>
			<div class="col-md-8">
				<div class="form-control" id="txCroissance">
					{$dataPoisson.tx_croissance_journalier}
					/ {$dataPoisson.specific_growth_rate}
				</div>
			</div>
			{if $droits.reproGestion == 1}
			<div class="form-group">
				<div class="col-md-12 center">
					<input type="submit" class="btn btn-danger" value="Recalculer">
				</div>
			</div>
			{/if}
		</div>
	</form>
</div>