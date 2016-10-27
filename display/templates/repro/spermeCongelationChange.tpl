<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
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
<option value="{$spermeDilueur[lst].sperme_dilueur_id}" {if $data.sperme_dilueur_id == $spermeDilueur[lst].sperme_dilueur_id}selected{/if}>
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
<dt>Nombre de visiotubes :</dt>
<dd><input class="nombre" name="nb_visiotube" value="{$data.nb_visiotube}"></dd>
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
<dl>
<dt>Commentaire :</dt>
<dd>
<input class="commentaire" name="sperme_congelation_commentaire" value="{$data.sperme_congelation_commentaire}">
</dl>