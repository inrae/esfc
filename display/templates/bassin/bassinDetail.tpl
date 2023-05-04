<div class="row">
<div class="col-lg-8 form-display">
<dl class="dl-horizontal">
<dt>{t}
<label>Nom du bassin : </label>
{/t}</dt>
<dd>
{$dataBassin.bassin_nom}
{/t}</dt>
<dd>
<label>Site : </label>
{/t}</dt>
<dd>
{$dataBassin.site_name}
</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}
<label>Implantation : </label>
{/t}</dt>
<dd>
{$dataBassin.bassin_zone_libelle} 
</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}
 <label>Type de bassin : </label>
 </dd>
 <dt>{t}
 {$dataBassin.bassin_type_libelle}
 </dd>
 </dl>
 <dl class="dl-horizontal">
<dt>{t}
<label>Utilisation actuelle : </label>
{/t}</dt>
<dd>
{$dataBassin.bassin_usage_libelle}
</dd>
</dl>
<dl class="dl-horizontal">
<dt>{t}
<label>Circuit d'eau : </label>
{/t}</dt>
<dd>
<a style="display:inline;" href="index.php?module=circuitEauDisplay&circuit_eau_id={$dataBassin.circuit_eau_id}">
{$dataBassin.circuit_eau_libelle}
</a>
</dd>
</dl>
<dl class="dl-horizontal">
<td colspan="4">
{if $dataBassin.actif == 1}Bassin en activité{else}Bassin non utilisé ou réformé{/if}
</dd>
</dl>
</div>
</div>