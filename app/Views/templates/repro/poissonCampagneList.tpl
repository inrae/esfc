<link href="display/node_modules/c3/c3.min.css" rel="stylesheet" type="text/css">
<script src="display/node_modules/d3/dist/d3.min.js" charset="utf-8"></script>
<script src="display/node_modules/c3/c3.min.js"></script>
<script>
	$(document).ready(function () {
		$(".confirmation").on('click', function () {
			return confirm("{t}Confirmez-vous la suppression du reproducteur pour l'année considérée ?{/t}");
		});
		$("#clistform").submit(function () {
			return confirm("{t}Confirmez-vous le changement de statut pour les poissons sélectionnés ?{/t}");
		});
		$("#campagneinit").on('click', function () {
			return confirm("{t}Confirmez-vous le rajout de tous les adultes vivants dans la liste ?{/t}");
		});
		var poissonNom = "{$poisson_nom}";
		if (poissonNom.length > 0) {
			var chart = c3.generate({
				bindto: '#graphiqueMasse',
				data: {
					xs: {
						'data1': 'x'
					},
					//	    x: 'x',
					xFormat: '%d/%m/%Y', // 'xFormat' can be used as custom format of 'x'
					columns: [
						[{$massex }],
						[{$massey }]
					],
					names: {
						data1: '{$poisson_nom}'
					}
				},
				axis: {
					x: {
						type: 'timeseries',
						tick: {
							format: '%d/%m/%Y',
							rotate: '90'
						}
					},
					y: {
						label: 'grammes'
					}
				},
				grid: {
					y: {
						show: true
					}
				},
				size: {
					width: '800'
				},
				tooltip: {
					position: function (data, width, height, element) {
						return { top: 0, left: width }
					}
				}

			});
		}

	});
//
</script>
<form method="get" action="poissonCampagneList" id="search">
	<input type="hidden" name="isSearch" value="1">
	<div class="row">
		<div class="col-md-6 col-lg-6 form-horizontal">
			<div class="form-group">
				<label for="selectStatut" class="control-label col-md-2">
					{t}Statut de reproduction :{/t}
				</label>
				<div class="col-md-3">
					<select id="selectStatut" name="repro_statut_id" class="form-control">
						<option value="0" {if $dataSearch.repro_statut_id==0}selected{/if}>
							{t}Sélectionnez le statut...{/t}
						</option>
						{section name=lst loop=$dataReproStatut}
						<option value="{$dataReproStatut[lst].repro_statut_id}" {if
							$dataReproStatut[lst].repro_statut_id==$dataSearch.repro_statut_id}selected{/if}>
							{$dataReproStatut[lst].repro_statut_libelle}
						</option>
						{/section}
					</select>
				</div>
				<label for="site_id" class="control-label col-md-2">
					{t}Site :{/t}
				</label>
				<div class="col-md-3">
					<select id="site_id" name="site_id" class="form-control">
						<option value="" {if $site_id=="" }selected{/if}>
							{t}Sélectionnez le site...{/t}
						</option>
						{section name=lst loop=$site}
						<option value="{$site[lst].site_id}" } {if
							$site[lst].site_id==$dataSearch.site_id}selected{/if}>
							{$site[lst].site_name}
						</option>
						{/section}
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="annee" class="control-label col-md-2">
					{t}Année :{/t}
				</label>
				<div class="col-md-3">
					<select name="annee" id="annee" class="form-control">
						{foreach $annees as $annee}
						<option value="{$annee}" {if $annee==$dataSearch.annee}selected{/if}>
							{$annee}
						</option>
						{/foreach}
					</select>
				</div>
				<div class="col-md-2 center">
					<input type="submit" class="btn btn-success" value="{t}Rechercher{/t}">
				</div>
			</div>
		</div>
		<div class="col-md-6 col-lg-6">
			<div id="graphiqueMasse"></div>
		</div>
	</div>
{$csrf}</form>

