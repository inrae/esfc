<script>
	$(document).ready(function () {
		/**
				   * Management of tabs
				   */
		var moduleName = "poissonDisplay";
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

		$(".ok").each(function (i, e) {
			try {
				if ($.fn.dataTable.Api(this).data().count()) {
					$("#" + $(this).data("tabicon")).show();
				}
			} catch { };
		});
		$("#newtag").change(function () {
			if ($(this).val().length > 0) {
				$("#newtagButton").removeAttr("disabled");
				$("#poissonNew").submit();
			} else {
				$("#newtagButton").attr("disabled", true);
			}
		});
	});

</script>

<div class="row">
	<div class="col-md-7">
		<h2>{t}Détail du poisson{/t} {$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur}
			{$dataPoisson.categorie_libelle} {$dataPoisson.sexe_libelle}
			{$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})</h2>
		<a href="{$poissonDetailParent}">
			<img src="display/images/list.png" height="25">
			{t}Retour à la liste des poissons{/t}
		</a>
		{if $rights.poissonGestion == 1}
		<a href="evenementChange?poisson_id={$dataPoisson.poisson_id}&evenement_id=0">
			<img src="display/images/event.png" height="25">
			{t}Nouvel événement...{/t}
		</a>
		{/if}
		<a href="poissonDisplay?poisson_id={$dataPoisson.poisson_id}">
			<img src="display/images/refresh.png" height="25">
		</a>
	</div>
	<div class="col-md-4 form-horizontal">
		<form id="poissonNew" method="post" action="poissonGetFromTag">
			<input type="hidden" name="poisson_id" value="{$dataPoisson.poisson_id}">
			<div class="form-group">
				<label for="newtag" class="control-label col-md-4">
					{t}Pittag du poisson suivant :{/t}
				</label>
				<div class="col-md-5">
					<input id="newtag" name="newtag" class="form-control">
				</div>
				<div class="col-md-2 center">
					<button type="submit" class="btn btn-primary" id="newtagButton" disabled>{t}Rechercher{/t}</button>
				</div>
			</div>
		{$csrf}</form>
	</div>
</div>


