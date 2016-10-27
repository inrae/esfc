<script>
$(document).ready(function() {
	$("#sperme_date").change( function () { 
	$("#sperme_mesure_date").val($(this).val());
	});
});
</script>

<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<dl>
<dt>Date du prélèvement <span class="red">*</span> :</dt>
<dd>
<input id="sperme_date" class="" name="sperme_date" value="{$data.sperme_date}" placeholder="1/6/16 14:15">
</dd>
</dl>
<dl><dt>Volume prélevé (en ml) :</dt>
<dd><input class="taux" name="sperme_volume" value="{$data.sperme_volume}"></dd>
</dl>
<dl>
<dt>Aspect :</dt>
<dd>
<select name="sperme_aspect_id">
<option value="" {if $data.sperme_aspect_id == ""}selected{/if}>Choisissez...</option>
{section name=lst loop=$spermeAspect}
<option value="{$spermeAspect[lst].sperme_aspect_id}" {if $data.sperme_aspect_id == $spermeAspect[lst].sperme_aspect_id}selected{/if}>
{$spermeAspect[lst].sperme_aspect_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Caractéristiques particulières :</dt>
<dd>
<table>
{section name=lst loop=$spermeCaract}
<tr>
<td>{$spermeCaract[lst].sperme_caracteristique_libelle}</td>

<td class="center">
<input name="sperme_caracteristique_id[]" type="checkbox" value="{$spermeCaract[lst].sperme_caracteristique_id}" {if $spermeCaract[lst].sperme_id > 0}checked{/if}>
</td>
</tr>
{/section}
</table>
</dd>
</dl>
<dl>
<dt>Dilueur utilisé : </dt>
<dd>
<select name="sperme_dilueur_id">
<option value="" {if $data.sperme_dilueur_id == ""}selected{/if}>Choisissez...</option>
{section name=lst loop=$spermeDilueur}
<option value="{$spermeDilueur[lst].sperme_dilueur_id}" {if $data.sperme_dilueur_id == $spermeDilueur[lst].sperme_dilueur_id}selected{/if}>
{$spermeDilueur[lst].sperme_dilueur_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Commentaire :</dt>
<dd>
<input class="commentaire" name="sperme_commentaire" value="{$data.sperme_commentaire}">
</dl>
<fieldset>
<legend>Analyse réalisée au prélèvement</legend>
{include file="repro/spermeMesureChangeCorps.tpl"}
</fieldset>