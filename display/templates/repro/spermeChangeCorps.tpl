<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<dl>
<dt>Date du prélèvement <span class="red">*</span> :</dt>
<dd>
<input class="datetimepicker" name="sperme_date" value="{$data.sperme_date}">
</dd>
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
<dt>Commentaire :</dt>
<dd>
<input class="commentaire" name="sperme_commentaire" value="{$data.sperme_commentaire}">
</dl>
<fieldset>
<legend>Analyse réalisée au prélèvement</legend>
{include file="repro/spermeMesureChangeCorps.tpl"}
</fieldset>

<fieldset>
<legend>Congélation</legend>
<dl>
<dt>Date de congélation :</dt>
<dd><input class="date" name="congelation_date" value="{$data.congelation_date}"></dd>
</dl>
<dl>
<dt>Volume congelé (ml) :</dt>
<dd><input class="taux" name="congelation_volume" value="{$data.congelation_volume}">
</dd>
</dl>
<dl>
<dt>Dilueur utilisé : </dt>
<dd>
<select name="sperme_dilueur_id">
<option value="" {if $data.sperme_dilueur_id == ""}selected{/if}>Choisissez...</option>
{section name=lst loop=$spermeDilueur}
<option value="{$spermeAspect[lst].sperme_dilueur_id}" {if $data.sperme_dilueur_id == $spermeDilueur[lst].sperme_dilueur_id}selected{/if}>
{$spermeDilueur[lst].sperme_dilueur_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Nombre de paillettes :</dt>
<dd><input class="nombre" name="nb_paillette" value="{$data.nb_paillette}"></dd>
</dl>
<dl>
<dt>Numéro de canister :</dt>
<dd><input name="numero_canister" value="{$data.numero_canister}">
</dd>
</dl>
<dl>
<dt>Position du canister :</dt>
<dd>
<select name="position_canister">
<option value="" {if $data.position_canister == ""}selected{/if}>Sélectionnez...</option>
<option value="1" {if $data.position_canister == "1"}selected{/if}>Bas</option>
<option value="2" {if $data.position_canister == "2"}selected{/if}>Haut</option>
</select>
</dd>
</dl>
</fieldset>