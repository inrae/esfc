<table class="tableaffichage">
<tr>
<td>
Nom du bassin : {$dataBassin.bassin_nom}
<br>
{if strlen($dataBassin.bassin_zone_libelle) > 1}
Implantation : {$dataBassin.bassin_zone_libelle} 
{/if}
 Type de bassin : {$dataBassin.bassin_type_libelle}
 <br>
{if strlen($dataBassin.bassin_usage_libelle) > 1}
Utilisation actuelle : {$dataBassin.bassin_usage_libelle}
{/if}
Circuit d'eau : {$dataBassin.circuit_eau_libelle}
<br>
{if {$dataBassin.actif == 1}Bassin en activité{else}Bassin non utilisé ou réformé{/if}

</td>
</tr>
</table>