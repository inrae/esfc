<a href="lotList">
	<img src="display/images/list.png" height="25">
	{t}Retour à la liste des lots{/t}
</a>
&nbsp;
<a href="lotDisplay?lot_id={$data.lot_id}">
	<img src="display/images/fishlot.svg" height="25">
	{t}Retour au lot{/t} {$dataLot.lot_nom} {$dataLot.eclosion_date}
</a>
<h2>{t}Mesures pour le lot{/t}</h2>
<div class="row">
	<div class="col-md-6">
		<form class="form-horizontal" id="lotMesureForm" method="post" action="lotMesureWrite">			
			<input type="hidden" name="moduleBase" value="lotMesure">
			<input type="hidden" name="lot_mesure_id" value="{$data.lot_mesure_id}">
			<input type="hidden" name="lot_id" value="{$data.lot_id}">
			<div class="form-group">
				<label for="lot_mesure_date" class="control-label col-md-4">
					{t}Date :{/t}<span class="red">*</span>
				</label>
				<div class="col-md-8">
					<input id="lot_mesure_date" class="form-control datepicker" name="lot_mesure_date" required
						value="{$data.lot_mesure_date}">
				</div>
			</div>
			<div class="form-group">
				<label for="nb_jour" class="control-label col-md-4">
					{t}Nombre de jours depuis l'éclosion (valeur calculée à l'enregistrement) :{/t}
				</label>
				<div class="col-md-8">
					<input id="nb_jour" class="form-control nombre" name="nb_jour" readonly value="{$data.nb_jour}">
				</div>
			</div>
			<div class="form-group">
				<label for="lot_mortalite" class="control-label col-md-4">
					{t}Nbre d'individus morts :{/t}
				</label>
				<div class="col-md-8">
					<input id="lot_mortalite" class="form-control" name="lot_mortalite" class="nombre"
						value="{$data.lot_mortalite}">
				</div>
			</div>
			<div class="form-group">
				<label for="lot_mesure_masse" class="control-label col-md-4">
					{t}Masse globale (en grammes) :{/t}
				</label>
				<div class="col-md-8">
					<input id="lot_mesure_masse" class="form-control taux" name="lot_mesure_masse"
						value="{$data.lot_mesure_masse}">
				</div>
			</div>
			<div class="form-group">
				<label for="lot_mesure_masse_indiv" class="control-label col-md-4">
					{t}Masse individuelle (en grammes) :{/t}
				</label>
				<div class="col-md-8">
					<input id="lot_mesure_masse_indiv" class="form-control taux" name="lot_mesure_masse_indiv"
						value="{$data.lot_mesure_masse_indiv}">
				</div>
			</div>

			<div class="form-group center">
				<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
				{if $data.lot_mesure_id > 0 &&$rights["reproGestion"] == 1}
				<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
				{/if}
			</div>
		{$csrf}</form>
	</div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>