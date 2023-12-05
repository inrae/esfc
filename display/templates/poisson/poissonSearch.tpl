<script>
	$(document).ready(function () {
		/*	$("select").change(function () {
				$("#search").submit();
			} );
		*/
		$("#search").submit(function (event) {
			var retour = false;
			if ($("#texte").val().length > 1)
				retour = true;
			if ($("#categorie").val() > 0)
				retour = true;
			if ($("#statut").val() > 0)
				retour = true;
			if ($("#sexe").val() > 0)
				retour = true;
			if ($("#eventSearch").val().length > 0) {
				retour = true;
			}
			if (retour === false)
				event.preventDefault();
		});
	});
</script>
<form method="get" action="index.php" id="search" class="col-lg-12 form-horizontal">
	<input type="hidden" name="isSearch" value="1">
	<input type="hidden" name="module" value="poissonList">
	<div class="row">
		<div class="form-group">
			<label class="control-label col-md-2" for="texte">
				{t}Libellé à rechercher (id, tag, prenom, matricule, cohorte) :{/t}
			</label>
			<div class="col-md-2">
				<input id="texte" class="form-control" name="texte" value="{$poissonSearch.texte}">
			</div>

			<label class="control-label col-md-1" for="site_id">
				{t}Site :{/t}
			</label>
			<div class="col-md-2">
				<select name="site_id" class="form-control">
					<option value="" {if $poissonSearch.site_id=="" }selected{/if}>
						{t}Sélectionnez le site...{/t}
					</option>
					{section name=lst loop=$site}
					<option value="{$site[lst].site_id}" {if $poissonSearch.site_id==$site[lst].site_id}selected{/if}>
						{$site[lst].site_name}
					</option>
					{/section}
				</select>
			</div>
			<label class="control-label col-md-1" for="cohorte">
				{t}Cohorte :{/t}
			</label>
			<div class="col-md-2">
				<select id="cohorte" name="cohorte" class="form-control">
					<option value="" {if $poissonSearch.cohorte=="" }selected{/if}>
						{t}Sélectionnez la cohorte...{/t}
					</option>
					{section name=lst loop=$cohortes}
					<option value="{$cohortes[lst].cohorte}" {if $poissonSearch.cohorte==$cohortes[lst].cohorte}selected{/if}>
						{$cohortes[lst].cohorte}
					</option>
					{/section}
				</select>
			</div>

		</div>
		<div class="row">
			<div class="form-group">
				<label for="categorie" class="control-label col-md-2">
					{t}Catégorie :{/t}
				</label>
				<div class="col-md-2">
					<select id="categorie" name="categorie" id="categorie" class="form-control">
						<option value="" {if $categorie[lst].categorie_id=="" }selected{/if}>
							{t}Sélectionnez la catégorie...{/t}
						</option>
						{section name=lst loop=$categorie}
						<option value="{$categorie[lst].categorie_id}" {if
							$poissonSearch.categorie==$categorie[lst].categorie_id}selected{/if}>
							{$categorie[lst].categorie_libelle}
						</option>
						{/section}
					</select>
				</div>
				<label class="control-label col-md-1" for="statut">
					{t}Statut de l'animal :{/t}
				</label>
				<div class="col-md-2">
					<select id="statut" name="statut" id="statut" class="form-control">
						<option value="" {if $poissonSearch.statut=="" }selected{/if}>
							{t}Sélectionnez le statut...{/t}
						</option>
						{section name=lst loop=$statut}
						<option value="{$statut[lst].poisson_statut_id}" {if
							$poissonSearch.statut==$statut[lst].poisson_statut_id}selected{/if}>
							{$statut[lst].poisson_statut_libelle}
						</option>
						{/section}
					</select>
				</div>
				<label for="sexe" class="control-label col-md-1">
					{t}Sexe :{/t}
				</label>
				<div class="col-md-2">
					<select id="sexe" name="sexe" class="form-control">
						<option value="" {if $poissonSearch.sexe=="" }selected{/if}>
							{t}Sélectionnez le sexe...{/t}
						</option>
						{section name=lst loop=$sexe}
						<option value="{$sexe[lst].sexe_id}" {if $poissonSearch.sexe==$sexe[lst].sexe_id}selected{/if}>
							{$sexe[lst].sexe_libelle}
						</option>
						{/section}
					</select>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="form-group">
				<label for="eventSearch" class="control-label col-md-2">
					{t}Recherche par événement enregistré :{/t}
				</label>
				<div class="col-md-2">
					<select id="eventSearch" name="eventSearch" class="form-control">
						<option value="" {if $poissonSearch.eventSearch=="" }selected{/if}>
							{t}Sélectionnez...{/t}
						</option>
						{foreach $eventSearchs as $k => $l}
						<option value="{$k}" {if $poissonSearch.eventSearch==$k}selected{/if}>
							{$l}
						</option>
						{/foreach}
					</select>
				</div>
				<label for="dateFromEvent" class="control-label col-md-1">
					{t}Entre le :{/t}
				</label>
				<div class="col-md-2">
					<input class="datepicker form-control" id="dateFromEvent" name="dateFromEvent"
						value="{$poissonSearch.dateFromEvent}">
				</div>
				<label for="dateToEvent" class="control-label col-md-1">
					{t}et le :{/t}
				</label>
				<div class="col-md-2">
					<input class="datepicker form-control" id="dateToEvent" name="dateToEvent"
						value="{$poissonSearch.dateToEvent}">
				</div>
			</div>
		</div>
		<div class="row">
			<label for="bassin_id" class="control-label col-md-2">
				{t}Recherche par bassin :{/t}
			</label>
			<div class="col-md-2">
				<select class="form-control" id="bassin_id" name="bassin_id">
					<option value="" {if $poissonSearch.bassin_id=="" }selected{/if}>
						{t}Sélectionnez...{/t}
					</option>
					{foreach $bassins as $bassin}
					<option value="{$bassin.bassin_id}" {if $poissonSearch.bassin_id==$bassin.bassin_id}selected{/if}>
						{$bassin.bassin_nom} ({$bassin.site_name} - {$bassin.bassin_zone_libelle} -
						{$bassin.bassin_type_libelle})
					</option>
					{/foreach}
				</select>
			</div>

			<div class="col-md-2 center">
				<input type="submit" id="samplesearch_button" class="btn btn-success" value="{t}Rechercher{/t}">
			</div>

		</div>
		<div class="row">
			<div class="form-group">

				<label for="displayCumulTemp0" class="control-label col-md-2">
					{t}Afficher : le cumul des températures (calcul long) ?{/t}
				</label>
				<div class="col-md-1">
					<label class="radio-inline ">
						<input id="displayCumulTemp0" type="radio" name="displayCumulTemp" value="0" {if
							$poissonSearch.displayCumulTemp==0}checked{/if}>
						{t}non{/t}
					</label>
					<label class="radio-inline ">
						<input type="radio" name="displayCumulTemp" value="1" {if
							$poissonSearch.displayCumulTemp==1}checked{/if}>
						{t}oui{/t}
					</label>
				</div>
				<label class="col-md-1 control-label" for="dateDebutTemp">
					{t}du :{/t}
				</label>
				<div class="col-md-1">
					<input id="dateDebutTemp" class="datepicker form-control" name="dateDebutTemp"
						value="{$poissonSearch.dateDebutTemp}">
				</div>
				<label class="col-md-1 control-label" for="dateFinTemp">
					{t}au :{/t}
				</label>
				<div class="col-md-1">
					<input id="dateFinTemp" class="datepicker form-control" name="dateFinTemp"
						value="{$poissonSearch.dateFinTemp}">
				</div>
			</div>
		</div>
	</div>
</form>