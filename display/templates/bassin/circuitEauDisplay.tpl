<script>
$(document).ready(function() { 
$( "#analyse_date" ).datepicker( { dateFormat: "dd/mm/yy" } );
});
</script>

<h2>Données physico-chimiques du circuit d'eau {$data.circuit_eau_libelle}</h2>
<a href="index.php?module=circuitEauList">Retour à la liste des circuits d'eau</a>
{if $droits["bassinGestion"]==1}
<a href="index.php?module=circuitEauChange&circuit_eau_id={$data.circuit_eau_id}">
Modifier le nom ou l'activité du circuit d'eau...
</a>
{/if}
<br>
<label>Bassin(s) reliés à ce circuit d'eau : </label>
{section name=lst loop=$dataBassin}
<a href="index.php?module=bassinDisplay&bassin_id={$dataBassin[lst].bassin_id}">{$dataBassin[lst].bassin_nom} </a>
{/section}
<form method="get" action="index.php">
<input type="hidden" name="isSearch" value="1">
<input type="hidden" name="module" value="circuitEauDisplay">
<input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
<table class="tableaffichage">
<tr>
<td>
<label for "analyse_date">Date de référence pour les analyses d'eau : </label>
<input id="analyse_date" name="analyse_date" value="{$dataSearch.analyse_date}" size="10">
<br>
<label for "limit">Nombre d'analyses à afficher : </label>
<input id="limit" name="limit" value="{$dataSearch.limit}" pattern="[0-9]+" required size="5">
<label for "offset">Affichage à partir de l'enregistrement n° : </label> 
<input id="offset" name="offset" value="{$dataSearch.offset}" pattern="[0-9]+" required size="5">
<div class="center">
<input type="submit" value="Rechercher">
</div>
</td>
</tr>
</table>
</form>

{if $droits.bassinGestion == 1}
<a href="index.php?module=analyseEauChange&analyse_eau_id=0&circuit_eau_id={$data.circuit_eau_id}">
Nouvelle analyse...
</a>
{/if}
<script>
setDataTables("canalyseEauList", 1 , 0, 0, {$dataSearch.limit}, true);
</script>
<table class="tablemulticolonne">
<tr>
<td style="width:25%;">
{if $dataSearch.offset > 0}
<a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data.circuit_eau_id}&previous=1" title="Données précédentes">
&lt;préc
</a>
{/if}
</td>
<td style="width:50%;"></td>
<td style="width:25%;text-align:right;">
<a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data.circuit_eau_id}&next=1" title="Données suivantes">
suiv&gt;
</a>
</td>
</tr>
<tr>
<td colspan="3">
<table id="canalyseEauList" class="tableliste">
<thead>
<tr>
<th>Date<br>d'analyse</th>
<th>T°</th>
<th>O2</th>
<th>Salinité</th>
<th>pH</th>
<th>Laboratoire</th>
<th>NH4</th>
<th>NO2</th>
<th>NO3</th>
<th>Backwash<br>mécanique</th>
<th>Backwash<br>biologique</th>
<th>Commentaire<br>backwash bio</th>
<th>Débit<br>rivière</th>
<th>Débit<br>forage</th>
<th>Débit<br>mer</th>
<th>Observations</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataAnalyse}
<tr>
<td>
{if $droits.bassinGestion == 1}
<a href="index.php?module=analyseEauChange&analyse_eau_id={$dataAnalyse[lst].analyse_eau_id}&circuit_eau_id={$data.circuit_eau_id}">
{$dataAnalyse[lst].analyse_eau_date}
</a>
{else}
{$dataAnalyse[lst].analyse_eau_date}
{/if}
</td>
<td class="right">{$dataAnalyse[lst].temperature}</td>
<td class="right">{$dataAnalyse[lst].oxygene}</td>
<td class="right">{$dataAnalyse[lst].salinite}</td>
<td class="right">{$dataAnalyse[lst].ph}</td>
<td>{$dataAnalyse[lst].laboratoire_analyse_libelle}
<td class="right">{$dataAnalyse[lst].nh4}</td>
<td class="right">{$dataAnalyse[lst].no2}</td>
<td class="right">{$dataAnalyse[lst].no3}</td>
<td class="center">{if $dataAnalyse[lst].backwash_mecanique == 1}oui{/if}</td>
<td class="center">{if $dataAnalyse[lst].backwash_biologique == 1}oui{/if}</td>
<td>{$dataAnalyse[lst].backwash_biologique_commentaire}</td>
<td class="right">{$dataAnalyse[lst].debit_eau_riviere}</td>
<td class="right">{$dataAnalyse[lst].debit_eau_forage}</td>
<td class="right">{$dataAnalyse[lst].debit_eau_mer}</td>
<td>{$dataAnalyse[lst].observations}</td>
</tr>
{/section}
</tbody>
</table>
</td>
</tr>

</table>