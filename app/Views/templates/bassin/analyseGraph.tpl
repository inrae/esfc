<link href="display/node_modules/c3/c3.css" rel="stylesheet" type="text/css">
<script src="display/node_modules/d3//dist/d3.min.js" charset="utf-8"></script>
<script src="display/node_modules/c3/c3.min.js"></script>
<script>
    $(document).ready(function () {
        var chartcontent = atob("{$graph}");

        var chart = c3.generate(JSON.parse(chartcontent));
        //console.log(JSON.parse(chartcontent));
    });
</script>

<h2>{t}Visualisation des analyses d'eau des circuits actifs{/t}</h2>
<div class="row">
    <div class="col-md-8">
        <form method="get" action="analyseGraph" class="form-horizontal">
            <div class="row">
                <label for="site_id" class="control-label col-md-2">
                    {t}Site :{/t}
                </label>
                <div class="col-md-2">
                    <select class="form-control" name="site_id">
                        <option value="" {if $site_id=="" }selected{/if}>
                            {t}Sélectionnez le site...{/t}
                        </option>
                        {section name=lst loop=$site}
                        <option value="{$site[lst].site_id}" {if $site_id==$site[lst].site_id}selected{/if}>
                            {$site[lst].site_name}
                        </option>
                        {/section}
                    </select>
                </div>

                <label for="circuit_eau_id" class="control-label col-md-2">
                    {t}Circuit d'eau :{/t}
                </label>
                <div class="col-md-2">
                    <select id="circuit_eau_id" name="circuit_eau_id" class="form-control">
                        <option value="0" {if $circuit_eau_id==0}selected{/if}>
                            {t}Tous circuits d'eau actifs{/t}
                        </option>
                        {foreach $circuits as $circuit}
                        <option value="{$circuit.circuit_eau_id}" {if
                            $circuit.circuit_eau_id==$circuit_eau_id}selected{/if}>
                            {$circuit.circuit_eau_libelle}
                        </option>
                        {/foreach}
                    </select>
                </div>

                <label for="attribut" class="control-label col-md-2">
                    {t}Mesure à afficher :{/t}
                </label>
                <div class="col-md-2">
                    <select id="attribut" name="attribut" class="form-control">
                        {foreach $attributs as $key=>$val}
                        <option value="{$key}" {if $key==$attribut}selected{/if}>{$val}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="row">
                <label for="attribut" class="control-label col-md-2">
                    {t}Période du :{/t}
                </label>
                <div class="col-md-2">
                    <input name="date_from" class="datepicker form-control" value="{$date_from}">
                </div>

                <label for="date_to" class="control-label col-md-2">
                    {t}au :{/t}
                </label>
                <div class="col-md-2">
                    <input id="date_to" name="date_to" class="datepicker form-control" value="{$date_to}">
                </div>
                <div class="col-md-4 center">
                    <button type="submit" class="btn btn-primary button-valid">
                        {t}Générer le graphique{/t}
                    </button>
                </div>
            </div>
        {$csrf}</form>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div id="graph"></div>
    </div>
</div>
