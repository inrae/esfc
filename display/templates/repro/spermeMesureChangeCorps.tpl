<input type="hidden" name="sperme_mesure_id" value="{$data.sperme_mesure_id}">
<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<div class="form-group">
    <label for="sperme_mesure_date" class="control-label col-md-4">
        {t}Date/heure de la mesure :{/t}<span class="red">*</span>
    </label>
    <div class="col-md-8">
        <input id="sperme_mesure_date" class="datetimepicker form-control" name="sperme_mesure_date"
            value="{$data.sperme_mesure_date}">
    </div>
</div>
<div class="form-group">
    <label for="sperme_qualite_id" class="control-label col-md-4">
        {t}Qualité globale :{/t}
    </label>
    <div class="col-md-8">
        <select name="sperme_qualite_id" id="sperme_qualite_id" class="form-control">
            <option value="" {if $data.sperme_qualite_id=="" }selected{/if}>
                {t}Sélectionnez...{/t}
            </option>
            {section name=lst loop=$spermeQualite}
            <option value="{$spermeQualite[lst].sperme_qualite_id}" {if
                $data.sperme_qualite_id==$spermeQualite[lst].sperme_qualite_id}selected{/if}>
                {$spermeQualite[lst].sperme_qualite_libelle}
            </option>
            {/section}
        </select>
    </div>
</div>
{if $data.sperme_congelation_id > 0}
<div class="form-group"><label for="nb_paillette_utilise" class="control-label col-md-4">
        {t}Nbre de paillettes utilisées pour l'analyse :{/t}<span class="red">*</span>
    </label>
    <div class="col-md-8">
        <input id="nb_paillette_utilise" class="nombre form-control" name="nb_paillette_utilise" value="{$data.nb_paillette_utilise}" required>
    </div>
</div>
{/if}
<div class="form-group">
    <label for="motilite_initiale" class="control-label col-md-4">
        {t}Motilité initiale (1 à 5) :{/t}
    </label>
    <div class="col-md-8">
        <input class="taux form-control" id="motilite_initiale" name="motilite_initiale"
            value="{$data.motilite_initiale}">
    </div>
</div>
<div class="form-group">
    <label for="tx_survie_initial" class="control-label col-md-4">
        {t}Taux de survie initial (en %) :{/t}
    </label>
    <div class="col-md-8">
        <input id="tx_survie_initial" class="taux form-control" name="tx_survie_initial" value="{$data.tx_survie_initial}">
    </div>
</div>
<div class="form-group">
    <label for="motilite_60" class="control-label col-md-4">
        {t}Motilité à 60" (1 à 5):{/t}
    </label>
    <div class="col-md-8">
        <input id="motilite_60" class="taux form-control" name="motilite_60" value="{$data.motilite_60}">
    </div>
</div>
<div class="form-group">
    <label for="tx_survie_60" class="control-label col-md-4">
        {t}taux de survie à 60" (en %) :{/t}
    </label>
    <div class="col-md-8">
        <input id=tx_survie_60"" class="taux form-control" name="tx_survie_60" value="{$data.tx_survie_60}">
    </div>
</div>
<div class="form-group">
    <label for="temps_survie" class="control-label col-md-4">
        {t}Temps de survie à 5% (en secondes) :{/t}
    </label>
    <div class="col-md-8">
        <input id="temps_survie" class="nombre form-control" name="temps_survie" value="{$data.temps_survie}">
    </div>
</div>
<div class="form-group">
    <label for="sperme_ph" class="control-label col-md-4">
        {t}pH :{/t}
    </label>
    <div class="col-md-8">
        <input id="sperme_ph" class="taux form-control" name="sperme_ph" value="{$data.sperme_ph}">
    </div>
</div>