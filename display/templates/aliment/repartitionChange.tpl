<script>
	$(document).ready(function () {
		var modif = 0;
		$("input").change(function () {
			modif = 1;
		});
		$("#repartitionPrint").click(function () {
			if (modif == 1) {
				alert("{t}L impression ne peut pas être déclenchée : des modifications ont été apportées dans le formulaire{/t}");
				return false;
			}
		});
		$(".date").change(function () {
			$(this).next(".message").show().text("{t}Veuillez enregistrer la fiche avant de poursuivre votre saisie{/t}");
		});
		function setRation(id, ration) {
			var ration_id = "#total_distribue_" + id;
			$(ration_id).val(ration);
			if (ration > 0) {
				$("#ok" + id).show();
				var modele_id = "#repart_template_id_" + id;
				var modele_val = $(modele_id).val();

				if (isNaN(modele_val)) {
					modele_val = 0;
				}
				if (modele_val == 0) {
					$("#error" + id).show();
				} else {
					$("#error" + id).hide();
				}
			} else {
				$("#ok" + id).hide();
				$("#error" + id).hide();
			}
		}
		$(".evol").change(function () {
			/*
			* Recalcul du nouveau taux de nourrissage
			* Recuperation de la cle
			*/
			var cle = $(this).data("cle");
			var valeur = parseFloat($(this).val());
			if (isNaN(valeur)) { valeur = 0 };
			var origine_id = "#taux_nourrissage_precedent_" + cle;
			var origine_value = parseFloat($(origine_id).val());
			if (isNaN(origine_value)) { origine_value = 0 };
			var taux_id = "#taux_nourrissage_" + cle;
			/*
			* Ecriture de la nouvelle valeur
			*/
			$(taux_id).val(origine_value + valeur);
			$(taux_id).trigger("change");
		});
		$(".tx").change(function () {
			/*
			* Recalcul de la quantite 
			*/
			var cle = $(this).data("cle");
			var valeur = parseFloat($(this).val());
			if (isNaN(valeur)) { valeur = 0 };
			var masse_id = "#distribution_masse_" + cle;
			var masse = parseFloat($(masse_id).val());
			if (isNaN(masse)) masse = 0;
			var ration_id = "#total_distribue_" + cle;
			var ration = parseInt(masse * valeur / 100);
			setRation(cle, ration);
		});
		$(".masse").change(function () {
			/*
			* Recalcul de la quantite
			*/
			var cle = $(this).data("cle");
			var masse = parseFloat($(this).val());
			if (isNaN(masse)) masse = 0;
			var taux_id = "#taux_nourrissage_" + cle;
			var valeur = parseFloat($(taux_id).val());
			if (isNaN(valeur)) valeur = 0;
			var ration_id = "#total_distribue_" + cle;
			var ration = parseInt(masse * valeur / 100);
			setRation(cle, ration);
		});
		$(".modele").change(function () {
			var cle = $(this).data("cle");
			var ration = $("#total_distribue_" + cle).val();
			if (isNaN(ration)) {
				ration = 0;
			}
			var modele = $(this).val();
			if (isNaN(modele)) {
				modele = 0;
			}
			if (modele == 0 && ration > 0) {
				$("#error" + cle).show();
			} else {
				$("#error" + cle).hide();
			}
		});

		$(".calcul").on("click keyup", function () {
			/*
			* Recalcul de la masse dans le bassin
			*/
			var cle = $(this).data("cle");
			var masse_id = "#distribution_masse_" + cle;
			var url = "index.php?module=bassinCalculMasseAjax";
			$.getJSON(url, { "bassin_id": cle }, function (data) {
				$(masse_id).val(data.val);
				$(masse_id).trigger("change");
			});
		});
		$(".ration").change(function () {
			var ration = parseInt($(this).val());
			var cle = $(this).data("cle");
			if (ration > 0) {
				$("#ok" + cle).show();
				var masse = parseFloat($("#distribution_masse_" + cle).val());
				if (!isNaN(masse)) {
					var taux = ration / masse * 10000;
					$("#taux_nourrissage_" + cle).val(parseInt(taux) / 100);
				}
				var modele_id = "#repart_template_id_" + cle;
				var modele_val = $(modele_id).val();

				if (isNaN(modele_val)) {
					modele_val = 0;
				}
				if (modele_val == 0) {
					$("#error" + id).show();
				} else {
					$("#error" + id).hide();
				}
			} else {
				$("#ok" + cle).hide();
				$("#error" + cle).hide();
			}
		});

		$("#repartitionForm").submit(function () {
			/*
			* Verification que le modele de distribution est renseigne si ration > 0
			*/
			var valid = true;
			$(".ration").each(function () {
				var ration = $(this).val();
				if (isNaN(ration)) ration = 0;
				if (ration > 0) {
					/*
					* On teste que le modele de repartition a bien ete renseigne
					*/
					var cle = $(this).data("cle");
					var modele_id = "#repart_template_id_" + cle;
					var modele_val = $(modele_id).val();
					if (isNaN(modele_val)) modele_val = 0;
					if (modele_val == 0) {
						valid = false;
						$(modele_id).next(".erreur").show().text("{t}Le modèle de répartition doit être renseigné{/t}");
						$("#error" + cle).show();
					} else {
						$(modele_id).next(".erreur").hide();
						$("#error" + cle).hide();
					}
				}
			});
			if (valid == false) {
				alert("{t}Une ou plusieurs anomalies ont été détectées : vérifiez votre saisie{/t}");
			}
			return valid;
		});
		$(".ration").each(function () {
			var ration = $(this).val();
			if (ration > 0) {
				var cle = $(this).data("cle");
				$("#ok" + cle).show();
			}
		});
	});
