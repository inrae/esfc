<script>

	$(document).ready(function () {
		/**
				   * Management of tabs
				   */
		var moduleName = "eventChange";
		var localStorage = window.localStorage;
		try {
			activeTab = localStorage.getItem(moduleName + "Tab");
		} catch (Exception) {
			activeTab = "";
		}
		try {
			if (activeTab.length > 0) {
				$("#" + activeTab).tab('show');
			}
		} catch (Exception) { }
		$('a[data-toggle="tab"]').on('shown.bs.tab', function () {
			localStorage.setItem(moduleName + "Tab", $(this).attr("id"));
		});

		$("#bassin_origine").change(function () {
			/*
			* On verifie si le dernier bassin connu correspond à celui indiqué
			* l'anomalie est positionnée à 1 (valeur de la table anomalie_db_type) en cas d'erreur
			*/
			var db = $("#dernier_bassin_connu").val();
			var bo = $("#bassin_origine").val();
			if (db > 0 && bo != db && bo > 0) {
				$(this).next(".erreur").show().text("{t}Le bassin indiqué ne correspond pas au dernier bassin connu dans la base{/t} (" +
					$("#dernier_bassin_connu_libelle").val() + ")");
				$("#anomalie_flag").val("1");
				$("#anomalie_db_commentaire").val("{t}Dernier bassin connu :{/t} " + $("#dernier_bassin_connu_libelle").val());
			} else {
				$(this).next(".erreur").hide();
				$("#anomalie_flag").val("0");
			}
		});
		$("#evenementForm").submit(function () {
			valid = true;
			var bd = $("#bassin_destination").val();
			var bo = $("#bassin_origine").val();
			if (bd > 0 && bd == bo) {
				valid = false;
				$("#bassin_destination").next(".erreur").show().text("{t}Le bassin de destination ne peut être égal au bassin d'origine{/t}");
			} else {
				$("#bassin_destination").css("border_color", "initial");
				$("#bassin_destination").next(".erreur").hide();
			};
			return valid;
		});
		$(".ok").each(function (i, e) {
			if($(this).val()) {
				$("#"+$(this).data("tabicon")).show();
			}
		});
		$(".ok").change(function() {
			if($(this).val()) {
				$("#"+$(this).data("tabicon")).show();
			}
		});
		$("#newtag").change(function() {
			if ($(this).val().length > 0) {
				$("#newtagButton").removeAttr("disabled");
				$("#evenementForm").submit();
			} else {
				$("#newtagButton").attr("disabled", true);
			}
		});
	});
</script>
<a href="index.php?module={$poissonDetailParent}">
	<img src="display/images/display.png" height="25">
	{t}Retour à la liste des poissons{/t}
</a>

<a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">
	<img src="display/images/sturio.png" height="25">
	{t}Retour au poisson{/t} {$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur} 
    {$dataPoisson.categorie_libelle}
    {$dataPoisson.sexe_libelle}
    {$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})
</a>
{if $poisson_campagne_id > 0}
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$poisson_campagne_id}">
    <img src="display/images/fish.svg" height="25">
    {t}Retour au reproducteur{/t}
</a>
{/if}

