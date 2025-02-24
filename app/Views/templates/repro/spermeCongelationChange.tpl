<link href="display/node_modules/c3/c3.min.css" rel="stylesheet" type="text/css">
<script src="display/node_modules/d3/dist/d3.min.js" charset="utf-8"></script>
<script src="display/node_modules/c3/c3.min.js"></script>

<script>
    $(document).ready(function () {
        /*
         * Management of tabs
         */
        var moduleName = "spermeCongelation";
        var localStorage = window.localStorage;
        try {
            activeTab = localStorage.getItem(moduleName + "Tab");
        } catch (Exception) {
            activeTab = "";
        }
        try {
            if (activeTab.length > 0) {
                $("#" + activeTab).tab('show');
            }
        } catch (Exception) { }
        $('a[data-toggle="tab"]').on('shown.bs.tab', function () {
            localStorage.setItem(moduleName + "Tab", $(this).attr("id"));
        });
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
        var myStorage = window.localStorage;
        $("#operateur").change(function () {
            myStorage.setItem("spermeCongelationOperateur", $("#operateur").val());
        });
        var operateur = "{$data.operateur}";
        if (operateur.length == 0) {
            try {
                operateur = myStorage.getItem("spermeCongelationOperateur");
                $("#operateur").val(operateur);
            } catch {
                // nothing to do
            }
        }
        $("form#generateVisotubes").on ("submit", function (event) {
            if (! confirm("{t}Confirmez-vous la génération des visotubes dans Collec-Science ?{/t}")) {
                event.preventDefault();
            }
        });
        $(".volcalc").change(function() { 
            var nbpaillette = $("#nb_paillette").val();
            var volume = $("#paillette_volume").val();
            console.log(nbpaillette);
            if (nbpaillette > 0 && volume > 0) {
                $("#congelation_volume").val( volume * nbpaillette);
            }
        });
    });
</script>

