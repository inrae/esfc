<form method="get" action="index.php" id="search">
	<input type="hidden" name="isSearch" value="1">
	<input type="hidden" name="module" value="repartTemplateList">
	<div class="col-md-6 form-horizontal" id="tableaffichage">
		<div class="row">
			<div class="form-group">
				<label for="categorie_id" class="col-md-4 control-label">{t}Catégorie d'alimentation :{/t}</label>
				<div class="col-md-7">
					<select name="categorie_id" id="categorie_id" class="form-control">
						<option value="" {if $repartTemplateSearch.categorie_id=="" }selected{/if}>{t}Sélectionnez la catégorie...{/t}</option>
						{section name=lst loop=$categorie}
						<option value="{$categorie[lst].categorie_id}" {if
							$repartTemplateSearch.categorie_id==$categorie[lst].categorie_id}selected{/if}>
							{$categorie[lst].categorie_libelle}
						</option>
						{/section}
					</select>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="form-group">
				<label for="categorie_id" class="col-md-4 control-label">{t}Modèle de répartition actuellement utilisable ?{/t}</label>
				<div class="col-md-2">
					<select name="actif" class="form-control">
						<option value="-1" {if $repartTemplateSearch.actif=="-1" }selected{/if}>Indifférent</option>
						<option value="1" {if $repartTemplateSearch.actif=="1" }selected{/if}>Oui</option>
						<option value="0" {if $repartTemplateSearch.actif=="0" }selected{/if}>Non</option>
					</select>
				</div>
				<div class="center col-md-2">
					<input type="submit" class="btn btn-success" value="{t}Rechercher{/t}">
				</div>
			</div>
		</div>
	</div>
</form>