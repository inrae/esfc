<form method="get" action="bassinList" id="search" class="form-horizontal col-lg-8">
	<div class="row">
		<input type="hidden" name="isSearch" value="1">
		<div class="col-md-12">
			<div class="row">
				<div class="form-group">
					<label class="control-label col-md-2">{t}Nom :{/t}</label>
					<div class="col-md-4">
						<input class="form-control" name="bassin_nom" value="{$bassinSearch.bassin_nom}">
					</div>
					<label class="control-label col-md-2">{t}Bassin en activité ?{/t}</label>
					<div class="col-md-4">
						<label class="radio-inline"><input type="radio" name="bassin_actif" value="1" {if $bassinSearch.bassin_actif==1}checked{/if}>
							{t}oui{/t}
						</label>
						<label class="radio-inline">
							<input type="radio" name="bassin_actif" value="0" {if $bassinSearch.bassin_actif==0}checked{/if}>
							{t}non{/t}
						</label>
						<label class="radio-inline">
							<input type="radio" name="bassin_actif" value="" {if $bassinSearch.bassin_actif==""}checked{/if}>
							{t}Indifférent{/t}
						</label>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="control-label col-md-2">{t}Type de bassin :{/t}</label>
					<div class="col-md-4">
						<select class="form-control" name="bassin_type">
							<option value="" {if $bassinSearch.bassin_type=="" }selected{/if}>
								{t}Sélectionnez le type de bassin...{/t}
							</option>
							{section name=lst loop=$bassin_type}
							<option value="{$bassin_type[lst].bassin_type_id}" {if $bassinSearch.bassin_type==$bassin_type[lst].bassin_type_id}selected{/if}>
								{$bassin_type[lst].bassin_type_libelle}
							</option>
							{/section}
						</select>
					</div>
						
					<label class="control-label col-md-2">{t}Usage :{/t}</label>

					<div class="col-md-4">
						<select class="form-control" name="bassin_usage">
							<option value="" {if $bassinSearch.bassin_usage=="" }selected{/if}>
								{t}Sélectionnez l'usage du bassin...{/t}
							</option>
							{section name=lst loop=$bassin_usage}
							<option value="{$bassin_usage[lst].bassin_usage_id}" {if $bassinSearch.bassin_usage==$bassin_usage[lst].bassin_usage_id}selected{/if}>
								{$bassin_usage[lst].bassin_usage_libelle}
							</option>
							{/section}
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="control-label col-md-2">{t}Zone d'implantation :{/t}</label>
					<div class="col-md-4">
						<select class="form-control" name="bassin_zone">
							<option value="" {if $bassinSearch.bassin_zone=="" }selected{/if}>
								{t}Sélectionnez la zone d'implantation...{/t}
							</option>
							{section name=lst loop=$bassin_zone}
							<option value="{$bassin_zone[lst].bassin_zone_id}" {if $bassinSearch.bassin_zone==$bassin_zone[lst].bassin_zone_id}selected{/if}>
								{$bassin_zone[lst].bassin_zone_libelle}
							</option>
							{/section}
						</select>
					</div>					
					<label class="control-label col-md-2">{t}Circuit d'eau :{/t}</label>
					<div class="col-md-4">
						<select name="circuit_eau" class="form-control" >
							<option value="" {if $bassinSearch.circuit_eau=="" }selected{/if}>
								{t}Sélectionnez le circuit d'eau...{/t}</option>
							{section name=lst loop=$circuit_eau}
							<option value="{$circuit_eau[lst].circuit_eau_id}" {if $bassinSearch.circuit_eau==$circuit_eau[lst].circuit_eau_id}selected{/if}>
								{$circuit_eau[lst].circuit_eau_libelle}
							</option>
							{/section}
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="control-label col-md-2">{t}Site :{/t}</label>
					<div class="col-md-4">
						<select class="form-control" name="site_id">
							<option value="" {if $bassinSearch.site_id=="" }selected{/if}>
								{t}Sélectionnez le site...{/t}
							</option>
							{section name=lst loop=$site}
							<option value="{$site[lst].site_id}" {if $bassinSearch.site_id==$site[lst].site_id}selected{/if}>
								{$site[lst].site_name}
							</option>
							{/section}
						</select>
					</div>
					<div class="col-md-2 col-md-offset-2">
						<input type="submit" class="button btn-success" value="{t}Rechercher{/t}">
					</div>
				</div>
			</div>
		</div>
	</div>
{$csrf}</form>