<div class="col-xs-12">
	<ul class="nav nav-tabs" id="myTab" role="tablist">
		<li class="nav-item active">
			<a class="nav-link" id="tab-detail" data-toggle="tab" role="tab" aria-controls="nav-detail"
				aria-selected="true" href="#nav-detail">
				<img src="display/images/zoom.png" height="25">
				{t}Détails{/t}
				<img id="oksortie" src="display/images/ok_icon.png" height="15" hidden>
			</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" id="tab-event" href="#nav-event" data-toggle="tab" role="tab" aria-controls="nav-event"
				aria-selected="false">
				<img src="display/images/event.png" height="25">
				{t}Événements{/t}
				<img id="okevent" src="display/images/ok_icon.png" height="15" hidden>
			</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" id="tab-transfert" href="#nav-transfert" data-toggle="tab" role="tab"
				aria-controls="nav-transfert" aria-selected="false">
				<img src="display/images/movement.png" height="25">
				{t}Transferts{/t}
				<img id="oktransfert" src="display/images/ok_icon.png" height="15" hidden>
			</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" id="tab-morphologie" href="#nav-morphologie" data-toggle="tab" role="tab"
				aria-controls="nav-morphologie" aria-selected="false">
				<img src="display/images/balance.svg" height="25">
				{t}Morphologie{/t}
				<img id="okmorphologie" src="display/images/ok_icon.png" height="15" hidden>
			</a>
		</li>

		<li class="nav-item">
			<a class="nav-link" id="tab-file" href="#nav-file" data-toggle="tab" role="tab" aria-controls="nav-file"
				aria-selected="false">
				<img src="display/images/files.png" height="25">
				{t}Documents{/t}
				<img id="okdocument" src="display/images/ok_icon.png" height="15" hidden>
			</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" id="tab-pathologie" href="#nav-pathologie" data-toggle="tab" role="tab"
				aria-controls="nav-pathologie" aria-selected="false">
				<img src="display/images/pathologie.svg" height="25">
				{t}Pathologies{/t}
				<img id="okpathologie" src="display/images/ok_icon.png" height="15" hidden>
			</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" id="tab-reproduction" href="#nav-reproduction" data-toggle="tab" role="tab"
				aria-controls="nav-reproduction" aria-selected="false">
				<img src="display/images/repro.png" height="25">
				{t}Reproduction{/t}
				<img id="okreproduction" src="display/images/ok_icon.png" height="15" hidden>
			</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" id="tab-genetique" href="#nav-genetique" data-toggle="tab" role="tab"
				aria-controls="nav-genetique" aria-selected="false">
				<img src="display/images/genetic.svg" height="25">
				{t}Génétique et parentée{/t}
				<img id="okgenetique" src="display/images/ok_icon.png" height="15" hidden>
			</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" id="tab-anomalie" href="#nav-anomalie" data-toggle="tab" role="tab"
				aria-controls="nav-anomalie" aria-selected="false">
				<img src="display/images/anomalie.svg" height="25">
				{t}Anomalies dans les données{/t}
				<img id="okanomalie" src="display/images/ok_icon.png" height="15" hidden>
			</a>
		</li>
	</ul>
	<div class="tab-content" id="nav-tabContent">
		<div class="tab-pane active in" id="nav-detail" role="tabpanel" aria-labelledby="tab-detail">
			<div class="row">
				{if $rights["poissonGestion"]==1}
				<a href="poissonChange?poisson_id={$dataPoisson.poisson_id}">
					{t}Modifier les informations...{/t}
				</a>
				{/if}
			</div>
			{include file="poisson/poissonDetail.tpl"}
		</div>
		<div class="tab-pane fade" id="nav-event" role="tabpanel" aria-labelledby="tab-event">
			{if $rights["poissonGestion"]==1}
			<div class="row">
				<a href="evenementChange?poisson_id={$dataPoisson.poisson_id}&evenement_id=0">
					Nouvel événement...
				</a>
			</div>
			{include file="poisson/evenementList.tpl"}
			{/if}
		</div>
		<div class="tab-pane fade" id="nav-transfert" role="tabpanel" aria-labelledby="tab-transfert">
			{include file="poisson/transfertList.tpl"}
		</div>

		<div class="tab-pane fade" id="nav-morphologie" role="tabpanel" aria-labelledby="tab-morphologie">
			{include file="poisson/morphologieList.tpl"}
		</div>
		<div class="tab-pane fade" id="nav-file" role="tabpanel" aria-labelledby="tab-file">
			{include file="document/documentList.tpl"}
		</div>
		<div class="tab-pane fade" id="nav-pathologie" role="tabpanel" aria-labelledby="tab-pathologie">
			<div class="col-md-6">
				{include file="poisson/pathologieList.tpl"}
			</div>
		</div>
		<div class="tab-pane fade" id="nav-reproduction" role="tabpanel" aria-labelledby="tab-reproduction">
			<div class="row">
				<div class="col-md-6">
					<fieldset>
						<legend>{t}Campagnes de reproduction{/t}</legend>
						{if $rights.reproGestion == 1}
						<a
							href="poissonCampagneChange?poisson_id={$dataPoisson.poisson_id}&poisson_campagne_id=0">
							{t}Pré-sélectionner le poisson pour une campagne de reproduction{/t}
						</a>
						{/if}
						{include file="poisson/poissonCampagneList.tpl"}
					</fieldset>
				</div>
				<div class="col-md-6">
					<fieldset>
						<legend>{t}Échographies{/t}</legend>
						<div>
							{include file="poisson/echographieList.tpl"}
						</div>
					</fieldset>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<fieldset>
						<legend>{t}Dosages sanguins{/t}</legend>
						{include file="poisson/dosageSanguinList.tpl"}
					</fieldset>
					<fieldset>
						<legend>{t}Anesthésies{/t}</legend>
						<div>
							{include file="poisson/anesthesieList.tpl"}
						</div>
					</fieldset>
				</div>
				<div class="col-md-6">
					<fieldset>
						<legend>{t}Ventilation{/t}</legend>
						{include file="poisson/ventilationList.tpl"}
					</fieldset>
				</div>
			</div>
		</div>
		<div class="tab-pane fade" id="nav-genetique" role="tabpanel" aria-labelledby="tab-genetique">
			<div class="col-md-6">
				<fieldset>
					<legend>{t}Prélèvements génétiques{/t}</legend>
					<div>
						{include file="poisson/genetiqueList.tpl"}
					</div>
				</fieldset>
			</div>
			<div class="col-md-6">
				<fieldset>
					<legend>{t}Détermination de la parenté{/t}</legend>
					<div>
						{include file="poisson/parenteList.tpl"}
					</div>
				</fieldset>
			</div>
			<div class="col-md-6">
				<fieldset>
					<legend>{t}Détermination de la cohorte{/t}</legend>
					<div>
						{include file="poisson/cohorteList.tpl"}
						<br>
					</div>
				</fieldset>
			</div>
			<div class="col-md-6">
				<fieldset>
					<legend>{t}Détermination du sexe{/t}</legend>
					<div>
						{include file="poisson/genderSelectionList.tpl"}
						<br>
					</div>
				</fieldset>
			</div>
		</div>
		<div class="tab-pane fade" id="nav-anomalie" role="tabpanel" aria-labelledby="tab-anomalie">
			<div class="col-md-6">
				{if $rights["poissonGestion"] == 1}
				<a
					href="anomalieChange?poisson_id={$dataPoisson.poisson_id}&anomalie_db_id=0&module_origine=poissonDisplay">
					{t}Créer une anomalie manuellement{/t}
				</a>
				{/if}
				{include file="poisson/anomalieDbList.tpl"}
			</div>
		</div>
	</div>
</div>