{if $dataSearch.isSearch == 1}
<div class="row">
	<div class="col-md-3">
		{if $rights.reproGestion == 1}
		<a id="campagneinit" href="poissonCampagneInit&annee={$dataSearch.annee}">
			{t}Ajouter tous les adultes vivants à la campagne...{/t}
		</a>
		{/if}
	</div>
</div>



<form id="clistform" method="post" action="poissonCampagneChangeStatut">
	<div class="row">
		<table class="table table-bordered table-hover datatable display" id="cpoissonList">
			<thead>
				<tr>
					<th>{t}Données d'élevage{/t}</th>
					<th>{t}Identification{/t}</th>
					<th>{t}Statut de reproduction{/t}</th>
					<th>{t}Cohorte{/t}</th>
					<th>{t}Sexe{/t}</th>
					<th>{t}Masse actuelle{/t}</th>
					<th>{t}Croissance{/t}</th>
					<th>{t}Tx de croissance journalier{/t}</th>
					<th>{t}Specific growth rate{/t}</th>
					<th>{t}Années de croisement{/t}</th>
					<th>{t}Séquences{/t}</th>
					<th>{t}Sélection{/t}</th>
				</tr>
			</thead>
			<tbody>
				{section name=lst loop=$data}
				<tr>
					<td class="center">
						<a href=poissonDisplay?poisson_id={$data[lst].poisson_id}>
							<img src="display/images/fish.png" height="24"
								title="Accéder à la fiche détaillée du poisson">
						</a>
					<td>
						<a
							href="poissonCampagneDisplay?poisson_campagne_id={$data[lst].poisson_campagne_id}">
							{$data[lst].matricule} {$data[lst].prenom} {$data[lst].pittag_valeur}
						</a>
						{if $data[lst].poisson_statut_id != 1} ({$data[lst].poisson_statut_libelle}){/if}
					</td>
					<td>{$data[lst].repro_statut_libelle}</td>

					<td class="center">{$data[lst].cohorte}</td>
					<td class="center">{$data[lst].sexe_libelle_court}</td>
					<td class="right">{$data[lst].masse}</td>
					<td class="center  {if $graphique_id == $data[lst].poisson_id} selected{/if}">
						<a href="poissonCampagneList?graphique_id={$data[lst].poisson_id}">
							<img src="display/images/chart.png" height="25">
						</a>
					</td>
					<td class="right {if $data[lst].tx_croissance_journalier > 0.02}green{/if}">
						{$data[lst].tx_croissance_journalier}
					</td>
					<td class="right {if $data[lst].specific_growth_rate > 0.02}green{/if}">
						{$data[lst].specific_growth_rate}
					</td>
					<td>{$data[lst].annees}</td>
					<td>{$data[lst].sequences}</td>
					<td class="center">
						<input type="checkbox" name="poisson_campagne_id[]" value={$data[lst].poisson_campagne_id}>
					</td>
				</tr>
				{/section}
			</tbody>
		</table>
	</div>
	<div class="row">
		<div class="col-md-6 form-horizontal">
			<fieldset>
				<legend>{t}Pour les poissons sélectionnés :{/t}</legend>
				<div class="form-group">
					<label for="repro_statut_id" class="control-label col-md-4">
						{t}Sélectionnez le statut...{/t}
					</label>
					<div class="col-md-4">
						<select name="repro_statut_id" id="repro_statut_id" class="form-control">
							<option value="0" {if $dataSearch.repro_statut_id==0}selected{/if}>
								&nbsp;
							</option>
							{section name=lst loop=$dataReproStatut}
							<option value="{$dataReproStatut[lst].repro_statut_id}">
								{$dataReproStatut[lst].repro_statut_libelle}
							</option>
							{/section}
						</select>
					</div>
					<div class="col-md-2 center">
						<input type="submit" class="btn btn-success" value="{t}Modifier{/t}">
					</div>
				</div>
			</fieldset>
		</div>
	</div>
{$csrf}</form>
{/if}