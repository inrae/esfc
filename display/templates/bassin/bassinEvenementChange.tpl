<a href="index.php?module={$bassinParentModule}">{t}Retour à la liste des bassins{/t}</a>
> <a href="index.php?module=bassinDisplay&bassin_id={$data.bassin_id}">{t}Retour au bassin{/t}</a>
<h2>{t}Modification d'un événement survenu dans le bassin{/t} {$dataBassin.bassin_nom}
</h2>

<div class="row">
	<div class="col-md-6">
		<form class="form-horizontal" id="bassinEvenementForm" method="post" action="index.php">
			<input type="hidden" name="action" value="Write">
			<input type="hidden" name="moduleBase" value="bassinEvenement">
			<input type="hidden" name="bassin_evenement_id" value="{$data.bassin_evenement_id}">
			<input type="hidden" name="bassin_id" value="{$data.bassin_id}">
			<div class="form-group">
				<label for="bassin_evenement_type_id" class="control-label col-md-4">{t}Type d'événement :{/t}<span class="red">*</span></label>
				<div class="col-md-8">
					<select id="bassin_evenement_type_id" class="form-control" name="bassin_evenement_type_id">
						{section name=lst loop=$dataEvntType}
						<option value="{$dataEvntType[lst].bassin_evenement_type_id}" {if
							$dataEvntType[lst].bassin_evenement_type_id==$data.bassin_evenement_type_id}selected{/if}>
							{$dataEvntType[lst].bassin_evenement_type_libelle}
						</option>
						{/section}
					</select>

				</div>
			</div>
			<div class="form-group">
				<label for="" class="control-label col-md-4">{t}Date :{/t}<span class="red">*</span></label>
				<div class="col-md-8">
					<input id="" class="form-control datepicker" name="bassin_evenement_date"
						value="{$data.bassin_evenement_date}">
				</div>
			</div>
			<div class="form-group">
				<label for="bassin_evenement_commentaire" class="control-label col-md-4">{t}Commentaires :{/t}</label>
				<div class="col-md-8">
					<input id="bassin_evenement_commentaire" class="form-control" name="bassin_evenement_commentaire"
						value="{$data.bassin_evenement_commentaire}">
				</div>
			</div>


			<div class="form-group center">
				<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
				{if $data.bassin_evenement_id > 0 &&$droits["bassinAdmin"] == 1}
				<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
				{/if}
		</form>
	</div>
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>