<a href="index.php?module=sequenceList">
    <img src="display/images/list.png" height="25">
    {t}Retour à la liste des séquences{/t}
</a>
&nbsp;
<a href="index.php?module=sequenceDisplay&sequence_id={$data.sequence_id}">
    <img src="display/images/sexe.svg" height="25">
    {t}Retour à la séquence{/t}
    {$dataSequence.annee} {$dataSequence.sequence_date_debut} - {$dataSequence.site_name} {$dataSequence.sequence_nom}
</a>
&nbsp;
{if $data.croisement_id > 0}
<a href="index.php?module=croisementDisplay&croisement_id={$data.croisement_id}">
    <img src="display/images/repro.png" height="25">
    {t}Retour au croisement{/t} {$data.croisement_nom}
</a>
{/if}
<form class="form-horizontal" id="croisementForm" method="post" action="index.php">
    <input type="hidden" name="action" value="Write">
    <input type="hidden" name="moduleBase" value="croisement">
    <input type="hidden" name="croisement_id" value="{$data.croisement_id}">
    <input type="hidden" name="sequence_id" value="{$data.sequence_id}">
    <div class="row">
        <div class="col-md-6">
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.croisement_id > 0 &&$droits["reproAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            <div class="form-group">
                <label for="croisement_date" class="control-label col-md-4">
                    {t}Date/heure de la fécondation :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="croisement_date" class="form-control datetimepicker" name="croisement_date" required
                        value="{$data.croisement_date}">
                </div>
            </div>
            <div class="form-group">
                <label for="croisement_nom" class="control-label col-md-4">
                    {t}Nom du croisement :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="croisement_nom" class="form-control" name="croisement_nom" value={$data.croisement_nom}>
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Masse des ovocytes (en grammes) :{/t}
                </label>
                <div class="col-md-8">
                    <input id="ovocyte_masse" class="form-control taux" name="ovocyte_masse"
                        value="{$data.ovocyte_masse}">
                </div>
            </div>
            <div class="form-group">
                <label for="ovocyte_densite" class="control-label col-md-4">
                    {t}Nbre ovocytes par gramme :{/t}
                </label>
                <div class="col-md-8">
                    <input id="ovocyte_densite" class="form-control taux" name="ovocyte_densite"
                        value="{$data.ovocyte_densite}">
                </div>
            </div>
            <div class="form-group">
                <label for="tx_fecondation" class="control-label col-md-4">
                    {t}Taux de fécondation :{/t}
                </label>
                <div class="col-md-8">
                    <input id="tx_fecondation" class="form-control taux" name="tx_fecondation"
                        value="{$data.tx_fecondation}">
                </div>
            </div>
            <div class="form-group">
                <label for="tx_survie_estime" class="control-label col-md-4">
                    {t}Taux de survie estimé :{/t}
                </label>
                <div class="col-md-8">
                    <input id="tx_survie_estime" class="form-control taux" name="tx_survie_estime"
                        value="{$data.tx_survie_estime}">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Qualité génétique du croisement :{/t}
                </label>
                <div class="col-md-8">
                    <select id="" class="form-control" name="croisement_qualite_id">
                        <option value="" {if $data.croisement_qualite_id=='' }selected{/if}>
                            {t}Sélectionnez...{/t}
                        </option>
                        {section name=lst loop=$croisementQualite}
                        <option value="{$croisementQualite[lst].croisement_qualite_id}" {if
                            $data.croisement_qualite_id==$croisementQualite[lst].croisement_qualite_id}selected{/if}>
                            {$croisementQualite[lst].croisement_qualite_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <fieldset>
                <legend>{t}Poissons utilisés pour la reproduction :{/t}</legend>
                <table class="table table-bordered table-hover datatable-nopaging-nosearching" id="poissonReproTableId">
                    <thead>
                        <tr>
                            <th>{t}Poisson{/t}</th>
                            <th>{t}Sexe{/t}</th>
                            <th>{t}Sélectionné{/t}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {section name=lst loop=$poissonSequence}
                        <tr>
                            <td>{$poissonSequence[lst].matricule} {$poissonSequence[lst].prenom}
                                {$poissonSequence[lst].pittag_valeur}</td>
                            <td class="center">{$poissonSequence[lst].sexe_libelle_court}</td>
                            <td class="center">
                                <input name="poisson_campagne_id[]" type="checkbox"
                                    value="{$poissonSequence[lst].poisson_campagne_id}" {if
                                    $poissonSequence[lst].selected==1}checked{/if}>
                            </td>
                        </tr>
                        {/section}
                    </tbody>
                </table>
            </fieldset>
        </div>
    </div>
</form>


<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>