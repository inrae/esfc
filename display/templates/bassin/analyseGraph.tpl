<link href="display/javascript/c3/c3.css" rel="stylesheet" type="text/css">
<script src="display/javascript/c3/d3.min.js" charset="utf-8"></script>
<script src="display/javascript/c3/c3.min.js"></script>
<script>
$(document).ready(function() {
var chartcontent = atob("{$graph}") ;

var chart = c3.generate(JSON.parse(chartcontent));
//console.log(JSON.parse(chartcontent));
});
</script>

<h2>Visualisation des analyses d'eau des circuits actifs</h2>
<form method="get" action="index.php">
    <input type="hidden" name="module" value="analyseGraph">
    <table class="tableaffichage">
        <tr>
            <td>Site :</td>
            <td>
                <select name="site_id">
                    <option value="" {if $site_id == ""}selected{/if}>Sélectionnez le site...</option>
                    {section name=lst loop=$site}
                        <option value="{$site[lst].site_id}" {if $site_id == $site[lst].site_id}selected{/if}>
                        {$site[lst].site_name}
                        </option>
                    {/section}
                </select>
            </td>
            <td>Circuit d'eau :</td>
            <td>
                <select name="circuit_eau_id">
                    <option value="0" {if $circuit_eau_id == 0}selected{/if}>Tous circuits d'eau actifs</option>
                    {foreach $circuits as $circuit}
                        <option value="{$circuit.circuit_eau_id}" {if $circuit.circuit_eau_id == $circuit_eau_id}selected{/if}>
                        {$circuit.circuit_eau_libelle}
                        </option>
                    {/foreach}
            <td>Mesure à afficher :</td>
            <td>
                <select name="attribut">
                    {foreach $attributs as $key=>$val}
                    <option value="{$key}" {if $key == $attribut}selected{/if}>{$val}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr>
            <td>Période du :</td>
            <td><input name="date_from" class="date" value="{$date_from}"></td>
            <td>au :</td>
            <td><input name="date_to" class="date" value="{$date_to}"></td>
        <tr>
            <td colspan="6" class="center">
            <input type="submit" value="Générer le graphique">
            </td>
        </tr>
    </table>

</form>

<div id="graph"></div>