<script>
    $(document).ready(function () {
        /*
         * Management of tabs
         */
         var moduleName = "spermeCongelationList";
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
        $("#annee").change(function () {
            Cookies.set('annee', $(this).val(), { expires: 180, secure: true });
        });
        var buttons = [];
        var header= ["frozen_date","fish","frozen_volume","sperme_volume","number_of_visotubes","number_sperm_straws","volume_by_straw","last_analysis_date","concentration","estimated_quality","operator"];
        var filename = "{t}spermes_congeles{/t}";
        var header_csv = "";
        var header_copy = "";
        header.forEach((val) => {
            header_csv += '"'+ val + '",';
            header_copy += val + "\t";
        });
        var csv = {
                extend: 'csv',
                text: 'csv',
                filename: filename,
                customize: function (csv) {
                    var split_csv = csv.split("\n");
                    //set headers
                    split_csv[0] = header_csv;
                    csv = split_csv.join("\n");
                    return csv;
                }
            };
           var copy = {
                extend: 'copy',
                text: '{t}Copier{/t}',
                customize: function (csv) {
                    var split_csv = csv.split("\n");
                    //set headers
                    split_csv[3] = header_copy;
                    split_csv.shift();
                    split_csv.shift();
                    split_csv.shift();
                    csv = split_csv.join("\n");
                    return csv;
                }
            };
            var excel = {
                extend: 'excelHtml5',
                text: '{t}Excel{/t}',
                filename: filename,
                header: true,
                title: '',
                customize: function (xlsx) {
                    var sheet = xlsx.xl.worksheets['sheet1.xml'];
                    var line = 1;
                    header.forEach(function (item, index) {
                        var c = String.fromCharCode(65 + index);
                        $('c[r='+c+line+'] t', sheet).text(item);
                    });
                }
            };
        buttons = [csv, copy, excel];
        var tableList = $( '#listAll' ).DataTable( {
                dom: 'Bfirtp',
                "language": dataTableLanguage,
                "paging": false,
                "searching": true,
                "stateSave": false,
                "stateDuration": 60 * 60 * 24 * 30,
                "buttons": buttons
            });
    });
</script>
<form method="get" action="spermeCongelationList" id="search">
    <div class="row">
        <div class="col-md-6 col-lg-6 form-horizontal">
            <div class="form-group">
                <label for="annee" class="control-label col-md-2">
                    {t}Année :{/t}
                </label>
                <div class="col-md-3">
                    <select name="annee" id="annee" class="form-control">
                        <option value="0" {if annee==0}selected{/if}>
                            {t}Toutes les années{/t}
                        </option>
                        {foreach $annees as $year}
                        <option value="{$year}" {if $annee==$year}selected{/if}>
                            {$year}
                        </option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-md-2 center">
                    <input type="submit" class="btn btn-success" value="{t}Rechercher{/t}">
                </div>
            </div>
        </div>
    </div>
{$csrf}</form>
<div class="row">
    <div class="col-xs-12">
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item active">
                <a class="nav-link" id="tab-congelation" href="#nav-congelation" data-toggle="tab" role="tab"
                    aria-controls="nav-poisson" aria-selected="false">
                    <img src="display/images/congelation.svg" height="25">
                    {t}Liste des spermes congelés{/t}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-collec" href="#nav-collec" data-toggle="tab" role="tab"
                    aria-controls="nav-collec" aria-selected="false">
                    <img src="display/images/chronometre.svg" height="25">
                    {t}Liste des visotubes stockés{/t}
                </a>
            </li>
        </ul>
        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane active in" id="nav-congelation" role="tabpanel" aria-labelledby="tab-congelation">
                <div class="row">
                    <div class="col-lg-12">
                        <table id="listAll" class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>{t}Date de congélation{/t}</th>
                                    <th>{t}Poisson{/t}</th>
                                    <th>{t}Volume congelé{/t}</th>
                                    <th>{t}Volume de sperme{/t}</th>
                                    <th>{t}Nombre de visotubes{/t}</th>
                                    <th>{t}Nombre de paillettes{/t}</th>
                                    <th>{t}Volume par paillette{/t}</th>
                                    <th>{t}Date de la dernière analyse{/t}</th>
                                    <th>{t}Concentration (millions/mL){/t}</th>
                                    <th>{t}Qualité estimée{/t}</th>
                                    <th>{t}Opérateur{/t}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach $spermes as $sperme}
                                <tr>
                                    <td class="nowrap">
                                        {if $rights.reproGestion == 1}
                                        <a
                                            href="spermeCongelationChange?sperme_id={$sperme.sperme_id}&sperme_congelation_id={$sperme.sperme_congelation_id}&poisson_campagne_id={$sperme.poisson_campagne_id}&sequence_id={$sperme.sequence_id}">
                                            {$sperme.congelation_date}
                                            {else}
                                            {$sperme.congelation_date}
                                            {/if}
                                    </td>
                                    <td>
                                        <a
                                            href="poissonCampagneDisplay?poisson_campagne_id={$sperme.poisson_campagne_id}">
                                            {$sperme.matricule}&nbsp;{$sperme.prenom}
                                        </a>
                                    </td>
                                    <td>
                                        {$sperme.congelation_volume}
                                    </td>
                                    <td>{$sperme.volume_sperme}</td>
                                    <td class="center">{$sperme.nb_visotube}</td>
                                    <td class="center">{$sperme.nb_paillette}</td>
                                    <td class="center">{$sperme.paillette_volume}</td>
                                    <td>{$sperme.sperme_mesure_date}</td>
                                    <td>{$sperme.concentration}</td>
                                    <td>{$sperme.sperme_qualite_libelle}</td>
                                    <td>{$sperme.operateur}</td>
                                </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="nav-collec" role="tabpanel" aria-labelledby="tab-collec">
                <div class="row">
                    <table id="collecList" class="datatable-searching table table-bordered table-hover" data-order='[[1,"ASC"]]'>
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
                            {/foreach}
                        </tbody>
                    </table>
                    
                </div>
            </div>
        </div>
    </div>
</div>