<h2>{t}Modification d'un événément{/t}</h2>
<form id="evenementForm" method="post" action="index.php" enctype="multipart/form-data">
	<input type="hidden" name="action" value="Write">
	<input type="hidden" name="moduleBase" value="evenement">
	<input type="hidden" name="evenement_id" value="{$data.evenement_id}">
	<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
	<input type="hidden" name="morphologie_id" value="{$dataMorpho.morphologie_id}">
	<input type="hidden" name="pathologie_id" value="{$dataPatho.pathologie_id}">
	<input type="hidden" name="gender_selection_id" value="{$dataGender.gender_selection_id}">
	<input type="hidden" name="transfert_id" value="{$dataTransfert.transfert_id}">
	<input type="hidden" name="dernier_bassin_connu" id="dernier_bassin_connu"
		value="{$dataTransfert.dernier_bassin_connu}">
	<input type="hidden" name="dernier_bassin_connu_libelle" id="dernier_bassin_connu_libelle"
		value="{$dataTransfert.dernier_bassin_connu_libelle}">
	<input type="hidden" name="anomalie_flag" id="anomalie_flag" value="0">
	<input type="hidden" name="anomalie_db_commentaire" id="anomalie_db_commentaire" value="">
	<input type="hidden" name="mortalite_id" id="mortalite_id" value="{$dataMortalite.mortalite_id}">
	<input type="hidden" name="cohorte_id" id="cohorte_id" value="{$dataCohorte.cohorte_id}">
	<input type="hidden" name="sortie_id" id="sortie_id" value="{$dataSortie.sortie_id}">
	<input type="hidden" name="echographie_id" id="echographie_id" value="{$dataEcho.echographie_id}">
	<input type="hidden" name="anesthesie_id" id="anesthesie_id" value="{$dataAnesthesie.anesthesie_id}">
	<input type="hidden" name="dosage_sanguin_id" id="dosage_sanguin_id" value="{$dataDosageSanguin.dosage_sanguin_id}">
	<input type="hidden" name="genetique_id" id="genetique_id" value="{$dataGenetique.genetique_id}">
	<input type="hidden" name="document_id" value="0">

	<div class="row">
		<div class="col-md-6 form-horizontal">
			<div class="form-group">
				<label for="evenement_type_id" class="control-label col-md-4">
					{t}Type d'événement :{/t}<span class="red">*</span>
				</label>
				<div class="col-md-8">
					<select id="evenement_type_id" class="form-control" name="evenement_type_id">
						{section name=lst loop=$evntType}
						<option value="{$evntType[lst].evenement_type_id}" {if
							$evntType[lst].evenement_type_id==$data.evenement_type_id}selected{/if}>
							{$evntType[lst].evenement_type_libelle}
						</option>
						{/section}
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="cevenement_date" class="control-label col-md-4">
					{t}Date :{/t}
					<span class="red">*</span>
				</label>
				<div class="col-md-8">
					<input class="form-control datepicker" name="evenement_date" id="cevenement_date" required
						value="{$data.evenement_date}">
				</div>
			</div>
			<div class="form-group">
				<label for="evenement_commentaire" class="control-label col-md-4">
					{t}Commentaire général :{/t}
				</label>
				<div class="col-md-8">
					<input id="evenement_commentaire" class="form-control" name="evenement_commentaire"
						value="{$data.evenement_commentaire}">
				</div>
			</div>
			<div class="form-group center">
				<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
				{if $data.evenement_id > 0 &&$droits["poissonAdmin"] == 1}
				<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
				{/if}
			</div>
		</div>
		<div class="col-md-4 form-horizontal">
			<div class="form-group">
				<label for="newtag" class="control-label col-md-4">
					{t}Pittag du poisson suivant :{/t}
				</label>
				<div class="col-md-8">
					<input id="newtag" name="newtag" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-12 center">
					<button class="btn btn-primary" id="newtagButton" disabled>{t}Valider et nouvel événement pour le poisson indiqué{/t}</button>
				</div>
			</div>
		</div>
	</div>
	<div class="row">&nbsp;</div>
	<div class="row">
		<div class="col-xs-12">
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item active">
					<a class="nav-link" id="tab-transfert" href="#nav-transfert" data-toggle="tab" role="tab"
						aria-controls="nav-transfert" aria-selected="false">
						<img src="display/images/movement.png" height="25">
						{t}Transferts{/t}
						<img id="oktransfert" class="ok" src="display/images/ok_icon.png" height="15" hidden >
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="tab-morphologie" href="#nav-morphologie" data-toggle="tab" role="tab"
						aria-controls="nav-morphologie" aria-selected="false">
						<img src="display/images/balance.svg" height="25">
						{t}Morphologie{/t}
						<img id="okmorpho" class="ok" src="display/images/ok_icon.png" height="15" hidden >
					</a>
					
				</li>
				<li class="nav-item">
					<a class="nav-link" id="tab-pathologie" href="#nav-pathologie" data-toggle="tab" role="tab"
						aria-controls="nav-pathologie" aria-selected="false">
						<img src="display/images/pathologie.svg" height="25">
						{t}Pathologies{/t}
						<img id="okpathologie" class="ok" src="display/images/ok_icon.png" height="15" hidden >
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="tab-echographie" href="#nav-echographie" data-toggle="tab" role="tab"
						aria-controls="nav-echographie" aria-selected="false">
						<img src="display/images/scanner.png" height="25">
						{t}Échographie{/t}
						<img id="okechographie" class="ok" src="display/images/ok_icon.png" height="15" hidden >
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="tab-sanguin" href="#nav-sanguin" data-toggle="tab" role="tab"
						aria-controls="nav-sanguin" aria-selected="false">
						<img src="display/images/syringe.svg" height="25">
						{t}Dosage sanguin{/t}
						<img id="oksanguin" class="ok" src="display/images/ok_icon.png" height="15" hidden >
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="tab-anesthesie" href="#nav-anesthesie" data-toggle="tab" role="tab"
						aria-controls="nav-anesthesie" aria-selected="false">
						<img src="display/images/anesthesie.svg" height="25">
						{t}Anesthésie{/t}
						<img id="okanesthesie" class="ok" src="display/images/ok_icon.png" height="15" hidden >
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="tab-genetique" href="#nav-genetique" data-toggle="tab" role="tab"
						aria-controls="nav-genetique" aria-selected="false">
						<img src="display/images/genetic.svg" height="25">
						{t}Génétique et parentée{/t}
						<img id="okgenetique" class="ok" src="display/images/ok_icon.png" height="15" hidden >
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="tab-sortie" href="#nav-sortie" data-toggle="tab" role="tab"
						aria-controls="nav-sortie" aria-selected="false">
						<img src="display/images/mortalite.svg" height="25">
						{t}Sortie et mortalité{/t}
						<img id="oksortie" class="ok" src="display/images/ok_icon.png" height="15" hidden >
					</a>
				</li>
			</ul>
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane  active in" id="nav-transfert" role="tabpanel" aria-labelledby="tab-transfert">
					{$bselect = 0}
					{if $dataTransfert.bassin_origine > 0}
					{$bselect = $dataTransfert.bassin_origine}
					{/if}
					<div class="row">
						<div class="col-md-6 form-horizontal">
							<div class="form-group">
								<label for="bassin_origine" class="control-label col-md-4">
									{t}Bassin d'origine :{/t}<span class="red">*</span>
								</label>
								<div class="col-md-8">
									<select class="form-control ok" name="bassin_origine" id="bassin_origine" data-tabicon="oktransfert">
										<option value="" {if $bselect==0} selected {/if}>
											{t}Sélectionnez le bassin d'origine...{/t}
										</option>
										{section name=lst loop=$bassinList}
										<option value="{$bassinList[lst].bassin_id}" {if
											$bassinList[lst].bassin_id==$bselect} selected {/if}>
											{$bassinList[lst].bassin_nom}
										</option>
										{/section}
									</select>
									<span class="red erreur"></span>
								</div>
							</div>
							<div class="form-group">
								<label for="bassin_destination" class="control-label col-md-4">
									{t}Bassin de destination :{/t}<span class="red">*</span>
								</label>
								<div class="col-md-8">
									<select class="form-control ok" name="bassin_destination" id="bassin_destination" data-tabicon="oktransfert">
										<option value="" {if $dataTransfert.bassin_destination=="" } selected {/if}>
											{t}Sélectionnez le bassin de destination...{/t}
										</option>
										{section name=lst loop=$bassinListActif}
										<option value="{$bassinListActif[lst].bassin_id}" {if
											$bassinListActif[lst].bassin_id==$dataTransfert.bassin_destination} selected
											{/if}>
											{$bassinListActif[lst].bassin_nom}
										</option>
										{/section}
									</select>
									<span class="erreur"></span>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="control-label col-md-4">{t}Commentaire :{/t}</label>
								<div class="col-md-8">
									<input id="" class="form-control" name="transfert_commentaire"
										value="{$dataTransfert.transfert_commentaire}" size="40">

								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="nav-morphologie" role="tabpanel" aria-labelledby="tab-morphologie">
					<div class="row">
						<div class="col-md-6 form-horizontal">
							<div class="form-group">
								<label for="clongueur_fourche" class="control-label col-md-4">
									{t}Longueur à la fourche (cm) :{/t}
								</label>
								<div class="col-md-8">
									<input class="form-control taux ok" name="longueur_fourche" id="clongueur_fourche" data-tabicon="okmorpho"
										value="{$dataMorpho.longueur_fourche}">
								</div>
							</div>
							<div class="form-group">
								<label for="clongueur_totale" class="control-label col-md-4">
									{t}Longueur totale (cm) :{/t}
								</label>
								<div class="col-md-8">
									<input class="form-control taux ok" name="longueur_totale" id="clongueur_totale" data-tabicon="okmorpho"
										value="{$dataMorpho.longueur_totale}">
								</div>
							</div>
							<div class="form-group">
								<label for="cmasse" class="control-label col-md-4">
									{t}Masse (g) :{/t}
								</label>
								<div class="col-md-8">
									<input class="form-control nombre ok" name="masse" id="cmasse" data-tabicon="okmorpho"
										value="{$dataMorpho.masse}">
								</div>
							</div>
							<div class="form-group">
								<label for="circonference" class="control-label col-md-4">
									{t}Circonférence (cm) :{/t}
								</label>
								<div class="col-md-8">
									<input class="form-control taux ok" name="circonference" id="circonference" data-tabicon="okmorpho"
										value="{$dataMorpho.circonference}">
								</div>
							</div>
							<div class="form-group">
								<label for="cmorphologie_commentaire" class="control-label col-md-4">
									{t}Commentaire:{/t}
								</label>
								<div class="col-md-8">
									<input class="form-control" name="morphologie_commentaire"
										id="cmorphologie_commentaire" value="{$dataMorpho.morphologie_commentaire}">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="nav-pathologie" role="tabpanel" aria-labelledby="tab-pathologie">
					<div class="row">
						<div class="col-md-6 form-horizontal">
							<div class="form-group">
								<label for="pathologie_type_id" class="control-label col-md-4">
									{t}Type de pathologie :{/t}
									<span class="red">*</span>
								</label>
								<div class="col-md-8">
									<select id="pathologie_type_id" class="form-control ok" name="pathologie_type_id" data-tabicon="okpathologie">
										<option value="" {if $dataPatho.pathologie_type_id=="" }selected{/if}>
											{t}Sélectionnez la pathologie...{/t}
										</option>
										{section name=lst loop=$pathoType}
										<option value="{$pathoType[lst].pathologie_type_id}" {if
											$pathoType[lst].pathologie_type_id==$dataPatho.pathologie_type_id}selected{/if}>
											{$pathoType[lst].pathologie_type_libelle}
										</option>
										{/section}
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="cpathologie_valeur" class="control-label col-md-4">
									{t}Valeur numérique associée :{/t}
								</label>
								<div class="col-md-8">
									<input class="form-control taux" name="pathologie_valeur" id="cpathologie_valeur"
										value="{$dataPatho.pathologie_valeur}">
								</div>
							</div>
							<div class="form-group">
								<label for="cpathologie_commentaire" class="control-label col-md-4">
									{t}Commentaire :{/t}
								</label>
								<div class="col-md-8">
									<input class="form-control" name="pathologie_commentaire"
										id="cpathologie_commentaire" value="{$dataPatho.pathologie_commentaire}">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="nav-echographie" role="tabpanel" aria-labelledby="tab-echographie">
					<div class="row">
						<div class="col-md-6 form-horizontal">
							<div class="form-group">
								<div class="form-group">
									<label for="stade_gonade_id" class="control-label col-md-4">
										{t}Stade des gonades :{/t}
									</label>
									<div class="col-md-8">
										<select id="stade_gonade_id" class="form-control ok" name="stade_gonade_id" data-tabicon="okechographie">
											<option value="" {if $dataEcho.stade_gonade_id=="" }selected{/if}>
												{t}Sélectionnez...{/t}
											</option>
											{section name=lst loop=$gonades}
											<option value="{$gonades[lst].stade_gonade_id}" {if
												$dataEcho.stade_gonade_id==$gonades[lst].stade_gonade_id}selected{/if}>
												{$gonades[lst].stade_gonade_libelle}
											</option>
											{/section}
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="stade_oeuf_id" class="control-label col-md-4">
										{t}Stade des œufs :{/t}
									</label>
									<div class="col-md-8">
										<select id="stade_oeuf_id" class="form-control ok" name="stade_oeuf_id" data-tabicon="okechographie">
											<option value="" {if $dataEcho.stade_oeuf_id=="" }selected{/if}>
												Sélectionnez...</option>
											{section name=lst loop=$oeufs}
											<option value="{$oeufs[lst].stade_oeuf_id}" {if
												$dataEcho.stade_oeuf_id==$oeufs[lst].stade_oeuf_id}selected{/if}>
												{$oeufs[lst].stade_oeuf_libelle}
											</option>
											{/section}
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="echographie_commentaire" class="control-label col-md-4">
										{t}Résultat qualitatif de l'échographie :{/t}
										<span class="red">*</span>
									</label>
									<div class="col-md-8">
										<input id="echographie_commentaire" class="form-control"
											name="echographie_commentaire" value="{$dataEcho.echographie_commentaire}">
									</div>
								</div>
								<div class="form-group">
									<label for="cliche_nb" class="control-label col-md-4">
										{t}Nombre de clichés :{/t}
									</label>
									<div class="col-md-8">
										<input id="cliche_nb" class="form-control nombre" name="cliche_nb" value="{$data.cliche_nb}">
									</div>
								</div>
								<div class="form-group">
									<label for="cliche_ref" class="control-label col-md-4">
										{t}Référence des clichés :{/t}
									</label>
									<div class="col-md-8">
										<input id="cliche_ref" class="form-control" class="commentaire" name="cliche_ref"
											value="{$data.cliche_ref}">
									</div>
								</div>
								<div class="form-group">
									<label for="documentName" class="control-label col-md-4">
										{t}Images(s) à importer :{/t}
										<br>(doc, jpg, png, pdf, xls, xlsx, docx, odt, ods, csv)
									</label>
									<div class="col-md-8">
										<input type="file" class="form-control" name="documentName[]" multiple>
									</div>
								</div>
								<div class="form-group">
									<label for="document_description" class="control-label col-md-4">
										{t}Description des images :{/t}
									</label>
									<div class="col-md-8">
										<input id="document_description" class="form-control" type="text"
											name="document_description" value="">
									</div>
								</div>
								<div class="form-group">
									<label for="document_date_creation" class="control-label col-md-4">
										{t}Date de création (ou de prise de vue) :{/t}
									</label>
									<div class="col-md-8">
										<input id="document_date_creation" class="form-control datepicker"
											name="document_date_creation" value="{$data.document_date_creation}">
									</div>
								</div>
							</div>
						</div>
					</div>


				</div>
				<div class="tab-pane fade" id="nav-sanguin" role="tabpanel" aria-labelledby="tab-sanguin">
					<div class="row">
						<div class="col-md-6 form-horizontal">
							<div class="form-group">
								<label for="tx_e2" class="control-label col-md-4">
									{t}Taux E2 :{/t}
								</label>
								<div class="col-md-8">
									<input id="tx_e2" class="form-control" class="taux ok" name="tx_e2"  data-tabicon="oksanguin"
										value="{$dataDosageSanguin.tx_e2}">
								</div>
							</div>
							<div class="form-group">
								<label for="tx_e2_texte" class="control-label col-md-4">
									{t}Taux E2 (forme textuelle) :{/t}
								</label>
								<div class="col-md-8">
									<input id="tx_e2_texte" class="form-control ok" name="tx_e2_texte" size="20" data-tabicon="oksanguin"
										value="{$dataDosageSanguin.tx_e2_texte}">
								</div>
							</div>
							<div class="form-group">
								<label for="tx_calcium" class="control-label col-md-4">
									{t}Taux de calcium :{/t}
								</label>
								<div class="col-md-8">
									<input id="tx_calcium" class="form-control" class="taux ok" name="tx_calcium" data-tabicon="oksanguin"
										value="{$dataDosageSanguin.tx_calcium}">
								</div>
							</div>
							<div class="form-group">
								<label for="tx_hematocrite" class="control-label col-md-4">
									{t}Taux d'hématocrite :{/t}
								</label>
								<div class="col-md-8">
									<input id="tx_hematocrite" class="form-control" class="taux ok" name="tx_hematocrite" data-tabicon="oksanguin"
										value="{$dataDosageSanguin.tx_hematocrite}">
								</div>
							</div>
							<div class="form-group">
								<label for="dosage_sanguin_commentaire" class="control-label col-md-4">
									{t}Commentaires :{/t}
								</label>
								<div class="col-md-8">
									<input id="dosage_sanguin_commentaire" class="form-control"
										name="dosage_sanguin_commentaire"
										value="{$dataDosageSanguin.dosage_sanguin_commentaire}">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="nav-anesthesie" role="tabpanel" aria-labelledby="tab-anesthesie">
					<div class="row">
						<div class="col-md-6 form-horizontal">
							<div class="form-group">
								<label for="anesthesie_produit_id" class="control-label col-md-4">
									{t}Produit utilisé :{/t}
									<span class="red">*</span>
								</label>
								<div class="col-md-8">
									<select id="anesthesie_produit_id" class="form-control ok"
										name="anesthesie_produit_id" data-tabicon="okanesthesie">
										<option value="" {if $dataAnesthesie.anesthesie_produit_id=="" }selected{/if}>
											{t}Sélectionnez le produit{/t}
										</option>
										{section name=lst loop=$produit}
										<option value="{$produit[lst].anesthesie_produit_id}" {if
											$produit[lst].anesthesie_produit_id==$dataAnesthesie.anesthesie_produit_id}selected{/if}>
											{$produit[lst].anesthesie_produit_libelle}
										</option>
										{/section}
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="anesthesie_dosage" class="control-label col-md-4">
									{t}Dosage (mg/l) :{/t}
								</label>
								<div class="col-md-8">
									<input id="anesthesie_dosage" class="form-control" class="taux"
										name="anesthesie_dosage" value="{$dataAnesthesie.anesthesie_dosage}">
								</div>
							</div>
							<div class="form-group">
								<label for="anesthesie_commentaire" class="control-label col-md-4">
									{t}Commentaire :{/t}
								</label>
								<div class="col-md-8">
									<input id="anesthesie_commentaire" class="form-control"
										name="anesthesie_commentaire" value="{$dataAnesthesie.anesthesie_commentaire}">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="nav-genetique" role="tabpanel" aria-labelledby="tab-genetique">
					<div class="row">
						<div class="col-md-6 form-horizontal">
							<fieldset>
								<legend>{t}Prélèvement génétique{/t}</legend>

								<div class="form-group"><label for="genetique_reference" class="control-label col-md-4">
										{t}Référence du prélèvement:{/t}
										<span class="red">*</span>
									</label>
									<div class="col-md-8">
										<input id="genetique_reference" class="form-control ok" name="genetique_reference" data-tabicon="okgenetique"
											value="{$dataGenetique.genetique_reference}">
									</div>
								</div>
								<div class="form-group"><label for="nageoire_id" class="control-label col-md-4">
										{t}Nageoire :{/t}
									</label>
									<div class="col-md-8">
										<select id="nageoire_id" class="form-control ok" name="nageoire_id" data-tabicon="okgenetique">
											<option value="" {if $dataGenetique.nageoire_id=="" }selected{/if}>
												{t}Sélectionnez...{/t}
											</option>
											{section name=lst loop=$nageoire}
											<option value="{$nageoire[lst].nageoire_id}" {if
												$dataGenetique.nageoire_id==$nageoire[lst].nageoire_id}selected{/if}>
												{$nageoire[lst].nageoire_libelle}
											</option>
											{/section}
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="genetique_commentaire" class="control-label col-md-4">
										{t}Commentaire :{/t}
									</label>
									<div class="col-md-8">
										<input id="genetique_commentaire" class="form-control"
											name="genetique_commentaire" value="{$dataGenetique.genetique_commentaire}">
									</div>
								</div>
							</fieldset>
						</div>
						<div class="col-md-6 form-horizontal">
							<fieldset>
								<legend>{t}Détermination du sexe{/t}</legend>

								<div class="form-group">

									<label for="gender_methode_id" class="control-label col-md-4">
										{t}Méthode utilisée :{/t}
									</label>
									<div class="col-md-8">
										<select id="gender_methode_id" class="form-control ok" name="gender_methode_id" data-tabicon="okgenetique">
											<option value="" {if $dataGender.gender_methode_id=="" }selected{/if}>
												Sélectionnez la méthode...
											</option>
											{section name=lst loop=$genderMethode}
											<option value="{$genderMethode[lst].gender_methode_id}" {if
												$genderMethode[lst].gender_methode_id==$dataGender.gender_methode_id}selected{/if}>
												{$genderMethode[lst].gender_methode_libelle}
											</option>
											{/section}
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="sexe_id" class="control-label col-md-4">
										{t}Sexe déterminé :{/t}
										<span class="red">*</span>
									</label>
									<div class="col-md-8">
										<select id="sexe_id" class="form-control ok" name="sexe_id" data-tabicon="okgenetique">
											<option value="" {if $dataGender.sexe_id=="" }selected{/if}>
												{t}Sélectionnez le sexe...{/t}
											</option>
											{section name=lst loop=$sexe}
											<option value="{$sexe[lst].sexe_id}" {if
												$sexe[lst].sexe_id==$dataGender.sexe_id}selected{/if}>
												{$sexe[lst].sexe_libelle}
											</option>
											{/section}
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="cgender_selection_commentaire"
										class="control-label col-md-4">{t}Commentaire :{/t}</label>
									<div class="col-md-8">
										<input class="form-control" name="gender_selection_commentaire"
											id="cgender_selection_commentaire"
											value="{$dataGender.gender_selection_commentaire}">
									</div>
								</div>
							</fieldset>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 form-horizontal">
							<fieldset>
								<legend>{t}Détermination de la cohorte{/t}</legend>
								<div class="form-group">
									<label for="cohorte_type_id" class="control-label col-md-4">
										{t}Type de détermination :{/t}
										<span class="red">*</span>
									</label>
									<div class="col-md-8">
										<select class="form-control ok" name="cohorte_type_id" id="cohorte_type_id" data-tabicon="okgenetique">
											<option value="" {if $dataCohorte.cohorte_type_id=="" } selected {/if}>
												{t}Sélectionnez le type de détermination...{/t}
											</option>
											{section name=lst loop=$cohorteType}
											<option value="{$cohorteType[lst].cohorte_type_id}" {if
												$cohorteType[lst].cohorte_type_id==$dataCohorte.cohorte_type_id}
												selected {/if}>
												{$cohorteType[lst].cohorte_type_libelle}
											</option>
											{/section}
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="" class="control-label col-md-4">
										{t}Détermination effectuée :{/t}
									</label>
									<div class="col-md-8">
										<input id="cohorte_determination" class="form-control ok"  data-tabicon="okgenetique"
											name="cohorte_determination" value="{$dataCohorte.cohorte_determination}">
									</div>
								</div>
								<div class="form-group">
									<label for="cohorte_commentaire" class="control-label col-md-4">
										{t}Commentaire : {/t}
									</label>
									<div class="col-md-8">
										<input id="cohorte_commentaire" class="form-control" name="cohorte_commentaire"
											value="{$dataCohorte.cohorte_commentaire}">

									</div>
								</div>
							</fieldset>
						</div>
						<div class="col-md-6 form-horizontal">
							<fieldset>
								<legend>{t}Détermination de la parenté{/t}</legend>
								<div class="form-group">
									<label for="" class="control-label col-md-4">
										{t}Type de détermination :{/t}
										<span class="red">*</span>
									</label>
									<div class="col-md-8">
										<select id="" class="form-control ok" name="determination_parente_id" data-tabicon="okgenetique"
											id="determination_parente_id">
											<option value="" {if $dataParente.determination_parente_id=="" } selected
												{/if}>
												{t}Sélectionnez le type de détermination...{/t}
											</option>
											{section name=lst loop=$determinationParente}
											<option value="{$determinationParente[lst].determination_parente_id}" {if
												$determinationParente[lst].determination_parente_id==$dataParente.determination_parente_id}
												selected {/if}>
												{$determinationParente[lst].determination_parente_libelle}
											</option>
											{/section}
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="parente_commentaire" class="control-label col-md-4">
										{t}Commentaire :{/t}
									</label>
									<div class="col-md-8">
										<input id="parente_commentaire" class="form-control" name="parente_commentaire"
											value="{$dataParente.parente_commentaire}">
									</div>
								</div>
							</fieldset>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="nav-sortie" role="tabpanel" aria-labelledby="tab-sortie">
					<div class="row">
						<div class="col-md-6 form-horizontal">
							<fieldset>
								<legend>{t}Sortie du stock{/t}</legend>

								<div class="form-group">
									<label for="sortie_lieu_id" class="control-label col-md-4">
										{t}Lieu de lâcher/destination :{/t}<span class="red">*</span>
									</label>
									<div class="col-md-8">
										<select class="form-control ok" name="sortie_lieu_id" id="sortie_lieu_id" data-tabicon="oksortie">
											<option value="" {if $dataSortie.sortie_lieu_id=="" } selected{/if}>
												{t}Sélectionnez le lieu de lâcher/destination...{/t}
											</option>
											{section name=lst loop=$sortieLieu}
											<option value={$sortieLieu[lst].sortie_lieu_id} {if
												$sortieLieu[lst].sortie_lieu_id==$dataSortie.sortie_lieu_id}selected{/if}>
												{$sortieLieu[lst].localisation}
											</option>
											{/section}
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="sevre" class="control-label col-md-4">
										{t}Informations de nourriture/sevrage :{/t}</label>
									<div class="col-md-8">
										<input id="sevre" class="form-control" name="sevre" value="{$dataSortie.sevre}">
									</div>
								</div>
								<div class="form-group">
									<label for="sortie_lieu_commentaire" class="control-label col-md-4">
										{t}Commentaires :{/t}
									</label>
									<div class="col-md-8">
										<input id="sortie_lieu_commentaire" class="form-control"
											name="sortie_lieu_commentaire" value="{$dataSortie.sortie_commentaire}">
									</div>
								</div>
							</fieldset>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 form-horizontal">
							<fieldset>
								<legend>{t}Mortalité{/t}</legend>
								<div class="form-group">
									<label for="mortalite_type_id" class="control-label col-md-4">
										{t}Type de mortalité :{/t}<span class="red">*</span>
									</label>
									<div class="col-md-8">
										<select class="form-control ok" name="mortalite_type_id" id="mortalite_type_id" data-tabicon="oksortie">
											<option value="" {if $dataMortalite.mortalite_type_id=="" } selected {/if}>
												{t}Sélectionnez le type de mortalité...{/t}
											</option>
											{section name=lst loop=$mortaliteType}
											<option value="{$mortaliteType[lst].mortalite_type_id}" {if
												$mortaliteType[lst].mortalite_type_id==$dataMortalite.mortalite_type_id}
												selected {/if}>
												{$mortaliteType[lst].mortalite_type_libelle}
											</option>
											{/section}
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="" class="control-label col-md-4">
										{t}Commentaire : {/t}
									</label>
									<div class="col-md-8">
										<input id="" class="form-control" name="mortalite_commentaire"
											value="{$dataMortalite.mortalite_commentaire}" size="40">
									</div>
								</div>
							</fieldset>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<div class="row">
	<div class="col-lg-12">
		<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>
	</div>
</div>