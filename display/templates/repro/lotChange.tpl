<a href="index.php?module=lotList">
	<img src="display/images/list.png" height="25">
	{t}Retour à la liste des lots{/t}
</a>
{if $sequence.sequence_id > 0}
&nbsp;
<a href="index.php?module=sequenceDisplay&sequence_id={$sequence.sequence_id}">
	<img src="display/images/sexe.svg" height="25">
	{t}Retour à la séquence{/t} {$sequence.sequence_nom} {$sequence.sequence_date_debut}
</a>
{/if}
{if $data.lot_id > 0}
&nbsp;
<a href="index.php?module=lotDisplay&lot_id={$data.lot_id}">
	<img src="display/images/fishlot.svg" height="25">
	{t}Retour au détail du lot{/t}
</a>
{/if}
<h2>{t}Caractéristiques du lot{/t}</h2>

<div class="row">
	<div class="col-md-6">
		<form class="form-horizontal" id="lotForm" method="post" action="index.php">
			<input type="hidden" name="action" value="Write">
			<input type="hidden" name="moduleBase" value="lot">
			<input type="hidden" name="lot_id" value="{$data.lot_id}">
			<div class="form-group">
				<label for="croisement_id" class="control-label col-md-4">
					{t}Croisement d'origine :{/t}<span class="red">*</span>
				</label>
				<div class="col-md-8">
					<select id="croisement_id" class="form-control" name="croisement_id">
						{section name=lst loop=$croisements}
						<option value="{$croisements[lst].croisement_id}" {if
							$croisements[lst].croisement_id==$data.croisement_id}selected{/if}>
							{$croisements[lst].parents}
						</option>
						{/section}
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="lot_nom" class="control-label col-md-4">
					{t}Nom du lot :{/t}<span class="red">*</span>
				</label>
				<div class="col-md-8">
					<input id="lot_nom" class="form-control" name="lot_nom" value="{$data.lot_nom}">
				</div>
			</div>
			<div class="form-group">
				<label for="eclosion_date" class="control-label col-md-4">
					{t}Date d'éclosion :{/t}
				</label>
				<div class="col-md-8">
					<input id="eclosion_date" class="form-control datepicker" name="eclosion_date"
						value="{$data.eclosion_date}">
				</div>
			</div>
			<div class="form-group">
				<label for="nb_larve_initial" class="control-label col-md-4">
					{t}Nombre de larves estimé :{/t}
				</label>
				<div class="col-md-8">
					<input id="nb_larve_initial" class="form-control taux" name="nb_larve_initial"
						value="{$data.nb_larve_initial}">
				</div>
			</div>
			<div class="form-group">
				<label for="nb_larve_compte" class="control-label col-md-4">
					{t}Nombre de larves comptées :{/t}
				</label>
				<div class="col-md-8">
					<input id="nb_larve_compte" class="form-control taux" name="nb_larve_compte"
						value="{$data.nb_larve_compte}">
				</div>
			</div>
			<fieldset>
				<legend>{t}Marquage VIE{/t}</legend>
				<div class="form-group">
					<label for="vie_date_marquage" class="control-label col-md-4">
						{t}Date du marquage :{/t}
					</label>
					<div class="col-md-8">
						<input id="vie_date_marquage" class="form-control datepicker" name="vie_date_marquage"
							value="{$data.vie_date_marquage}">
					</div>
				</div>
				<div class="form-group">
					<label for="vie_modele_id" class="control-label col-md-4">
						{t}Modèle de marquage VIE utilisé :{/t}
					</label>
					<div class="col-md-8">
						<select id="vie_modele_id" class="form-control" name="vie_modele_id">
							<option value="" {if $data.vie_modele_id=="" }selected{/if}>
								{t}Sélectionnez...{/t}
							</option>
							{section name=lst loop=$modeles}
							<option value="{$modeles[lst].vie_modele_id}" {if
								$data.vie_modele_id==$modeles[lst].vie_modele_id}selected{/if}>
								{$modeles[lst].couleur}, {$modeles[lst].vie_implantation_libelle},
								{$modeles[lst].vie_implantation_libelle2}
							</option>
							{/section}
						</select>
					</div>
				</div>
			</fieldset>
			<div class="form-group center">
				<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
				{if $data.lot_id > 0 &&$droits["reproAdmin"] == 1}
				<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
				{/if}
			</div>
		</form>
	</div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>