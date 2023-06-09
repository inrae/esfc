<div class="row">
	<div class="col-md-6 form-horizontal">
		<form id="repartitionForm" method="post" action="index.php">
			<input type="hidden" name="module" value="repartitionCreate">
			<input type="hidden" name="repartition_id" value="0">
			<div class="form-group">
				<label for="categorie_id" class="control-label col-md-4">
					{t}Catégorie d'alimentation :{/t}<span class="red">*</span>
				</label>
				<div class="col-md-8">
					<select class="form-control" name="categorie_id" id="categorie_id" {if $data.repartition_id >
						0}disabled{/if}>
						{section name=lst loop=$categorie}
						<option value="{$categorie[lst].categorie_id}" {if
							$data.categorie_id==$categorie[lst].categorie_id}selected{/if}>
							{$categorie[lst].categorie_libelle}
						</option>
						{/section}
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="site_id" class="control-label col-md-4">
					{t}Site :{/t}
				</label>
				<div class="col-md-8">
					<select class="form-control" id="site_id" name="site_id">
						{foreach $site as $s}
						<option value="{$s.site_id}" {if $s.site_id==$data.site_id}selected{/if}>
							{$s.site_name}
						</option>
						{/foreach}
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="repartition_name" class="control-label col-md-4">
					{t}Nom :{/t}
				</label>
				<div class="col-md-8">
					<input class="form-control" id="repartition_name" name="repartition_name"
						value="{$data.repartition_name}" placeholder="{t}Élevage, repro...{/t}">
				</div>
			</div>
			<div class="form-group">
				<label for="date_debut_periode" class="control-label col-md-4">
					{t}Date début :{/t}
				</label>
				<div class="col-md-8">
					<input class="datepicker form-control" id="date_debut_periode" name="date_debut_periode"
						value="{$data.date_debut_periode}">
				</div>
			</div>
			<div class="form-group">
				<label for="" class="control-label col-md-4">
					{t}Date fin :{/t}
				</label>
				<div class="col-md-8">
					<input class="datepicker form-control" id="date_fin_periode" name="date_fin_periode"
						value="{$data.date_fin_periode}">
				</div>
			</div>
			<div class="form-group">
				<div class="center">
					<input class="btn btn-primary button-valid" type="submit" value="Enregistrer">
				</div>
			</div>
		</form>
	</div>
</div>