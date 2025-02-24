<script>
	$(document).ready(function () {
		$(".date").datepicker({ dateFormat: "dd/mm/yy" });
		$("#anomalie_db_statut").change(function () {
			var valeur = $(this).val();
			if (valeur == 1) {
				$("#statut_img").attr("src", "display/images/ok_icon.png");
				/* Traitement de la date de resolution */
				var date_traitement = $("#anomalie_db_date_traitement").val();
				if (!date_traitement) {
					$("#anomalie_db_date_traitement").datepicker("setDate", new Date() );
				}
			} else {
				$("#statut_img").attr("src", "display/images/warning_icon.png");
			}
		});
	});
</script>
{if $module_origine == "poissonDisplay"}
<a href="index.php?module={$poissonDetailParent}">
	<img src="display/images/display.png" height="25">
	{t}Retour à la liste des poissons{/t}
</a>

<a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">
	<img src="display/images/sturio.png" height="25">
	{t}Retour au poisson{/t} {$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur} {$dataPoisson.categorie_libelle} {$dataPoisson.sexe_libelle}
	{$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})
</a>
{else}
<a href="index.php?module=anomalieList">
	<img src="display/images/anomalie.svg" height="25">
	{t}Retour à la liste des anomalies{/t}
</a>
{/if}
<h2>{t}Traitement d'une anomalie{/t}</h2>

<div class="row">
	<div class="col-md-6">
		<form class="form-horizontal" id="anomalieForm" method="post" action="index.php">
			<input type="hidden" name="action" value="Write">
			<input type="hidden" name="moduleBase"
				value='{if $module_origine == "poissonDisplay"}poissonAnomalie{else}anomalie{/if}'>
			<input type="hidden" name="anomalie_db_id" value="{$data.anomalie_db_id}">
			<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
			<input type="hidden" name="evenement_id" value="{$data.evenement_id}">
			<div class="form-group">
				<label for="anomalie_db_date" class="control-label col-md-4">
					{t}Date de détection de l'anomalie :{/t}
				</label>
				<div class="col-md-8">
					<input id="anomalie_db_date" class="datepicker form-control" name="anomalie_db_date"
						value="{$data.anomalie_db_date}">
				</div>
			</div>
			<div class="form-group">
				<label for="anomalie_db_type_id" class="control-label col-md-4">
					{t}Type d'anomalie :{/t}<span class="red">*</span>
				</label>
				<div class="col-md-8">
					<select id="anomalie_db_type_id" class="form-control" name="anomalie_db_type_id">
						{section name=lst loop=$anomalieType}
						<option value="{$anomalieType[lst].anomalie_db_type_id}" {if
							$anomalieType[lst].anomalie_db_type_id==$data.anomalie_db_type_id}selected{/if}>
							{$anomalieType[lst].anomalie_db_type_libelle}
						</option>
						{/section}
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="" class="control-label col-md-4">{t}Poisson concerné :{/t}</label>
				<div class="col-md-8">
					<div class="form-control" id="poisson">
						{if $data.poisson_id > 0}
						<a href="index.php?module=poissonDisplay&poisson_id={$data.poisson_id}"
							onclick='return confirm("Vous allez quitter la saisie en cours. Confirmez-vous cette opération ?")'>
							{$data.matricule} {$data.prenom} {$data.pittag_valeur}
						</a>
						{/if}
					</div>
				</div>
			</div>
			<div class="form-group">
				<label for="anomalie_db_commentaire" class="control-label col-md-4">
					{t}Commentaire :{/t}
				</label>
				<div class="col-md-8">
					<input id="anomalie_db_commentaire" class="form-control" name="anomalie_db_commentaire"
						value="{$data.anomalie_db_commentaire}">

				</div>
			</div>
			<div class="form-group">
				<label for="anomalie_db_statut" class="control-label col-md-4">
					{t}Statut :{/t}
					{if $data.anomalie_db_statut == 1}
					<img id="statut_img" src="display/images/ok_icon.png" height="20">
					{else}
					<img id="statut_img" src="display/images/cross.png" height="20">
					{/if}
				</label>
				<div class="col-md-8">
					<select class="form-control" name="anomalie_db_statut" id="anomalie_db_statut">
						<option value="0" {if $data.anomalie_db_statut !=1}selected{/if}>
							{t}Anomalie non levée{/t}
						</option>
						<option value="1" {if $data.anomalie_db_statut==1}selected{/if}>
							{t}Anomalie levée{/t}
						</option>
					</select>


				</div>
			</div>
			<div class="form-group">
				<label for="anomalie_db_date_traitement" class="control-label col-md-4">
					{t}Date de traitement de l'anomalie :{/t}
				</label>
				<div class="col-md-8">
					<input id="" class="form-control datepicker" name="anomalie_db_date_traitement"
						id="anomalie_db_date_traitement" value="{$data.anomalie_db_date_traitement}">
				</div>
			</div>

			<div class="form-group center">
				<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
				{if $data.anomalie_db_id > 0 &&$droits["poissonAdmin"] == 1}
				<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
				{/if}
			</div>
		</form>
	</div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>