<script>
	$(document).ready(function () {
		$("#recherche").keyup(function () {
			/*
			* Traitement de la recherche d'un poisson
			*/
			var texte = $(this).val();
			if (texte.length > 2) {
				/*
				* declenchement de la recherche
				*/
				var url = "index.php?module=poissonSearchAjax";
				$.getJSON(url, { "libelle": texte }, function (data) {
					var options = '';
					for (var i = 0; i < data.length; i++) {
						options += '<option value="' + data[i].poisson_id + '">' + data[i].matricule + " " + data[i].prenom + '</option>';
					};
					$("#parent_id").html(options);
				});
			};
		});

	});
</script>
<a href="index.php?module={$poissonDetailParent}">
	<img src="display/images/display.png" height="25">
	{t}Retour à la liste des poissons{/t}
</a>

<a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">
	<img src="display/images/sturio.png" height="25">
	{t}Retour au poisson{/t}
</a>

<h2>{t}Attribution d'un parent au poisson{/t} {$dataPoisson.matricule} {$dataPoisson.categorie_libelle}
	{$dataPoisson.sexe_libelle}
	{$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})</h2>

<div class="row">
	<div class="col-md-6">
		<form class="form-horizontal" id="parentForm" method="post" action="index.php">
			<input type="hidden" name="action" value="Write">
			<input type="hidden" name="moduleBase" value="parentPoisson">
			<input type="hidden" name="parent_poisson_id" value="{$data.parent_poisson_id}">
			<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
			<div class="form-group">
				<label for="" class="control-label col-md-4">{t}Parent :{/t}</label>
				<div class="col-md-8">
					<input class="form-control" id="recherche" placeholder="{t}texte à rechercher{/t}" autofocus>
					<select class="form-control" id="parent_id" name="parent_id">
						{if $data.parent_id > 0}
						<option value="{$data.parent_id}">
							{$data.matricule}
							{if !empty($data.pittag_valeur)}
							{$data.pittag_valeur}
							{if !empty($data.prenom)}
							{$data.prenom}
							{/if}
							{/if}
						</option>
						{/if}
					</select>
				</div>
			</div>

			<div class="form-group center">
				<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
				{if $data.parent_poisson_id > 0 &&$droits["poissonAdmin"] == 1}
				<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
				{/if}
			</div>
		</form>
	</div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>