<script>
    $(document).ready(function () {
        /**
           * Management of tabs
           */
        var moduleName = "circuitEauDisplay";
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
    });
</script>
<h2>{t}Données physico-chimiques du circuit d'eau{/t} {$data.circuit_eau_libelle}
    ({if $data.circuit_eau_actif == 1}{t}en service{/t}{else}{t}hors service{/t}{/if})</h2>
<div class="row">
    <div class="col-lg-12">
        <a href="index.php?module=circuitEauList">
            {t}Retour à la liste des circuits d'eau{/t}
        </a>
    </div>
</div>
<div class="row">
    <div class="col-xs-12">
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item active">
                <a class="nav-link" id="tab-detail" data-toggle="tab" role="tab" aria-controls="nav-detail"
                    aria-selected="true" href="#nav-detail">
                    <img src="display/images/zoom.png" height="25">
                    {t}Détails{/t}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-event" href="#nav-event" data-toggle="tab" role="tab"
                    aria-controls="nav-event" aria-selected="false">
                    <img src="display/images/event.png" height="25">
                    {t}Événements{/t}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-analyze" href="#nav-analyze" data-toggle="tab" role="tab"
                    aria-controls="nav-analyze" aria-selected="false">
                    <img src="display/images/eprouvette.png" height="25">
                    {t}Analyses{/t}
                </a>
            </li>
        </ul>
        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane active in" id="nav-detail" role="tabpanel" aria-labelledby="tab-detail">
                {if $data.site_id > 0}
                <div class="row">
                    <label>{t}Site :{/t}</label> {$data.site_name}
                </div>
                {/if}
                {if $droits["bassinGestion"]==1}
                <div class="row">
                    <a href="index.php?module=circuitEauChange&circuit_eau_id={$data.circuit_eau_id}">
                        {t}Modifier le nom ou l'activité du circuit d'eau...{/t}
                    </a>
                </div>
                {/if}
                <div class="row">
                    <div class="col-md-8">
                        <table class="datatable-nopaging table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>{t}Bassin{/t}</th>
                                    <th>{t}Description{/t}</th>
                                    <th>{t}Type{/t}</th>
                                    <th>{t}Usage{/t}</th>
                                    <th>{t}Zone{/t}</th>
                                    <th>{t}En activité{/t}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach $dataBassin as $bassin}
                                <tr>
                                    <td>
                                        <a href="index.php?module=bassinDisplay&bassin_id={$bassin.bassin_id}">{$bassin.bassin_nom}
                                        </a>
                                    </td>
                                    <td>{$bassin.bassin_description}</td>
                                    <td>{$bassin.bassin_type_libelle}</td>
                                    <td>{$bassin.bassin_usage_libelle}</td>
                                    <td>{$bassin.bassin_zone_libelle}</td>
                                    <td class="center">
                                        {if $bassin.actif == 1}
                                        {t}oui{/t}
                                        {/if}
                                    </td>
                                </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
            <div class="tab-pane fade" id="nav-event" role="tabpanel" aria-labelledby="tab-event">
                {include file="bassin/circuitEvenementList.tpl"}
            </div>
            <div class="tab-pane fade" id="nav-analyze" role="tabpanel" aria-labelledby="tab-analyze">
                <div class="row">
                    <form method="get" action="index.php" class="form-horizontal col-md-8">
                        <input type="hidden" name="isSearch" value="1">
                        <input type="hidden" name="module" value="circuitEauDisplay">
                        <input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
                        <div class="form-group">
                            <label class="control-label col-md-4" for="analyse_date">
                                {t}Date de référence pour les analyses d'eau :{/t}
                            </label>
                            <div class="col-md-8">
                                <input id="analyse_date" class="form-control datepicker" name="analyse_date"
                                    value="{$dataSearch.analyse_date}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="limit" class="control-label col-md-4">
                                {t}Nombre d'analyses à afficher :{/t}</label>
                            <div class="col-md-8">
                                <input id="limit" name="limit" value="{$dataSearch.limit}" class="form-control nombre"
                                    required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="offset" class="control-label col-md-4">
                                {t}Affichage à partir de l'enregistrement n° :{/t}
                            </label>
                            <div class="col-md-8">
                                <input id="offset" name="offset" value="{$dataSearch.offset}" required
                                    class="form-control nombre">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="center">
                                <input class="btn btn-primary button-valid" type="submit" value="{t}Rechercher{/t}">
                            </div>
                        </div>
                    </form>
                </div>

                <td colspan="2">

                </td>
                {if $droits.bassinGestion == 1}
                <div class="row">
                    <a href="index.php?module=analyseEauChange&analyse_eau_id=0&circuit_eau_id={$data.circuit_eau_id}">
                        {t}Nouvelle analyse...{/t}
                    </a>
                </div>
                {/if}
                {if $dataSearch.isSearch == 1}
                <div class="row">
                    <div class="col-lg-12">
                        <table id="canalyseEauList" class="table datatable-export table-bordered table-hover"
                            data-order='[[0,"desc"]]'>
                            <thead>
                                <tr>
                                    <td>
                                        {if $dataSearch.offset > 0}
                                        <a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data.circuit_eau_id}&previous=1"
                                            title="Données précédentes">
                                            &lt;{t}précédent{/t}
                                        </a>
                                        {/if}
                                    </td>
                                    <td colspan="16">
                                        <div class="center">{t}Tri de la requête par date descendante{/t}</div>
                                    </td>
                                    <td class="right">
                                        <a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data.circuit_eau_id}&next=1"
                                            title="Données suivantes">
                                            {t}suivant{/t}&gt;
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <th>{t}Date d'analyse{/t}</th>
                                    <th>{t}T°{/t}</th>
                                    <th>{t}O2 mg/l{/t}</th>
                                    <th>{t}O2 % sat{/t}</th>
                                    <th>{t}Salinité{/t}</th>
                                    <th>{t}pH{/t}</th>
                                    <th>{t}Laboratoire{/t}</th>
                                    <th>{t}NH4{/t}</th>
                                    <th>{t}NO2{/t}</th>
                                    <th>{t}NO3{/t}</th>
                                    <th>{t}Backwash mécanique{/t}</th>
                                    <th>{t}Backwash biologique{/t}</th>
                                    <th>{t}Commentaire backwash bio{/t}</th>
                                    <th>{t}Débit rivière{/t}</th>
                                    <th>{t}Débit forage{/t}</th>
                                    <th>{t}Débit mer{/t}</th>
                                    <th>{t}Métaux{/t}</th>
                                    <th>{t}Observations{/t}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {section name=lst loop=$dataAnalyse}
                                <tr>
                                    <td>
                                        {if $droits.bassinGestion == 1}
                                        <a
                                            href="index.php?module=analyseEauChange&analyse_eau_id={$dataAnalyse[lst].analyse_eau_id}&circuit_eau_id={$data.circuit_eau_id}">
                                            {$dataAnalyse[lst].analyse_eau_date}
                                        </a>
                                        {else}
                                        {$dataAnalyse[lst].analyse_eau_date}
                                        {/if}
                                    </td>
                                    <td class="right">{$dataAnalyse[lst].temperature}</td>
                                    <td class="right">{$dataAnalyse[lst].oxygene}</td>
                                    <td class="right">{$dataAnalyse[lst].o2_pc}</td>
                                    <td class="right">{$dataAnalyse[lst].salinite}</td>
                                    <td class="right">{$dataAnalyse[lst].ph}</td>
                                    <td>{$dataAnalyse[lst].laboratoire_analyse_libelle}
                                    <td class="right">{$dataAnalyse[lst].nh4}</td>
                                    <td class="right">{$dataAnalyse[lst].no2}</td>
                                    <td class="right">{$dataAnalyse[lst].no3}</td>
                                    <td class="center">{if $dataAnalyse[lst].backwash_mecanique == 1}oui{/if}
                                    </td>
                                    <td class="center">{if $dataAnalyse[lst].backwash_biologique == 1}oui{/if}
                                    </td>
                                    <td>{$dataAnalyse[lst].backwash_biologique_commentaire}</td>
                                    <td class="right">{$dataAnalyse[lst].debit_eau_riviere}</td>
                                    <td class="right">{$dataAnalyse[lst].debit_eau_forage}</td>
                                    <td class="right">{$dataAnalyse[lst].debit_eau_mer}</td>
                                    <td>{$dataAnalyse[lst].metaux}</td>
                                    <td>{$dataAnalyse[lst].observations}</td>
                                </tr>
                                {/section}
                            </tbody>
                        </table>
                    </div>
                </div>
                {/if}
            </div>
        </div>
    </div>
</div>