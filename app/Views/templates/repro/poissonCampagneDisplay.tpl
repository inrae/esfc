<link href="display/node_modules/c3/c3.min.css" rel="stylesheet" type="text/css">
<script src="display/node_modules/d3/dist/d3.min.js" charset="utf-8"></script>
<script src="display/node_modules/c3/c3.min.js"></script>
<script>
	$(document).ready(function () {
		/**
				   * Management of tabs
				   */
		var moduleName = "poissonCampagneDisplay";
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
		/*
		 * Display the presence of data in tabs
		 */
		$(".ok").each(function (i, e) {
			try {
				if ($.fn.dataTable.Api(this).data().count()) {
					$("#" + $(this).data("tabicon")).show();
				}
			} catch { };
		});
		var graphicsEnabled = "{$graphicsEnabled}";
		if (graphicsEnabled == 1) {
			var chart = c3.generate({
				bindto: '#profilThermique',
				data: {
					xs: {
						'{t}constaté{/t}': 'x1',
						'{t}prévu{/t}': 'x2'
					},
					//	    x: 'x',
					xFormat: '%d/%m/%Y %H:%M:%S', // 'xFormat' can be used as custom format of 'x'
					columns: [
						[{$pfx1 }],
						[{$pfy1 }],
						[{$pfx2 }],
						[{$pfy2 }]
					]
				},
				axis: {
					x: {
						type: 'timeseries',
						tick: {
							format: '%d/%m %H:%M'
						},
						min: '{$dateMini} 00:00:00',
						max: '{$dateMaxi} 23:59:59'
					},
					y: {
						label: '°C',
						min: 10,
						max: 22
					}
				}

			});
			var chart1 = c3.generate({
				"bindto": '#tauxSanguin',
				"data": {
					xs: {
						'E2': 'x1',
						'Ca': 'x2',
						'Tx_Hematocrite': 'x5',
						'E2_x_hema': 'x5',
						'Ca_x_hema': 'x5',
						'Injections': 'x3',
						'Expulsion': 'x4'
					},
					xFormat: '%d/%m/%Y',
					columns: [
						[{$e2x }],
						[{$e2y }],
						[{$cax }],
						[{$cay }],
						[{$thx }],
						[{$thy }],
						[{$e2hy }],
						[{$cahy }],
						[{$ix }],
						[{$iy }],
						[{$expx }],
						[{$expy }]
					],

					axes: {
						E2: 'y',
						Ca: 'y2',
						Tx_Hematocrite: 'y2',
						Injections: 'y2',
						Expulsion: 'y2'
					},
					types: {
						Injections: 'bar',
						Expulsion: 'bar'
					}
				},
				bar: {
					width: {
						ratio: '0.05'
					}
				},

				axis: {
					x: {
						type: 'timeseries',
						tick: {
							format: '%d/%m'
						},
						min: '{$dateMini}',
						max: '{$dateMaxi}'
					},
					y: {
						label: 'E2 - pg/ml',
						min: 0
					},
					y2: {
						show: true,
						label: 'CA - mg/ml',
						min: 0
					}
				}
			});
			var sexe = "{$dataPoisson.sexe_libelle_court}";
			if (sexe == "f") {
				var chart2 = c3.generate({
					bindto: '#biopsie',
					data: {
						xs: {
							'Tx OPI': 'x1',
							'T50': 'x2',
							'Diam moyen': 'x3'

						},
						xFormat: '%d/%m/%Y',
						columns: [
							[{$opix }],
							[{$opiy }],
							[{$t50x }],
							[{$t50y }],
							[{$diamx }],
							[{$diamy }]
						],

						axes: {
							"Tx OPI": 'y',
							"T50": 'y',
							"Diam moyen": 'y2'
						}

					},

					axis: {
						x: {
							type: 'timeseries',
							tick: {
								format: '%d/%m'
							},
							min: '{$dateMini}',
							max: '{$dateMaxi}'
						},
						y: {
							label: '{t}Tx OPI (%) et heures (fractions décimales){/t}',
							min: 0,
							max: 20
						},
						y2: {
							show: true,
							label: '{t}Diamètre - mm{/t}',
							min: 0,
							max: 3
						}
					}
				});
			}
		}
	});
</script>
<a href="{$poissonDetailParent}&sequence_id={$sequence_id}">
	<img src="display/images/list.png" height="25">
	{t}Retour à la liste des poissons{/t}
