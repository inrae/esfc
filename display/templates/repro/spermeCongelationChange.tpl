<link href="display/node_modules/c3/c3.min.css" rel="stylesheet" type="text/css">
<script src="display/node_modules/d3/dist/d3.min.js" charset="utf-8"></script>
<script src="display/node_modules/c3/c3.min.js"></script>

<script>
    $(document).ready(function () {
        var chart = c3.generate({
            bindto: '#freeze',
            data: {
                xs: {
                    '{t}Température relevée{/t}': 'mx'
                },
                x: 'x',
                xFormat: '%d/%m/%Y %H:%M:%S', // 'xFormat' can be used as custom format of 'x'
                columns: [
                    [{$mx }],
                    [{$my }]
                ]
            },
            axis: {
                x: {
                    type: 'timeseries',
                    tick: {
                        format: '%d/%m %H:%M'
                    }
                },
                y: {
                    label: '°C'
                }
            }
        });
    });
</script>

<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">
    <img src="display/images/display.png" height="25">
    {t}Retour à la liste des poissons{/t}
</a>
&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
    <img src="display/images/fish.svg" height="25">
    {t}Retour au reproducteur{/t}
</a>
&nbsp;
<a
    href="index.php?module=spermeChange&sperme_id={$data.sperme_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
    <img src="display/images/eprouvette.png" height="25">
    {t}Retour au prélèvement{/t}
</a>
<h2>{t}Modification d'une congélation de sperme{/t}
    {$dataPoisson.matricule}
    {$dataPoisson.categorie_libelle}
    {$dataPoisson.sexe_libelle}
    {$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})
</h2>


<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="spermeForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="spermeCongelation">
            <input type="hidden" name="sperme_id" value="{$data.sperme_id}">
            <input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
            <input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
            <div class="form-group">
                <label for="congelation_date" class="control-label col-md-4">
                    {t}Date de congélation:{/t}
                    <span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="congelation_date" class="form-control datepicker" name="congelation_date"
                        value="{$data.congelation_date}" required>
                </div>
            </div>
            <div class="form-group">
                <label for="congelation_volume" class="control-label col-md-4">
                    {t}Volume total congelé (ml) :{/t}
                </label>
                <div class="col-md-8">
                    <input id="congelation_volume" class="form-control taux" name="congelation_volume"
                        value="{$data.congelation_volume}">
                </div>
            </div>
            <div class="form-group">
                <label for="volume_sperme" class="control-label col-md-4">
                    {t}Volume de sperme (ml) :{/t}
                </label>
                <div class="col-md-8">
                    <input id="volume_sperme" class="form-control taux" name="volume_sperme"
                        value="{$data.volume_sperme}">
                </div>
            </div>
            <div class="form-group">
                <label for="nb_paillette" class="control-label col-md-4">
                    {t}Nombre total de paillettes :{/t}
                </label>
                <div class="col-md-8">
                    <input id="nb_paillette" class="form-control nombre" name="nb_paillette"
                        value="{$data.nb_paillette}">
                </div>
            </div>
            <div class="form-group">
                <label for="nb_visotube" class="control-label col-md-4">
                    {t}Nombre total de visotubes :{/t}
                </label>
                <div class="col-md-8">
                    <input id="nb_visotube" class="form-control nombre" name="nb_visotube"
                        value="{$data.nb_visotube}">
                </div>
            </div>
            <div class="form-group">
                <label for="sperme_dilueur_id" class="control-label col-md-4">
                    {t}Dilueur utilisé : {/t}
                </label>
                <div class="col-md-8">
                    <select id="sperme_dilueur_id" class="form-control" name="sperme_dilueur_id">
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
                <label for="volume_dilueur" class="control-label col-md-4">
                    {t}Volume de dilueur utilisé (ml) :{/t}
                </label>
                <div class="col-md-8">
                    <input id="volume_dilueur" class="form-control taux" name="volume_dilueur"
                        value="{$data.volume_dilueur}">
                </div>
            </div>
            <div class="form-group">
                <label for="sperme_conservateur_id" class="control-label col-md-4">
                    {t}Conservateur utilisé : {/t}
                </label>
                <div class="col-md-8">
                    <select id="sperme_conservateur_id" class="form-control" name="sperme_conservateur_id">
                        <option value="" {if $data.sperme_conservateur_id=="" }selected{/if}>
                            {t}Choisissez...{/t}
                        </option>
                        {section name=lst loop=$spermeConservateur}
                        <option value="{$spermeConservateur[lst].sperme_conservateur_id}" {if
                            $data.sperme_conservateur_id==$spermeConservateur[lst].sperme_conservateur_id}selected{/if}>
                            {$spermeConservateur[lst].sperme_conservateur_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="volume_conservateur" class="control-label col-md-4">
                    {t}Volume de conservateur utilisé (ml) :{/t}
                </label>
                <div class="col-md-8">
                    <input id="volume_conservateur" class="form-control taux" name="volume_conservateur"
                        value="{$data.volume_conservateur}">
                </div>
            </div>
            <div class="form-group">
                <label for="nb_paillettes_utilisees" class="control-label col-md-4">
                    {t}Nb de paillettes utilisées en repro :{/t}
                </label>
                <div class="col-md-8">
                    <input id="nb_paillettes_utilisees" class="form-control nombre" name="nb_paillettes_utilisees"
                        value="{$data.nb_paillettes_utilisees}" readonly>
                </div>
            </div>
            <div class="form-group">
                <label for="sperme_congelation_commentaire" class="control-label col-md-4">
                    {t}Commentaire :{/t}
                </label>
                <div class="col-md-8">
                    <input id="sperme_congelation_commentaire" class="form-control"
                        name="sperme_congelation_commentaire" value="{$data.sperme_congelation_commentaire}">
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.sperme_congelation_id > 0 &&$droits["reproGestion"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
        <span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>
    </div>
    {if $data.sperme_congelation_id > 0}
    <div class="col-md-6">
        <fieldset>
            <legend>{t}Vitesse de congélation{/t}</legend>
            <div class="row">
                {include file="repro/spermeFreezingMeasureList.tpl"}
            </div>
            <div class="row">
                <div id="freeze"></div>
            </div>
        </fieldset>
    </div>
    {/if}
</div>
{if $data.sperme_congelation_id > 0}
<div class="row">
    <div class="col-md-6">
        <fieldset>
            <legend>{t}Liste des analyses effectuées{/t}</legend>
            {include file='repro/spermeMesureList.tpl'}
        </fieldset>
    </div>
    <div class="col-md-6">
        <fieldset>
            <legend>{t}Liste des emplacements de congélation{/t}</legend>
            {include file='repro/spermeFreezingPlaceList.tpl'}
        </fieldset>
    </div>
</div>
{/if}