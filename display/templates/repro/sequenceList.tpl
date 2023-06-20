<script>
	$(document).ready(function () {
		$("#annee").change(function () {
			$("#campagneAnnee").val($("#annee").val());
		});
		$("#site").change(function () {
			var site = $(this).val();
			if (site.length > 0) {
				$("#campagneSite").val(site);
			}
		});
		$("#initForm").submit(function (event) {
			if (!confirm("{t}Confirmez l'initialisation des bassins pour la campagne et le site considérés{/t}")) {
				event.preventDefault();
			}
		});
	});
</script>

<h2>{t}Séquences de reproduction{/t}</h2>

<form method="get" action="index.php" id="search">
	<input type="hidden" name="module" value="sequenceList">
	<input type="hidden" name="isSearch" value="1">
	<div class="row">
		<div class="col-md-8 col-lg-6 form-horizontal">
			<div class="form-group">
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
	</div>
</form>

<div class="row">
	<div class="col-md-6">
		<fieldset>
			<legend>{t}Séquences{/t}</legend>
			<a href="index.php?module=sequenceChange&sequence_id=0">
				{t}Nouvelle séquence pour l'année{/t}
			</a>
			<table class="table table-bordered table-hover datatable-nopaging-nosearching" id="csequenceList">
				<thead>
					<tr>
						<th>{t}Site{/t}</th>
						<th>{t}Nom de la séquence{/t}</th>
						<th>{t}Date de début{/t}</th>
					</tr>
				</thead>
				<tbody>
					{section name=lst loop=$data}
					<tr>
						<td>{$data[lst].site_name}</td>
						<td>
							<a href="index.php?module=sequenceDisplay&sequence_id={$data[lst].sequence_id}">
								{$data[lst].sequence_nom}
							</a>
						</td>
						<td>{$data[lst].sequence_date_debut}</td>
					</tr>
					{/section}
				</tbody>
			</table>
		</fieldset>
	</div>
	<div class="col-md-6">
		<fieldset>
			<legend>{t}Bassins{/t}</legend>
			{if $droits.reproGestion == 1}
			<form id="initForm" method="post" action="index.php?module=bassinCampagneInit">
				<div class="row">
					<div class="col-md-12 form-horizontal">
						<div class="form-group">
							<label for="campagneSite" class="control-label col-md-2">
								{t}Site :{/t}
							</label>
							<div class="col-md-4">
								<select id="campagneSite" name="site_id" class="form-control">
									{section name=lst loop=$site}
									<option value="{$site[lst].site_id}" } {if
										$site[lst].site_id==$site_id}selected{/if}>
										{$site[lst].site_name}
									</option>
									{/section}
								</select>
							</div>
							<label for="campagneAnnee" class="control-label col-md-2">
								{t}Année :{/t}
							</label>
							<div class="col-md-4">
								<select id="campagneAnnee" name="annee" class="form-control">
									{foreach $annees as $annee}
									<option value="{$annee}" {if $dataSearch.annee==$annee}selected{/if}>
										{$annee}
									</option>
									{/foreach}
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-12 center">
								<input type="submit" class="btn btn-warning"
									value="{t}Initialiser la liste des bassins pour la campagne{/t}">
							</div>
						</div>
					</div>
				</div>
			</form>
			{/if}
			<div class="row">
				{include file="repro/bassinCampagneList.tpl"}
			</div>
		</fieldset>
	</div>
</div>