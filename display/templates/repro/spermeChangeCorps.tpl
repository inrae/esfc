<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<div class="form-group">
	<label class="control-label col-md-4" for="sperme_date">
		{t}Date du prélèvement :{/t}<span class="red">*</span>
	</label>
	<div class="col-md-8">
		<input id="sperme_date" class="datetimepicker form-control" name="sperme_date" value="{$data.sperme_date}">
	</div>
</div>
<div class="form-group">
	<label class="control-label col-md-4" for="sperme_volume">
		{t}Volume prélevé (en ml) :{/t}
	</label>
	<div class="col-md-8">
		<input class="taux" name="sperme_volume" value="{$data.sperme_volume}">
	</div>
</div>
<div class="form-group">
	<label class="control-label col-md-4" for="sperme_aspect_id">
		{t}Aspect :{/t}
	</label>
	<div class="col-md-8">
		<select name="sperme_aspect_id" id="sperme_aspect_id" class="form-control">
			<option value="" {if $data.sperme_aspect_id=="" }selected{/if}>
				{t}Choisissez...{/t}
			</option>
			{section name=lst loop=$spermeAspect}
			<option value="{$spermeAspect[lst].sperme_aspect_id}" {if
				$data.sperme_aspect_id==$spermeAspect[lst].sperme_aspect_id}selected{/if}>
				{$spermeAspect[lst].sperme_aspect_libelle}
			</option>
			{/section}
		</select>
	</div>
</div>
<div class="form-group">
	<label class="control-label col-md-4">
		{t}Caractéristiques particulières :{/t}
	</label>
	<div class="col-md-8">
		{section name=lst loop=$spermeCaract}
		<div class="checkbox">
			<label>
				<input name="sperme_caracteristique_id[]" type="checkbox"
					value="{$spermeCaract[lst].sperme_caracteristique_id}" {if $spermeCaract[lst].sperme_id>
				0}checked{/if}>
				{$spermeCaract[lst].sperme_caracteristique_libelle}
			</label>
		</div>
		{/section}
	</div>
</div>
<div class="form-group">
	<label class="control-label col-md-4" for="sperme_dilueur_id">
		{t}Dilueur utilisé : {/t}
	</label>
	<div class="col-md-8">
		<select name="sperme_dilueur_id" id="sperme_dilueur_id">
			<option value="" {if $data.sperme_dilueur_id=="" }selected{/if}>
				{t}Choisissez...{/t}
			</option>
			{section name=lst loop=$spermeDilueur}
			<option value="{$spermeDilueur[lst].sperme_dilueur_id}" {if
				$data.sperme_dilueur_id==$spermeDilueur[lst].sperme_dilueur_id}selected{/if}>
				{$spermeDilueur[lst].sperme_dilueur_libelle}
			</option>
			{/section}
		</select>
	</div>
</div>
<div class="form-group">
	<label class="control-label col-md-4" for="sperme_commentaire">
		{t}Commentaire :{/t}
	</label>
	<div class="col-md-8">
		<input id="sperme_commentaire" class="form-control" name="sperme_commentaire"
			value="{$data.sperme_commentaire}">
	</div>
</div>
<fieldset>
	<legend>{t}Analyse réalisée au prélèvement{/t}</legend>
	{include file="repro/spermeMesureChangeCorps.tpl"}
</fieldset>