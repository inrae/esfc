<h2>{t}Affichage de la liste des lots de poissons issus de la reproduction{/t}</h2>
<div class="row">
	<div class="col-md-6 col-lg-6 form-horizontal">
		<form method="get" action="index.php" id="search">
			<input type="hidden" name="module" value="lotList">
			<div class="form-group">
				<label for="site_id" class="control-label col-md-2">
					{t}Site :{/t}
				</label>
				<div class="col-md-3">
					<select id="site_id" name="site_id" class="form-control">
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
						{foreach $annees as $year}
						<option value="{$year}" {if $annee==$year}selected{/if}>
							{$year}
						</option>
						{/foreach}
					</select>
				</div>

				<div class="col-md-2 center">
					<input type="submit" class="btn btn-success" value="{t}Rechercher{/t}">
				</div>
			</div>
		</form>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		{include file="repro/lotList.tpl"}
	</div>
</div>