<a href="index.php?module={$poissonDetailParent}&sequence_id={$data.sequence_id}">
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
    <div class="col-xs-12">
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item active">
                <a class="nav-link" id="tab-congelation" href="#nav-congelation" data-toggle="tab" role="tab"
                    aria-controls="nav-poisson" aria-selected="false">
                    <img src="display/images/congelation.svg" height="25">
                    {t}Congélation{/t}
                </a>
            </li>
            {if $data.sperme_congelation_id > 0}
            <li class="nav-item">
                <a class="nav-link" id="tab-speed" href="#nav-speed" data-toggle="tab" role="tab"
                    aria-controls="nav-speed" aria-selected="false">
                    <img src="display/images/chronometre.svg" height="25">
                    {t}Vitesse de congélation{/t}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-analyse" href="#nav-analyse" data-toggle="tab" role="tab"
                    aria-controls="nav-analyse" aria-selected="false">
                    <img src="display/images/analyse.png" height="25">
                    {t}Analyses effectuées{/t}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-storage" href="#nav-storage" data-toggle="tab" role="tab"
                    aria-controls="nav-storage" aria-selected="false">
                    <img src="display/images/cuve.png" height="25">
                    {t}Emplacements de congélation{/t}
                </a>
            </li>
            {/if}
        </ul>
        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane active in" id="nav-congelation" role="tabpanel" aria-labelledby="tab-congelation">
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
                                <input id="congelation_date" class="form-control datetimepicker" name="congelation_date"
                                    value="{$data.congelation_date}" required>
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
                                <input id="nb_paillette" class="form-control nombre volcalc" name="nb_paillette"
                                    value="{$data.nb_paillette}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="paillette_volume" class="control-label col-md-4">
                                {t}Volume par paillette (mL) :{/t}
                            </label>
                            <div class="col-md-8">
                                <datalist id="volumes">
                                    <option value="0.5"></option>
                                    <option value="5"></option>
                                </datalist>
                                <input id="paillette_volume" class="form-control taux volcalc" name="paillette_volume"
                                    value="{$data.paillette_volume}" list="volumes">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="congelation_volume" class="control-label col-md-4">
                                {t}Volume total congelé (mL) :{/t}
                            </label>
                            <div class="col-md-8">
                                <input id="congelation_volume" class="form-control taux" name="congelation_volume"
                                    value="{$data.congelation_volume}">
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
                                {t}Nb de paillettes utilisées en repro:{/t}
                            </label>
                            <div class="col-md-8">
                                <input id="nb_paillettes_utilisees" class="form-control nombre"
                                    name="nb_paillettes_utilisees" value="{$data.nb_paillettes_utilisees}" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="operateur" class="control-label col-md-4">
                                {t}Opérateur :{/t}
                            </label>
                            <div class="col-md-8">
                                <input id="operateur" class="form-control" name="operateur" value="{$data.operateur}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="sperme_congelation_commentaire" class="control-label col-md-4">
                                {t}Commentaire :{/t}
                            </label>
                            <div class="col-md-8">
                                <input id="sperme_congelation_commentaire" class="form-control"
                                    name="sperme_congelation_commentaire"
                                    value="{$data.sperme_congelation_commentaire}">
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
            </div>
            {if $data.sperme_congelation_id > 0}
            <div class="tab-pane fade" id="nav-speed" role="tabpanel" aria-labelledby="tab-speed">
                <div class="col-md-6">
                    {include file="repro/spermeFreezingMeasureList.tpl"}
                </div>
                <div class="col-md-6">
                    <div id="freeze"></div>
                </div>
            </div>
            <div class="tab-pane fade" id="nav-analyse" role="tabpanel" aria-labelledby="tab-analyse">
                <div class="row">
                    {include file='repro/spermeMesureList.tpl'}
                </div>
            </div>
            <div class="tab-pane fade" id="nav-storage" role="tabpanel" aria-labelledby="tab-storage">
                <div class="row">
                    <form id="generateVisotubes" method="post" action="index.php" class="form-horizontal">
                        <input name="module" type="hidden" value="spermeCongelationVisotubes">
                        <input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
                        <input type="hidden" name="sperme_id" value="{$data.sperme_id}">
                        <input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
                        <input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
                        <div class="form-group">
                            <label for="visotubesNb" class="control-label col-md-4">
                                {t}Nombre de visotubes à générer dans Collec-Science :{/t}
                            </label>
                            <div class="col-md-8">
                                <input id="visotubesNb" class="form-control nombre" name="visotubesNb"
                                    value="{$data.nb_visotube}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="totalPaillettesNb" class="control-label col-md-4">
                                {t}Nombre total de paillettes à générer dans Collec-Science :{/t}
                            </label>
                            <div class="col-md-8">
                                <input id="totalPaillettesNb" class="form-control nombre" name="totalPaillettesNb"
                                    value="{$data.nb_paillette}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="paillettesNb" class="control-label col-md-4">
                                {t}Nombre de paillettes par visotube :{/t}
                            </label>
                            <div class="col-md-8">
                                <input id="paillettesNb" class="form-control nombre" name="paillettesNb" value="30">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="firstNumber" class="control-label col-md-4">
                                {t}Premier numéro de numérotation du visotube :{/t}
                            </label>
                            <div class="col-md-8">
                                <input id="firstNumber" class="form-control nombre" name="firstNumber" value="1">
                            </div>
                        </div>
                        <div class="form-group center">
                            <button id="visotubeSubmit" class="btn btn-primary button-valid">
                                {t}Générer les visotubes dans Collec-Science{/t}
                            </button>
                        </div>
                        <div class="bg-info">
                            {t}Les visotubes vont être créés avec le nom :{/t}
                            {$data.matricule}-{$data.congelation_date_label}-X ({t}matricule-date congélation-heure congélation-X ,où X est un compteur généré à partir de la valeur indiquée dans le champ "Premier numéro du visotube"{/t}).
                            <br>
                            {t}Le nombre de paillettes sera ajusté pour le dernier visotube.{/t}
                        </div>
                    </form>
                </div>
                <fieldset>
                    <legend>{t}Liste des visotubes présents dans Collec-Science{/t}</legend>
                    {$totalInitial = 0}
                    {$totalRestant = 0}
                    <table id="visotubesTable" class="table table-bordered table-hover" data-order='[[1,"ASC"]]'>
                        <thead>
                            <tr>
                                <th>{t}UID{/t}</th>
                                <th>{t}Identifiant{/t}</th>
                                <th>{t}Nombre de paillettes initial{/t}</th>
                                <th>{t}Nombre de paillettes restant{/t}</th>
                                <th>{t}Canister{/t}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $visotubes as $visotube}
                            <tr>
                                <td class="center">
                                    {$visotube.uid}
                                </td>
                                <td>
                                    {$visotube.identifier}
                                </td>
                                <td class="center">
                                    {$visotube.multiple_value}
                                </td>
                                <td class="center">
                                    {$visotube.subsample_quantity}
                                </td>
                                <td>
                                    {$visotube.container_uid}&nbsp;
                                    {$visotube.container_identifier}
                                </td>
                            </tr>
                            {if $visotube.multiple_value > 0}
                            {$totalInitial = $totalInitial + $visotube.multiple_value}
                            {/if}
                            {if $visotube.subsample_quantity > 0}
                            {$totalRestant = $totalRestant + $visotube.subsample_quantity}
                            {/if}
                            {/foreach}
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="2">{t}Total :{/t}</td>
                                <td class="center">{$totalInitial}</td>
                                <td class="center">{$totalRestant}</td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </fieldset>
                <div class="row">
                    <fieldset>
                        <legend>{t}Ancien stockage (obsolète){/t}</legend>
                        {include file='repro/spermeFreezingPlaceList.tpl'}
                    </fieldset>
                </div>
            </div>
            {/if}
        </div>
    </div>
</div>