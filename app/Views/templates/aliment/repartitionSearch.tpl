<form method="get" action="repartitionList" id="searchRepartition">
	<input type="hidden" name="isSearch" value="1">
	<div class="col-md-8 col-lg 6 form-horizontal">
		<div class="row">
			<div class="form-group">
				<label for="categorie_id" class="control-label col-md-2">
					{t}Catégorie d'alimentation :{/t}
				</label>
				<div class="col-md-2">
					<select class="form-control" name="categorie_id" id="categorie_id">
						<option value="" {if $repartitionSearch.categorie_id=="" }selected{/if}>
							{t}Sélectionnez la catégorie...{/t}
						</option>
						{section name=lst loop=$categorie}
						<option value="{$categorie[lst].categorie_id}" {if
							$repartitionSearch.categorie_id==$categorie[lst].categorie_id}selected{/if}>
							{$categorie[lst].categorie_libelle}
						</option>
						{/section}
					</select>
				</div>
				<label for="site_id" class="control-label col-md-2">
					{t}Site :{/t}
				</label>
				<div class="col-md-2">
					<select class="form-control" name="site_id" id="site_id">
						<option value="0" {if $repartitionSearch.site_id=="" }selected{/if}>
							{t}Sélectionnez le site...{/t}
						</option>
						{section name=lst loop=$site}
						<option value="{$site[lst].site_id}" {if
							$repartitionSearch.site_id==$site[lst].site_id}selected{/if}>
							{$site[lst].site_name}
						</option>
						{/section}
					</select>
				</div>

			</div>
		</div>
		<div class="row">
			<div class="form-group">
				<label for="date_reference" class="control-label col-md-6">
					{t}Date à partir de laquelle sont affichées les répartitions :{/t}
				</label>
				<div class="col-md-2">
					<input class="datepicker form-control" id="date_reference" name="date_reference"
						value="{$repartitionSearch.date_reference}">
				</div>
				<div class="center col-md-2">
					<input type="submit" value="{t}Rechercher{/t}" class="btn btn-primary">
				</div>
			</div>
		</div>
	</div>
{$csrf}</form>