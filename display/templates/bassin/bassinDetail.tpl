<table class="tableaffichage">
<tr>
<td>
<label>Nom du bassin : </label>
</td>
<td>
{$dataBassin.bassin_nom}
</td>
<td>
<label>Site : </label>
</td>
<td>
{$dataBassin.site_name}
</td>
</tr>
<tr>
<td>
<label>Implantation : </label>
</td>
<td>
{$dataBassin.bassin_zone_libelle} 
</td>
</tr>
<tr>
<td>
 <label>Type de bassin : </label>
 </td>
 <td>
 {$dataBassin.bassin_type_libelle}
 </td>
 </tr>
 <tr>
<td>
<label>Utilisation actuelle : </label>
</td>
<td>
{$dataBassin.bassin_usage_libelle}
</td>
</tr>
<tr>
<td>
<label>Circuit d'eau : </label>
</td>
<td>
<a style="display:inline;" href="index.php?module=circuitEauDisplay&circuit_eau_id={$dataBassin.circuit_eau_id}">
{$dataBassin.circuit_eau_libelle}
</a>
</td>
</tr>
<tr>
<td colspan="4">
{if $dataBassin.actif == 1}Bassin en activité{else}Bassin non utilisé ou réformé{/if}
</td>
</tr>
</table>