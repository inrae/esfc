{if $droits.bassinGestion == 1}
<a href="index.php?module=analyseEauChange&analyse_eau_id={$dataAnalyse.analyse_eau_id}&circuit_eau_id={$dataAnalyse.circuit_eau_id}&origine=List">
Modifier les résultats de l'analyse...
</a>
{/if}
<div class="row">
<div class="col-lg-8 form-display">
<dl class="dl-horizontal">
<dt>{t}Circuit d'eau : {/t}</dt>
<dd>{$dataAnalyse.circuit_eau_libelle}</dd>
<dl class="dl-horizontal">
<dt>{t}Date d'analyse : {/t}</dt>
<dd>{$dataAnalyse.analyse_eau_date}</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}Température : {/t}</dt>
<dd>{$dataAnalyse.temperature}</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}Oxygène (mg/l) : {/t}</dt>
<dd>{$dataAnalyse.oxygene}</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}Oxygène (% sat): {/t}</dt>
<dd>{$dataAnalyse.o2_pc}</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}salinité : {/t}</dt>
<dd>{$dataAnalyse.salinite}</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}pH : {/t}</dt>
<dd>{$dataAnalyse.ph}</dd>
</dl>
{if $dataAnalyse.laboratoire_analyse_id > 0}
<dl class="dl-horizontal">
<dt>{t}Laboratoire :{/t}</dt>
<dd>{$dataAnalyse.laboratoire_analyse_libelle}</dd>
</dl>
{/if}
<dl class="dl-horizontal">
<td colspan="2">
<div class="row">
<div class="col-lg-8 form-display">
<dl class="dl-horizontal">
<th>{t}{/t}</th>
<th>{t}Valeur réelle{/t}</th>
<th>{t}Valeur N-N{/t}</th>
<th>{t}Valeur seuil{/t}</th>
</dl>
<dl class="dl-horizontal">
<dt>{t}NH4{/t}</dt>
<dd>{$dataAnalyse.nh4}{/t}</dt>
<dd>{$dataAnalyse.n_nh4}{/t}</dt>
<dd>{$dataAnalyse.nh4_seuil}</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}NO2{/t}</dt>
<dd>{$dataAnalyse.no2}{/t}</dt>
<dd>{$dataAnalyse.n_no2}{/t}</dt>
<dd>{$dataAnalyse.no2_seuil}</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}NO3{/t}</dt>
<dd>{$dataAnalyse.no3}{/t}</dt>
<dd>{$dataAnalyse.n_no3}{/t}</dt>
<dd>{$dataAnalyse.no3_seuil}</dd>
</dl>
</div>
</div>
</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}Backwash mécanique : {/t}</dt>
<dd>{if $dataAnalyse.backwash_mecanique == 1}Oui{else}Non{/if}</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}Backwash biologique : {/t}</dt>
<dd>{if $dataAnalyse.backwash_biologique == 1}Oui{else}Non{/if}</dd>
</dl>

<dl class="dl-horizontal">
<dt>{t}Commentaire backwash bio : {/t}</dt>
<dd>{$dataAnalyse.backwash_biologique_commentaire}</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}Débit d'eau de rivière : {/t}</dt>
<dd>{$dataAnalyse.debit_eau_riviere}</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}Débit d'eau de forage : {/t}</dt>
<dd>{$dataAnalyse.debit_eau_forage}</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}Débit d'eau de mer : {/t}</dt>
<dd>{$dataAnalyse.debit_eau_mer}</dd>
</dl>
<dl class="dl-horizontal">
<td colspan="2">
<fieldset><legend>{t}Métaux analysés{/t}</legend>
{$dataAnalyse.metaux}
</fieldset>
</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}Observations : {/t}</dt>
<dd>{$dataAnalyse.observations}</dd>
</dl>
</div>
</div>