<form method="get" action="index.php" class="form-horizontal col-md-8">
	<input type="hidden" name="module" value="bassinDisplay">
	<input type="hidden" name="bassin_id" value="{$dataBassin.bassin_id}">
	<div class="row">
		<label class="control-label col-md-2">{t}Date de départ :{/t}</label>
		<div class="col-md-2">
			<input class="date form-control" name="date_debut" value="{$searchAlim.date_debut}">
		</div>
		<label class="control-label col-md-2">{t}Date de fin :{/t}</label>
		<div class="col-md-2">
			<input class="date form-control" name="date_fin" value="{$searchAlim.date_fin}">
		</div>
		<div class="col-md-4">
			<input class="button btn-success" value="{t}Rechercher{/t}" type="submit">
		</div>
	</div>
</form>
<div class="col-lg-12">
	<div class="row">
		<table id="calimList" class="table datatable table-hover table-bordered">
			<thead>
				<tr>
					<th>{t}Date{/t}</th>
					<th>{t}Total distribué{/t}</th>
					<th>{t}Reste{/t}</th>
					{section name=lst loop=$alimentListe}
					<th>{$alimentListe[lst].aliment_libelle_court}</th>
					{/section}
				</tr>
			</thead>
			<tbody>
				{section name=lst loop=$dataAlim}
				<tr>
					<td>{$dataAlim[lst].distrib_quotidien_date}</td>
					<td>{$dataAlim[lst].total_distribue}</td>
					<td>{$dataAlim[lst].reste}</td>
					{section name=ali loop=$alimentListe}
					{$nom=$alimentListe[ali].aliment_libelle_court}
					<td>{$dataAlim[lst][$nom]}</td>
					{/section}
				</tr>
				{/section}
			</tbody>
		</table>
	</div>
</div>