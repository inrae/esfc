<script>
	$(document).ready(function () {
		$("#recalcul").submit(function (event) {
			if (!confirm("{t}Confirmez le recalcul des taux de croissance{/t}")) {
				event.preventDefault();
			}
		});
	});

</script>
<div class="row">
	<div class="col-md-6">
		<form class="form-horizontal" id="recalcul" method="post" action="index.php">
			<input type="hidden" name="module" value="poissonCampagneRecalcul">
			<input type="hidden" name="poisson_id" value="{$dataPoisson.poisson_id}">
			<input type="hidden" name="annee" value="{$dataPoisson.annee}">
			<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
			<div class="form-group">
				<label for="displayIdent" class="control-label col-md-4">{t}Identification :{/t}</label>
				<div class="col-md-6">
					<div class="form-control" id="displayIdent">
						{$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur} -
						{$dataPoisson.sexe_libelle}
						{if $dataPoisson.poisson_statut_id != 1}- {$dataPoisson.poisson_statut_libelle}{/if}
					</div>
				</div>
				<div class="col-md-2 center">
					<a href=index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}>
						<img src="display/images/fish.png" height="25"
							title="{t}Accéder à la fiche détaillée du poisson{/t}">
					</a>
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
			<div class="form-group">
				<label for="txCroissance" class="control-label col-md-4">
					{t}Taux de croissance journalier / spécifique :{/t}
				</label>
				<div class="col-md-4">
					<div class="form-control" id="txCroissance">
						{$dataPoisson.tx_croissance_journalier}
						/ {$dataPoisson.specific_growth_rate}
					</div>
				</div>
				<div class="col-md-4 center">
					<input type="submit" class="btn btn-danger" value="{t}Recalculer{/t}" {if $droits.reproGestion
						!=1}disabled{/if}>
				</div>
			</div>
		</form>
	</div>
</div>