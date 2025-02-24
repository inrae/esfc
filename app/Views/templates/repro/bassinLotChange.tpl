<a href="lotList">
    <img src="display/images/list.png" height="25">
    {t}Retour à la liste des lots{/t}
</a>&nbsp;
<a href="lotDisplay?lot_id={$data.lot_id}">
    <img src="display/images/fishlot.svg" height="25">
    {t}Retour au lot{/t}
</a>

<h2>{t}Modification de l'attribution d'un bassin{/t}
    {$dataLot.annee}/{$dataLot.site_name}
    {$dataLot.sequence_nom} {$dataLot.croisement_nom}
</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="bassinLotForm" method="post" action="bassinLot">            
            <input type="hidden" name="moduleBase" value="bassinLot">
            <input type="hidden" name="bassin_lot_id" value="{$data.bassin_lot_id}">
            <input type="hidden" name="lot_id" value="{$data.lot_id}">
            <div class="form-group">
                <label for="bl_date_arrivee" class="control-label col-md-4">
                    {t}Date de début d'utilisation :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="bl_date_arrivee" class="form-control datepicker" name="bl_date_arrivee"
                        value="{$data.bl_date_arrivee}" required>
                </div>
            </div>
            <div class="form-group">
                <label for="bassin_id" class="control-label col-md-4">
                    {t}Bassin :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <select id="bassin_id" class="form-control" name="bassin_id">
                        {section name=lst loop=$bassins}
                        <option value="{$bassins[lst].bassin_id}" {if
                            $bassins[lst].bassin_id==$data.bassin_id}selected{/if}>
                            {$bassins[lst].bassin_nom}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="bl_date_depart" class="control-label col-md-4">
                    {t}Date de fin d'utilisation :{/t}
                </label>
                <div class="col-md-8">
                    <input id="bl_date_depart" class="form-control datepicker" name="bl_date_depart"
                        value="{$data.bl_date_depart}">
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.bassin_lot_id > 0 &&$rights["reproAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        {$csrf}</form>
    </div>
</div>
<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>