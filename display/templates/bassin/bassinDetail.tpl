<table class="tableaffichage">
<tr>
<td>
<label>Nom du bassin : </label>{$dataBassin.bassin_nom}
<br>
{if strlen($dataBassin.bassin_zone_libelle) > 1}
<label>Implantation : </label>{$dataBassin.bassin_zone_libelle} 
{/if}
 <label>Type de bassin : </label>{$dataBassin.bassin_type_libelle}
 <br>
{if strlen($dataBassin.bassin_usage_libelle) > 1}
<label>Utilisation actuelle : </label>{$dataBassin.bassin_usage_libelle}
<br>
{/if}

<label>Circuit d'eau : </label><a style="display:inline;" href="index.php?module=circuitEauDisplay&circuit_eau_id={$dataBassin.circuit_eau_id}">
{$dataBassin.circuit_eau_libelle}
</a>
<br>
{if $dataBassin.actif == 1}Bassin en activité{else}Bassin non utilisé ou réformé{/if}

</td>
</tr>
</table>