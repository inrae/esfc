<div class="col-md-8">
	<div class="row">
		<form method="get" action="index.php" class="form-horizontal">
			<input type="hidden" name="isSearch" value="1">
			<input type="hidden" name="module" value="circuitEauList">
			<div class="row">
				<div class="form-group">
					<label for="circuit_eau_libelle" class="control-label col-md-3">
						{t}Nom du circuit d'eau :{/t}
					</label>
					<div class="col-md-3">
						<input id="circuit_eau_libelle" class="form-control" name="circuit_eau_libelle"
							value="{$circuitEauSearch.circuit_eau_libelle}" autofocus>
					</div>
					<label for="site_id" class="control-label col-md-3">{t}Site :{/t}</label>
					<div class="col-md-2">
						<select name="site_id" id="site_id" class="form-control">
							<option value="" {if $circuitEauSearch.site_id=="" }selected{/if}>
								{t}Sélectionnez le site...{/t}
							</option>
							{section name=lst loop=$site}
							<option value="{$site[lst].site_id}" {if
								$circuitEauSearch.site_id==$site[lst].site_id}selected{/if}>
								{$site[lst].site_name}
							</option>
							{/section}
						</select>
					</div>
				</div>
				<div class="row">
					<div class="form-group">

						<label for="c1" class="control-label col-md-3">
							{t}Circuit d'eau en service ?{/t}
						</label>
						<div class="col-md-3">
							<label class="radio-inline">
								<input id="c1" type="radio" name="circuit_eau_actif" value="1" {if
									$circuitEauSearch.circuit_eau_actif==1}checked{/if}>
								{t}oui{/t}
							</label>
							<label class="radio-inline">
								<input id="c0" type="radio" name="circuit_eau_actif" value="0" {if
									$circuitEauSearch.circuit_eau_actif==0}checked{/if}>
								{t}non{/t}
							</label>
							<label class="radio-inline">
								<input id="c-1" type="radio" name="circuit_eau_actif" value="-1" {if
									$circuitEauSearch.circuit_eau_actif==-1}checked{/if}>
								{t}indifférent{/t}
							</label>
						</div>
						<label for="analyse_date" class="control-label col-md-3">
							{t}Date de référence pour les analyses d'eau :{/t}
						</label>
						<div class="col-md-2">
							<input id="analyse_date" name="analyse_date" value="{$circuitEauSearch.analyse_date}"
								class="datepicker form-control">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 center">
						<input type="submit" value="Rechercher" class="btn btn-primary button-valid">
					</div>
				</div>

			</div>
		</form>
	</div>
</div>