</a>
<h2>{t}Détail du reproducteur{/t} {$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur} -
	{$dataPoisson.sexe_libelle}
	{if $dataPoisson.poisson_statut_id != 1}- {$dataPoisson.poisson_statut_libelle}{/if}</h2>

<div class="row">
	<div class="col-xs-12">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item active">
				<a class="nav-link" id="tab-detail" href="#nav-detail" data-toggle="tab" role="tab"
					aria-controls="nav-detail" aria-selected="false">
					<img src="display/images/zoom.png" height="25">
					{t}Détails du poisson{/t}
					<img id="okdetail" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="tab-reproduction" href="#nav-reproduction" data-toggle="tab" role="tab"
					aria-controls="nav-reproduction" aria-selected="false">
					<img src="display/images/repro.png" height="25">
					{t}Séquences de reproduction{/t}
					<img id="okreproduction" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			<li class="nav-item">
				<a class="nav-link" id="tab-echographie" href="#nav-echographie" data-toggle="tab" role="tab"
					aria-controls="nav-echographie" aria-selected="false">
					<img src="display/images/scanner.png" height="25">
					{t}Échographies de l'année{/t}
					<img id="okechographie" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="tab-sanguin" href="#nav-sanguin" data-toggle="tab" role="tab"
					aria-controls="nav-sanguin" aria-selected="false">
					<img src="display/images/syringe.svg" height="25">
					{t}Analyses sanguines{/t}
					<img id="oksanguin" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			</li>

			{if $dataPoisson.sexe_libelle_court == "m"}
			<li class="nav-item">
				<a class="nav-link" id="tab-sperme" href="#nav-sperme" data-toggle="tab" role="tab"
					aria-controls="nav-sperme" aria-selected="false">
					<img src="display/images/eprouvette.png" height="25">
					{t}Prélèvements de sperme{/t}
					<img id="oksperme" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			</li>
			{/if}
			</li>
			<li class="nav-item">
				<a class="nav-link" id="tab-transfert" href="#nav-transfert" data-toggle="tab" role="tab"
					aria-controls="nav-transfert" aria-selected="false">
					<img src="display/images/movement.png" height="25">
					{t}Transferts de l'année{/t}
					<img id="oktransfert" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			</li>

			<li class="nav-item">
				<a class="nav-link" id="tab-event" href="#nav-event" data-toggle="tab" role="tab"
					aria-controls="nav-event" aria-selected="false">
					<img src="display/images/event.png" height="25">
					{t}Événements liés aux séquences{/t}
					<img id="okevent" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			</li>

			<li class="nav-item">
				<a class="nav-link" id="tab-ventilation" href="#nav-ventilation" data-toggle="tab" role="tab"
					aria-controls="nav-ventilation" aria-selected="false">
					<img src="display/images/chronometre.svg" height="25">
					{t}Mesures de ventilation{/t}
					<img id="okventilation" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			</li>

			<li class="nav-item">
				<a class="nav-link" id="tab-injection" href="#nav-injection" data-toggle="tab" role="tab"
					aria-controls="nav-injection" aria-selected="false">
					<img src="display/images/injection.png" height="25">
					{t}Injections{/t}
					<img id="okinjection" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			</li>

			{if $dataPoisson.sexe_libelle_court == "f"}
			<li class="nav-item">
				<a class="nav-link" id="tab-biopsie" href="#nav-biopsie" data-toggle="tab" role="tab"
					aria-controls="nav-biopsie" aria-selected="false">
					<img src="display/images/biopsie.svg" height="25">
					{t}Biopsies{/t}
					<img id="okbiopsie" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			</li>
			{/if}
		</ul>
		<div class="tab-content" id="nav-tabContent">
			<div class="tab-pane active in" id="nav-detail" role="tabpanel" aria-labelledby="tab-detail">
				{if $rights["reproGestion"]==1}
				<a
					href="poissonCampagneChange?poisson_campagne_id={$dataPoisson.poisson_campagne_id}&poisson_id={$dataPoisson.poisson_id}">
					<img src="display/images/edit.gif" height="25">
					{t}Modifier les informations générales...{/t}
				</a>
				{/if}
				{include file="repro/poissonCampagneDetail.tpl"}
				<div class="row">
					<fieldset>
						<legend>{t}Taux sanguins, injections et expulsions{/t}</legend>
						<div id="tauxSanguin"></div>
					</fieldset>
					{if $dataPoisson.sexe_libelle_court == "f"}
					<br>
					<fieldset>
						<legend>{t}Valeurs de biopsie{/t}</legend>
						<div id="biopsie"></div>
					</fieldset>
					{/if}
					<br>
					<fieldset>
						<legend>{t}Profil thermique du poisson{/t}</legend>
						<div id="profilThermique"></div>
					</fieldset>
				</div>
			</div>
			<div class="tab-pane fade" id="nav-reproduction" role="tabpanel" aria-labelledby="tab-reproduction">
				{if $rights["reproGestion"]==1}
				<div class="row">
					<a
						href="poissonSequenceChange?poisson_campagne_id={$dataPoisson.poisson_campagne_id}&poisson_sequence_id=0&sequence_id=0">
						{t}Rattacher une nouvelle séquence...{/t}
					</a>
				</div>
				{/if}
				{include file="repro/poissonSequenceList.tpl"}
			</div>
			<div class="tab-pane fade" id="nav-echographie" role="tabpanel" aria-labelledby="tab-echographie">
				{if $rights["reproGestion"]==1}
				<div class="row">
					<a
						href="echographieChange?poisson_id={$dataPoisson.poisson_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&echographie_id=0">
						{t}Nouvelle échographie (nouvel événement)...{/t}
					</a>
				</div>
				{/if}
				<div class="row">
					{include file="repro/echographieList.tpl"}
				</div>
				<div class="row">
					{include file="document/documentListOnly.tpl"}
				</div>
			</div>
			{if $dataPoisson.sexe_libelle_court == "m"}
			<div class="tab-pane fade" id="nav-sperme" role="tabpanel" aria-labelledby="tab-sperme">
				{if $rights["reproGestion"]==1}
				<div class="row">
					<a href="spermeChange?poisson_id={$dataPoisson.poisson_id}&sperme_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
						{t}Nouveau prélèvement de sperme...{/t}
					</a>
				</div>
				{/if}
				{include file="repro/spermeList.tpl"}
			</div>
			{/if}

			<div class="tab-pane fade" id="nav-sanguin" role="tabpanel" aria-labelledby="tab-sanguin">
				{if $rights["reproGestion"]==1}
				<div class="row">
					<a href="dosageSanguinChange?poisson_id={$dataPoisson.poisson_id}&dosage_sanguin_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
						{t}Nouveau dosage sanguin...{/t}
					</a>
				</div>
				{/if}
				{include file="repro/poissonSanguinList.tpl"}
			</div>
			<div class="tab-pane fade" id="nav-transfert" role="tabpanel" aria-labelledby="tab-transfert">
				{include file="poisson/transfertList.tpl"}
			</div>
			<div class="tab-pane fade" id="nav-event" role="tabpanel" aria-labelledby="tab-event">
				{include file="repro/psEvenementList.tpl"}
			</div>
			<div class="tab-pane fade" id="nav-ventilation" role="tabpanel" aria-labelledby="tab-ventilation">
				{if $rights["reproGestion"]==1}
				<div class="row">
					<a href="ventilationChange?poisson_id={$dataPoisson.poisson_id}&ventilation_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
						{t}Nouvelle mesure...{/t}
					</a>
				</div>
				{/if}
				{include file="repro/ventilationList.tpl"}
			</div>
			<div class="tab-pane fade" id="nav-injection" role="tabpanel" aria-labelledby="tab-injection">
				{if $rights["reproGestion"]==1}
				<div class="row">
					<a href="injectionChange?poisson_id={$dataPoisson.poisson_id}&injection_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
						{t}Nouvelle injection...{/t}
					</a>
				</div>
				{/if}
				{include file="repro/injectionList.tpl"}
			</div>
			{if $dataPoisson.sexe_libelle_court == "f"}
			<div class="tab-pane fade" id="nav-biopsie" role="tabpanel" aria-labelledby="tab-biopsie">
				{if $rights["reproGestion"]==1}
				<div class="row">
					<a href="biopsieChange?poisson_id={$dataPoisson.poisson_id}&biopsie_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
						{t}Nouvelle biopsie...{/t}
					</a>
				</div>
				{/if}
				{include file="repro/poissonBiopsieList.tpl"}
			</div>
			{/if}
		</div>
	</div>
</div>