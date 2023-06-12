<script>
	$(document).ready(function () {
		$(".reste").focus(function () {
			//store old value
			$(this).data('oldValue', $(this).val());
		});
		$(".reste").change(function () {
			/*
			* calcule le reste total
			*/
			var oldValue = $(this).data('oldValue');
			if (isNaN(oldValue)) oldValue = 0;
			if (oldValue == "") oldValue = 0;
			var newValue = $(this).val();
			if (isNaN(newValue)) newValue = 0;
			if (newValue == "") newValue = 0;
			var cle = $(this).data('cle');
			var nomChamp = "#reste_total_" + cle;
			var total = $(nomChamp).val();
			if (isNaN(total)) total = 0;
			if (total == "") total = 0;
			total = parseInt(total) - parseInt(oldValue) + parseInt(newValue);
			$(nomChamp).val(total);
			/*
			* Calcul du pourcentage de reste
			*/
			nomChamp = "#total_distribue_" + cle;
			var totalDistrib = $(nomChamp).val();
			if (isNaN(totalDistrib)) totalDistrib = 0;
			if (totalDistrib == "") totalDistrib = 0;
			if (totalDistrib > 0) {
				nomChamp = "#taux_reste_" + cle;
				var taux = parseFloat(total) / parseFloat(totalDistrib) * 100;
				$(nomChamp).val(taux);
			}
		});
		$(".resteTotal").change(function () {
			var total = $(this).val();
			if (isNaN(total)) total = 0;
			if (total == "") total = 0;
			var cle = $(this).data('cle');
			/*
			* Calcul du pourcentage de reste
			*/
			nomChamp = "#total_distribue_" + cle;
			var totalDistrib = $(nomChamp).val();
			if (isNaN(totalDistrib)) totalDistrib = 0;
			if (totalDistrib == "") totalDistrib = 0;
			if (totalDistrib > 0) {
				nomChamp = "#taux_reste_" + cle;
				var taux = parseFloat(total) / parseFloat(totalDistrib) * 100;
				$(nomChamp).val(taux);
			}
		});
	});
</script>
<a href="index.php?module=repartitionList">
	<img src="display/images/list.png" height="25">
	{t}Retour à la liste{/t}
</a>
<h2>{t}Saisie des restes{/t}
	<b>{$data.categorie_libelle}</b> <i>{$data.repartition_name}</i> - {t}Période du{/t}
	<b>{$data.date_debut_periode}</b> {t}au{/t}
	<b>{$data.date_fin_periode}</b>
</h2>
<div class="col-lg-12">
	<div class="row">
		<form class="form-horizontal" id="repartitionForm" method="post" action="index.php">
			<input type="hidden" name="action" value="Write">
			<input type="hidden" name="moduleBase" value="repartitionReste">
			<input type="hidden" name="repartition_id" value="{$data.repartition_id}">
			<input type="hidden" name="date_debut_periode" value="{$data.date_debut_periode}">
			<input type="hidden" name="date_fin_periode" value="{$data.date_fin_periode}">
			<input type="hidden" name="nbJour" value="{$nbJour}">

			<table class="table table-hover table-bordered">
				<thead>
					<tr>
						<th>{t}Bassin{/t}</th>
						{section name=lst loop=$dateArray}
						<th>{t}{$dateArray[lst].libelle}{/t}</th>
						{/section}
						<th>{t}Total reste{/t}</th>
						<th>{t}Commentaire{/t}</th>
						<th>{t}Total distribué{/t}</th>
						<th>{t}Taux de reste{/t}</th>
					</tr>
				</thead>
				<tbody>
					{section name=lst loop=$dataBassin}
					<input name="distribution_id_{$dataBassin[lst].distribution_id}" type="hidden"
						value="{$dataBassin[lst].distribution_id}">
					<input name="bassin_id_{$dataBassin[lst].distribution_id}" type="hidden"
						value="{$dataBassin[lst].bassin_id}">
					<tr>
						<td>{$dataBassin[lst].bassin_nom}</td>
						{foreach from=$dataBassin[lst].reste key=k item=v}
						<td>
							<input class="form-control reste nombre" data-cle="{$dataBassin[lst].distribution_id}"
								name="reste_{$k}_{$dataBassin[lst].distribution_id}"
								id="reste_{$k}_{$dataBassin[lst].distribution_id}" value="{$v}">
						</td>
						{/foreach}
						<td>
							<input class="form-control nombre resteTotal" name="reste_total_{$dataBassin[lst].distribution_id}"
								data-cle="{$dataBassin[lst].distribution_id}"
								id="reste_total_{$dataBassin[lst].distribution_id}"
								value="{$dataBassin[lst].reste_total}">
						</td>
						<td>
							<input class="form-control" name="ration_commentaire_{$dataBassin[lst].distribution_id}"
								data-cle="{$dataBassin[lst].distribution_id}"
								id="ration_commentaire_{$dataBassin[lst].distribution_id}"
								value="{$dataBassin[lst].ration_commentaire}">
						</td>
						<td>
							<input name="total_periode_distribue_{$dataBassin[lst].distribution_id}" class="form-control nombre"
								readonly id="total_periode_distribue_{$dataBassin[lst].distribution_id}"
								value="{$dataBassin[lst].total_periode_distribue}">
						</td>
						<td>
							<input name="taux_reste_{$dataBassin[lst].distribution_id}" class="form-control nombre" readonly
								id="taux_reste_{$dataBassin[lst].distribution_id}"
								value="{$dataBassin[lst].taux_reste}">
						</td>
					<tr>
						{/section}
				</tbody>
			</table>
			<div class="row">
				<div class="form-group center">
					<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
				</div>
			</div>
		</form>
	</div>
</div>