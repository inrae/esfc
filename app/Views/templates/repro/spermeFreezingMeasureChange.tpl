<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">
    <img src="display/images/display.png" height="25">
    {t}Retour à la liste des poissons{/t}
</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
    <img src="display/images/fish.svg" height="25">
    {t}Retour au reproducteur{/t}
</a>
&nbsp;
<a
    href="index.php?module=spermeChange&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&sperme_id={$dataCongelation.sperme_id}">
    <img src="display/images/eprouvette.png" height="25">
    {t}Retour au sperme prélevé{/t}
</a>
<a
    href="index.php?module=spermeCongelationChange&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&sperme_id={$dataCongelation.sperme_id}&sperme_congelation_id={$dataCongelation.sperme_congelation_id}">
    <img src="display/images/congelation.svg" height="25">
    {t}Retour à la congélation{/t}
</a>
<h2>{t}Modification d'une température relevée pendant la phase de congélation{/t}
    {$dataPoisson.matricule}
    {$dataPoisson.categorie_libelle}
    {$dataPoisson.sexe_libelle}
    {$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})
</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="spermeFreezingMeasureForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="spermeFreezingMeasure">
            <input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
            <input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
            <input type="hidden" name="sperme_id" value="{$dataCongelation.sperme_id}">
            <input type="hidden" name="sperme_freezing_measure_id" value="{$data.sperme_freezing_measure_id}">
            <div class="form-group">
                <label for="measure_date" class="control-label col-md-4">
                    {t}Date/heure:{/t}
                    <span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="measure_date" class="form-control datetimepicker" name="measure_date" 
                        value="{$data.measure_date}">
                </div>
            </div>
            <div class="form-group">
                <label for="measure_temp" class="control-label col-md-4">
                    {t}Temperature relevée:{/t}
                    <span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="measure_temp" class="form-control taux" name="measure_temp" value="{$data.measure_temp}"
                        autofocus>
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.sperme_freezing_measure_id > 0 &&$droits["reproGestion"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>