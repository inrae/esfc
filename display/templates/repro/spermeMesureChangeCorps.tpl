<input type="hidden" name="sperme_mesure_id" value="{$data.sperme_mesure_id}">
<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<dl>
<dt>Date/heure de la mesure<span class="red">*</span> :</dt>
<dd><input class="datetimepicker" name="sperme_mesure_date" value="{$data.sperme_mesure_date}"></dd>
</dl>
<dl>
<dt>Qualité globale :</dt>
<dd>
<select name="sperme_qualite_id">
<option value="" {if $data.sperme_qualite_id == ""}selected{/if}>
Sélectionnez...
</option>
{section name=lst loop=$spermeQualite}
<option value="{$spermeQualite[lst].sperme_qualite_id}" {if $data.sperme_qualite_id == $spermeQualite[lst].sperme_qualite_id}selected{/if}>
{$spermeQualite[lst].sperme_qualite_libelle}
</option>
{/section}
</select>
</dl>

<dl><dt>Nbre de paillettes utilisées pour l'analyse :</dt>
<dd><input class="nombre" name="nb_paillette_utilise" value="{$data.nb_paillette_utilise}"></dd>
</dl>

<dl>
<dt>Motilité initiale (1 à 5) :</dt>
<dd>
<input class="taux" name="motilite_initiale" value="{$data.motilite_initiale}">
</dd>
</dl>
<dl>
<dt>Taux de survie (en %) :</dt>
<dd>
<input class="taux" name="tx_survie_initial" value="{$data.tx_survie_initial}">
</dd>
</dl>
<dl>
<dt>Motilité à 60" (1 à 5):</dt>
<dd>
<input class="taux" name="motilite_60" value="{$data.motilite_60}">
</dd>
</dl>
<dl>
<dt>taux de survie à 60" (en %) :</dt>
<dd>
<input class="taux" name="tx_survie_60" value="{$data.tx_survie_60}">
</dd>
</dl>
<dl>
<dt>Temps de survie à 5%<br>(en secondes) :</dt>
<dd>
<input class="numeric" name="temps_survie" value="{$data.temps_survie}">
</dd>
</dl>
<dl>
<dt>pH :</dt>
<dd><input class="taux" name="sperme_ph" value="{$data.sperme_ph}"></dd>
</dl>