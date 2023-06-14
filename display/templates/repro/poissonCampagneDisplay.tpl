<link href="display/javascript/c3/c3.css" rel="stylesheet" type="text/css">
<script src="display/javascript/c3/d3.min.js" charset="utf-8"></script>
<script src="display/javascript/c3/c3.min.js"></script>
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
		var graphicsEnabled = "{$graphicsEnabled}";
		if (graphicsEnabled == 1) {
			var chart = c3.generate({
				bindto: '#profilThermique',
				data: {
					xs: {
						'constaté': 'x1',
						'prévu': 'x2'
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
							[{ $opix }],
							[{ $opiy }],
							[{ $t50x }],
							[{ $t50y }],
							[{ $diamx }],
							[{ $diamy }]
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
<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">
	<img src="display/images/list.png" height="25">
	{t}Retour à la liste des poissons{/t}
</a>
{if $droits["reproGestion"]==1}
&nbsp;
<a
	href="index.php?module=poissonCampagneChange&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&poisson_id={$dataPoisson.poisson_id}">
	<img src="display/images/edit.gif" height="25">
	{t}Modifier les informations générales...{/t}
</a>
{/if}
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
					<img id="okdetail" class="ok" src="display/images/ok_icon.png" height="15" hidden >
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
					<img id="okechographie" class="ok" src="display/images/ok_icon.png" height="15" hidden >
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="tab-sanguin" href="#nav-sanguin" data-toggle="tab" role="tab"
					aria-controls="nav-sanguin" aria-selected="false">
					<img src="display/images/syringe.svg" height="25">
					{t}Analyses sanguines{/t}
					<img id="oksanguin" class="ok" src="display/images/ok_icon.png" height="15" hidden >
				</a>
			</li>

			{if $dataPoisson.sexe_libelle_court == "m"}
			<li class="nav-item">
				<a class="nav-link" id="tab-sperme" href="#nav-sperme" data-toggle="tab" role="tab"
					aria-controls="nav-sperme" aria-selected="false">
					<img src="display/images/eprouvette.png" height="25">
					{t}Prélèvements de sperme{/t}
					<img id="oksperme" class="ok" src="display/images/ok_icon.png" height="15" hidden >
				</a>
			</li>
			{/if}
			</li>
			<li class="nav-item">
				<a class="nav-link" id="tab-transfert" href="#nav-transfert" data-toggle="tab" role="tab"
					aria-controls="nav-transfert" aria-selected="false">
					<img src="display/images/movement.png" height="25">
					{t}Transferts de l'année{/t}
					<img id="oktransfert" class="ok" src="display/images/ok_icon.png" height="15" hidden >
				</a>
			</li>

			<li class="nav-item">
				<a class="nav-link" id="tab-event" href="#nav-event" data-toggle="tab" role="tab" aria-controls="nav-event"
					aria-selected="false">
					<img src="display/images/event.png" height="25">
					{t}Événements liés aux séquences{/t}
					<img id="okevent" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			</li>

			<li class="nav-item">
				<a class="nav-link" id="tab-ventilation" href="#nav-ventilation" data-toggle="tab" role="tab" aria-controls="nav-ventilation"
					aria-selected="false">
					<img src="display/images/chronometre.svg" height="25">
					{t}Mesures de ventilation{/t}
					<img id="okventilation" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			</li>

			<li class="nav-item">
				<a class="nav-link" id="tab-injection" href="#nav-injection" data-toggle="tab" role="tab" aria-controls="nav-injection"
					aria-selected="false">
					<img src="display/images/injection.png" height="25">
					{t}Événements liés aux séquences{/t}
					<img id="okinjection" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			</li>

			{if $dataPoisson.sexe_libelle_court == "f"}
			<li class="nav-item">
				<a class="nav-link" id="tab-biopsie" href="#nav-biopsie" data-toggle="tab" role="tab" aria-controls="nav-biopsie"
					aria-selected="false">
					<img src="display/images/biopsie.svg" height="25">
					{t}Biopsies{/t}
					<img id="okbiopsie" src="display/images/ok_icon.png" height="15" hidden>
				</a>
			</li>
			{/if}
		</ul>
		<div class="tab-content" id="nav-tabContent">
			<div class="tab-pane active in" id="nav-detail" role="tabpanel" aria-labelledby="tab-detail">
				<div class="row">
					{include file="repro/poissonCampagneDetail.tpl"}
				</div>
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


A SUIVRE...


		<div class="tab-pane fade" id="nav-event" role="tabpanel" aria-labelledby="tab-event">
			{if $droits["poissonGestion"]==1}
			<div class="row">
				<a href="index.php?module=evenementChange&poisson_id={$dataPoisson.poisson_id}&evenement_id=0">
					Nouvel événement...
				</a>
			</div>
			{include file="poisson/evenementList.tpl"}
			{/if}
		</div>
				{include file="poisson/poissonDetail.tpl"}
			</div>
			<div class="tab-pane fade" id="nav-event" role="tabpanel" aria-labelledby="tab-event">
				{if $droits["poissonGestion"]==1}
				<div class="row">
					<a href="index.php?module=evenementChange&poisson_id={$dataPoisson.poisson_id}&evenement_id=0">
						Nouvel événement...
					</a>
				</div>
				{include file="poisson/evenementList.tpl"}
				{/if}
			</div>
		</div>
	</div>
</div>









<table class="tablemulticolonne">
	<tr>
		<td colspan="2">
			{include file="repro/poissonCampagneDetail.tpl"}
		</td>
	</tr>
	<tr>
		<td>
			<fieldset>
				<legend>{t}Séquences de reproduction{/t}</legend>
				{include file="repro/poissonSequenceList.tpl"}
			</fieldset>
			<br>
			<fieldset>
				<legend>{t}Échographies de l'année{/t}</legend>
				{if $droits.reproGestion == 1}
				<a href="index.php?module=evenementChange&evenement_id=0&poisson_id={$dataPoisson.poisson_id}">
					Nouvelle échographie (nouvel événement)...
				</a>
				{/if}
				{include file="poisson/echographieList.tpl"}
				<br>
				{include file="document/documentListOnly.tpl"}
			</fieldset>
			<br>
			<fieldset>
				<legend>{t}Analyses sanguines{/t}</legend>
				{include file="repro/poissonSanguinList.tpl"}
			</fieldset>
			{if $dataPoisson.sexe_libelle_court == "m"}
			<br>
			<fieldset>
				<legend>{t}Prélèvements de sperme{/t}</legend>
				{include file="repro/spermeList.tpl"}
			</fieldset>
			{/if}
		</td>
		<td>
			<fieldset>
				<legend>{t}Transferts de l'année{/t}</legend>
				{include file="poisson/transfertList.tpl"}
			</fieldset>
			<fieldset>
				<legend>{t}Événements liés aux séquences{/t}</legend>
				{include file="repro/psEvenementList.tpl"}
			</fieldset>
			<br>
			<fieldset>
				<legend>{t}Mesures de ventilation{/t}</legend>
				{include file="poisson/ventilationList.tpl"}
			</fieldset>
			<br>
			<fieldset>
				<legend>{t}Injections{/t}</legend>
				{include file="repro/injectionList.tpl"}
			</fieldset>
		</td>
	</tr>
	{if $dataPoisson.sexe_libelle_court == "f"}
	<tr>
		<td colspan="2">
			<fieldset>
				<legend>{t}Biopsies{/t}</legend>
				{include file="repro/poissonBiopsieList.tpl"}
			</fieldset>
		</td>
	</tr>
	{/if}

</table>