</script>
<a href="index.php?module=repartitionList">
	<img src="display/images/list.png" height="25">
	{t}Retour à la liste{/t}
</a>
<a href="index.php?module=repartitionPrint&repartition_id={$data.repartition_id}" id="repartitionPrint">
	<img src="display/images/print.svg" height="25">
	{t}Imprimer la répartition{/t}
</a>
<form id="repartitionForm" method="post" action="index.php">
	<input type="hidden" name="action" value="Write">
	<input type="hidden" name="moduleBase" value="repartition">
	<input type="hidden" name="repartition_id" value="{$data.repartition_id}">

	<div class="col-lg-12">
		<div class="col-lg-2 col-md-4">
			<div class="row">
				<h2>{t}Modification d'une répartition{/t}</h2>
			</div>

			<div class="row">
				<div class="form-group">
					<button type="submit" class="btn btn-primary button-valid">
						{t}Valider{/t}
					</button>
					{if $data.repartition_id > 0 &&$droits["bassinAdmin"] == 1}
					<button class="btn btn-danger button-delete">
						{t}Supprimer{/t}
					</button>
					{/if}
				</div>
			</div>
		</div>
		<div class="col-lg-6 col-md-8 form-horizontal">
			<div class="row">
				<div class="form-group">
					<label for="categorie_id" class="control-label col-md-3">
						{t}Catégorie d'alimentation :{/t}<span class="red">*</span>
					</label>
					<div class="col-md-3">
						<select class="form-control" name="categorie_id" id="categorie_id" {if $data.repartition_id>
							0}disabled{/if}>
							{section name=lst loop=$categorie}
							<option value="{$categorie[lst].categorie_id}" {if
								$data.categorie_id==$categorie[lst].categorie_id}selected{/if}>
								{$categorie[lst].categorie_libelle}
							</option>
							{/section}
						</select>
					</div>
					<label for="repartition_name" class="control-label col-md-3">
						{t}Nom :{/t}
					</label>
					<div class="col-md-3">
						<input id="repartition_name" class="form-control" name="repartition_name"
							value="{$data.repartition_name}" placeholder="Élevage, repro...">
					</div>
				</div>
				<div class="form-group">
					<label for="date_debut_periode" class="control-label col-md-3">{t}Date début :{/t}</label>
					<div class="col-md-3">
						<input id="date_debut_periode" class="form-control" class="date datepicker"
							name="date_debut_periode" value="{$data.date_debut_periode}">
						<span class="message"></span>
					</div>
					<label for="date_fin_periode" class="control-label col-md-3">{t}Date fin :{/t}</label>
					<div class="col-md-3">
						<input id="date_fin_periode" class="form-control" class="date" name="date_fin_periode"
							value="{$data.date_fin_periode}">
						<span class="message"></span>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-lg-12">
		<div class="row">
			<h3>{t}Répartition des aliments par bassin{/t}</h3>
		</div>
		<div class="col-lg-8">
			<div class="row">
				<div class="col-lg-12">
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						{$i=0}
						{section name=lst loop=$dataBassin}
						<li class="nav-item {if $i==0}active{/if}">
							<a class="nav-link" id="tab-{$dataBassin[lst].bassin_id}"
								href="#nav-{$dataBassin[lst].bassin_id}" data-toggle="tab" role="tab"
								aria-controls="nav-{$dataBassin[lst].bassin_id}" aria-selected="false">
								{$dataBassin[lst].bassin_nom}
								<img id="ok{$dataBassin[lst].bassin_id}" src="display/images/ok_icon.png" height="15"
									hidden>
								<img id="error{$dataBassin[lst].bassin_id}" src="display/images/cross.png" height="15"
									hidden>
							</a>
						</li>
						{$i = $i + 1}
						{/section}
					</ul>
					<div class="tab-content" id="nav-tabContent">
						{$i=0}
						{section name=lst loop=$dataBassin}
						<div class="tab-pane {if $i == 0} active in{else}fade{/if}"
							id="nav-{$dataBassin[lst].bassin_id}" role="tabpanel"
							aria-labelledby="tab-{$dataBassin[lst].bassin_id}">
							{$i = $i + 1}
							<input type="hidden" name="distribution_id_{$dataBassin[lst].bassin_id}"
								value="{$dataBassin[lst].distribution_id}">
							<input type="hidden" name="bassin_id_{$dataBassin[lst].bassin_id}"
								value="{$dataBassin[lst].bassin_id}">

							<div class="col-lg-12 form-horizontal">
								<div class="row">
									<div class="form-group">
										<label for="repart_template_id_{$dataBassin[lst].bassin_id}"
											class="control-label col-md-4">
											{t}Modèle de distribution utilisé :{/t}<span class="red">*</span>
										</label>
										<div class="col-md-8">
											<select id="repart_template_id_{$dataBassin[lst].bassin_id}"
												class="form-control modele"
												name="repart_template_id_{$dataBassin[lst].bassin_id}"
												data-cle="{$dataBassin[lst].bassin_id}">
												<option value="0" {if
													$dataBassin[lst].repart_template_id==0}selected{/if}>
													Sélectionnez le modèle...</option>
												{section name=lst1 loop=$dataTemplate}
												<option value="{$dataTemplate[lst1].repart_template_id}" {if
													$dataTemplate[lst1].repart_template_id==$dataBassin[lst].repart_template_id}selected{/if}>
													{$dataTemplate[lst1].repart_template_libelle}
												</option>
												{/section}
											</select>
											<div class="erreur red"></div>
										</div>
									</div>
									<div class="form-group">
										<label for="distribution_masse_{$dataBassin[lst].bassin_id}"
											class="control-label col-md-4">
											{t}Masse (poids) des poissons dans le bassin (en grammes) :{/t}
										</label>
										<div class="col-md-6">
											<input class="form-control nombre masse"
												name="distribution_masse_{$dataBassin[lst].bassin_id}"
												id="distribution_masse_{$dataBassin[lst].bassin_id}"
												value="{$dataBassin[lst].distribution_masse}"
												data-cle="{$dataBassin[lst].bassin_id}">
										</div>
										<div class="col-md-2">
											<input type="button" class="calcul btn btn-warning"
												data-cle="{$dataBassin[lst].bassin_id}" value="{t}Recalcul...{/t}">
										</div>
									</div>
									<div class="form-group">
										<label for="" class="control-label col-md-4">
											{t}Nourrissage des jours précédents (même nbre de jours) :{/t}
										</label>
										<div class="col-md-8">
											<label for="taux_nourrissage_precedent_{$dataBassin[lst].bassin_id}"
												class="control-label col-md-2">
												{t}Taux :{/t}
											</label>
											<div class="col-md-2">
												<input name="taux_nourrissage_precedent_{$dataBassin[lst].bassin_id}"
													id="taux_nourrissage_precedent_{$dataBassin[lst].bassin_id}"
													data-cle="{$dataBassin[lst].bassin_id}"
													value="{$dataBassin[lst].taux_nourrissage_precedent}"
													class="form-control nombre" readonly>
											</div>
											<label for="taux_nourrissage_precedent_{$dataBassin[lst].bassin_id}"
												class="control-label col-md-2">
												{t}Qté :{/t}
											</label>
											<div class="col-md-2">
												<input class="nombre form-control"
													name="total_distrib_precedent_{$dataBassin[lst].bassin_id}"
													value="{$dataBassin[lst].total_distrib_precedent}" readonly>
											</div>
											<label for="taux_nourrissage_precedent_{$dataBassin[lst].bassin_id}"
												class="control-label col-md-2">
												{t} soit global :{/t}
											</label>
											<div class="col-md-2">
												<input class="nombre form-control"
													name="total_distrib_precedent_{$dataBassin[lst].bassin_id}"
													value="{$dataBassin[lst].total_periode_distrib_precedent}" readonly>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label for="" class="control-label col-md-4">
											{t}Reste :{/t}
										</label>
										<div class="col-md-8">
											<div class=" col-md-offset-2 col-md-2">
												<input class="nombre form-control"
													name="reste_precedent_{$dataBassin[lst].bassin_id}"
													id="reste_precedent_{$dataBassin[lst].bassin_id}"
													data-cle="{$dataBassin[lst].bassin_id}"
													value="{$dataBassin[lst].reste_precedent}" readonly>
											</div>

											<label for="taux_reste_precedent_{$dataBassin[lst].bassin_id}"
												class="control-label col-md-2">
												{t}% reste :{/t}
											</label>
											<div class="col-md-2">
												<input class="taux form-control"
													id="taux_reste_precedent_{$dataBassin[lst].bassin_id}"
													name="taux_reste_precedent_{$dataBassin[lst].bassin_id}"
													value="{$dataBassin[lst].taux_reste_precedent}" readonly>
											</div>
											<div class="col-md-4">
												<input class="form-control"
													name="ration_commentaire_precedent_{$dataBassin[lst].bassin_id}"
													id="ration_commentaire_precedent_{$dataBassin[lst].bassin_id}"
													data-cle="{$dataBassin[lst].bassin_id}"
													value="{$dataBassin[lst].ration_commentaire_precedent}" readonly
													placeholder="{t}Commentaire{/t}">
											</div>
										</div>
									</div>

									<div class="form-group">
										<label class="control-label col-md-4">
											{t}Taux de nourrissage :{/t}
										</label>
										<div class="col-md-8">
											<label for="evol_taux_nourrissage_{$dataBassin[lst].bassin_id}"
												class="control-label col-md-2">
												{t}Évolution :{/t}
											</label>
											<div class="col-md-2">
												<input class="taux form-control evol"
													name="evol_taux_nourrissage_{$dataBassin[lst].bassin_id}"
													id="evol_taux_nourrissage_{$dataBassin[lst].bassin_id}"
													data-cle="{$dataBassin[lst].bassin_id}"
													value="{$dataBassin[lst].evol_taux_nourrissage}">
											</div>
											<label for="taux_nourrissage_{$dataBassin[lst].bassin_id}"
												class="control-label col-md-2">
												{t}Nouveau taux :{/t}
											</label>
											<div class="col-md-2">
												<input class="form-control tx taux"
													name="taux_nourrissage_{$dataBassin[lst].bassin_id}"
													id="taux_nourrissage_{$dataBassin[lst].bassin_id}"
													data-cle="{$dataBassin[lst].bassin_id}"
													value="{$dataBassin[lst].taux_nourrissage}">
											</div>

											<label for="total_distribue_{$dataBassin[lst].bassin_id}"
												class="control-label col-md-2">
												{t}Ration distribuée :{/t}
											</label>
											<div class="col-md-2">
												<input class="form-control nombre ration"
													name="total_distribue_{$dataBassin[lst].bassin_id}"
													id="total_distribue_{$dataBassin[lst].bassin_id}"
													data-cle="{$dataBassin[lst].bassin_id}"
													value="{$dataBassin[lst].total_distribue}">
											</div>
										</div>
									</div>
									<div class="form-group">
										<label for="distribution_consigne_{$dataBassin[lst].bassin_id}"
											class="control-label col-md-4">
											{t}Consignes de distribution :{/t}
										</label>
										<div class="col-md-8">
											<input name="distribution_consigne_{$dataBassin[lst].bassin_id}"
												id="distribution_consigne_{$dataBassin[lst].bassin_id}"
												data-cle="{$dataBassin[lst].bassin_id}"
												value="{$dataBassin[lst].distribution_consigne}" class="form-control">
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-md-4">
											{t}Jours de distribution :{/t}</label>
										<label class="radio-inline">
											{t}lun{/t}
											<input type="checkbox"
												name="distribution_jour_1_{$dataBassin[lst].bassin_id}" value="1" {if
												$dataBassin[lst].distribution_jour_1==1}checked{/if}>
										</label>
										<label class="radio-inline">
											{t}mar{/t}
											<input type="checkbox"
												name="distribution_jour_2_{$dataBassin[lst].bassin_id}" value="1" {if
												$dataBassin[lst].distribution_jour_2==1}checked{/if}>
										</label>
										<label class="radio-inline">
											{t}mer{/t}
											<input type="checkbox"
												name="distribution_jour_3_{$dataBassin[lst].bassin_id}" value="1" {if
												$dataBassin[lst].distribution_jour_3==1}checked{/if}>
										</label>
										<label class="radio-inline">
											{t}jeu{/t}
											<input type="checkbox"
												name="distribution_jour_4_{$dataBassin[lst].bassin_id}" value="1" {if
												$dataBassin[lst].distribution_jour_4==1}checked{/if}>
										</label>
										<label class="radio-inline">
											{t}ven{/t}
											<input type="checkbox"
												name="distribution_jour_5_{$dataBassin[lst].bassin_id}" value="1" {if
												$dataBassin[lst].distribution_jour_5==1}checked{/if}>
										</label>
										<label class="radio-inline">
											{t}sam{/t}
											<input type="checkbox"
												name="distribution_jour_6_{$dataBassin[lst].bassin_id}" value="1" {if
												$dataBassin[lst].distribution_jour_6==1}checked{/if}>
										</label>
										<label class="radio-inline">
											{t}dim{/t}
											<input type="checkbox"
												name="distribution_jour_7_{$dataBassin[lst].bassin_id}" value="1" {if
												$dataBassin[lst].distribution_jour_7==1}checked{/if}>
										</label>
									</div>
									<div class="form-group">
										<label class="control-label col-md-4">
											{t}1/2 ration le soir uniquement :{/t}
										</label>
										<label class="radio-inline">
											{t}lun{/t}
											<input type="checkbox"
												name="distribution_jour_soir_1_{$dataBassin[lst].bassin_id}" value="1"
												{if $dataBassin[lst].distribution_jour_soir_1==1}checked{/if}>
										</label>
										<label class="radio-inline">
											{t}mar{/t}
											<input type="checkbox"
												name="distribution_jour_soir_2_{$dataBassin[lst].bassin_id}" value="1"
												{if $dataBassin[lst].distribution_jour_soir_2==1}checked{/if}>
										</label>
										<label class="radio-inline">
											{t}mer{/t}
											<input type="checkbox"
												name="distribution_jour_soir_3_{$dataBassin[lst].bassin_id}" value="1"
												{if $dataBassin[lst].distribution_jour_soir_3==1}checked{/if}>
										</label>
										<label class="radio-inline">
											{t}jeu{/t}
											<input type="checkbox"
												name="distribution_jour_soir_4_{$dataBassin[lst].bassin_id}" value="1"
												{if $dataBassin[lst].distribution_jour_soir_4==1}checked{/if}>
										</label>
										<label class="radio-inline">
											{t}ven{/t}
											<input type="checkbox"
												name="distribution_jour_soir_5_{$dataBassin[lst].bassin_id}" value="1"
												{if $dataBassin[lst].distribution_jour_soir_5==1}checked{/if}>
										</label>
										<label class="radio-inline">
											{t}sam{/t}
											<input type="checkbox"
												name="distribution_jour_soir_6_{$dataBassin[lst].bassin_id}" value="1"
												{if $dataBassin[lst].distribution_jour_soir_6==1}checked{/if}>
										</label>
										<label class="radio-inline">
											{t}dim{/t}
											<input type="checkbox"
												name="distribution_jour_soir_7_{$dataBassin[lst].bassin_id}" value="1"
												{if $dataBassin[lst].distribution_jour_soir_7==1}checked{/if}>
										</label>
									</div>
								</div>
							</div>
						</div>
						{/section}
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>