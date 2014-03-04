<form method="get" action="index.php">
<input type="hidden" name="isSearch" value="1">
<input type="hidden" name="module" value="bassinList">
<table class="tableaffichage">
<tr>
<td>
Type de bassin : 
<select name="bassin_type">
<option value="" {if $bassinSearch.bassin_type==""}selected{/if}>Sélectionnez le type de bassin...</option>
{section name=lst loop=$bassin_type}
<option value="{$bassin_type[lst].bassin_type_id}" {if $bassinSearch.bassin_type == $bassin_type[lst].bassin_type_id}selected{/if}>
{$bassin_type[lst].bassin_type_libelle}
</option>
{/section}
</select>

Usage : 
<select name="bassin_usage">
<option value="" {if $bassinSearch.bassin_usage==""}selected{/if}>Sélectionnez le type de bassin...</option>
{section name=lst loop=$bassin_usage}
<option value="{$bassin_usage[lst].bassin_usage_id}" {if $bassinSearch.bassin_usage == $bassin_usage[lst].bassin_usage_id}selected{/if}>
{$bassin_usage[lst].bassin_usage_libelle}
</option>
{/section}
</select>
<br>
Zone d'implantation : 
<select name="bassin_zone">
<option value="" {if $bassinSearch.bassin_zone==""}selected{/if}>Sélectionnez la zone d'implantation...</option>
{section name=lst loop=$bassin_zone}
<option value="{$bassin_zone[lst].bassin_zone_id}" {if $bassinSearch.bassin_zone == $bassin_zone[lst].bassin_zone_id}selected{/if}>
{$bassin_zone[lst].bassin_zone_libelle}
</option>
{/section}
</select>

<br>
Circuit d'eau : 
<select name="circuit_eau">
<option value="" {if $bassinSearch.circuit_eau==""}selected{/if}>Sélectionnez le circuit d'eau...</option>
{section name=lst loop=$circuit_eau}
<option value="{$circuit_eau[lst].circuit_eau_id}" {if $bassinSearch.circuit_eau == $circuit_eau[lst].circuit_eau_id}selected{/if}>
{$circuit_eau[lst].circuit_eau_libelle}
</option>
{/section}
</select>

Bassin en activité ? 
<input type="radio" name="bassin_actif" value="1" {if $bassinSearch.bassin_actif == 1}checked{/if}>oui
<input type="radio" name="bassin_actif" value="0" {if $bassinSearch.bassin_actif == 0}checked{/if}>non
<input type="radio" name="bassin_actif" value="" {if $bassinSearch.bassin_actif == ""}checked{/if}>Indifférent

</td>
</tr>
<tr>
<td>
<div class="center">
<input type="submit" value="Rechercher">
</div>
</td>
</tr>
</table>
</form>