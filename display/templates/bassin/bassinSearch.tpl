<script>
$(document).ready(function() { 
	$("select").change(function () {
		$("#search").submit();
	} );
} ) ;
</script>
<form method="get" action="index.php" id="search">
<input type="hidden" name="isSearch" value="1">
<input type="hidden" name="module" value="bassinList">
<table class="tableaffichage">
<tr>
<td>
Nom :</td><td> <input name="bassin_nom" value="{$bassinSearch.bassin_nom}">
</td>
<td>
Bassin en activité ?</td><td> 
<input type="radio" name="bassin_actif" value="1" {if $bassinSearch.bassin_actif == 1}checked{/if}>oui
<input type="radio" name="bassin_actif" value="0" {if $bassinSearch.bassin_actif == 0}checked{/if}>non
<input type="radio" name="bassin_actif" value="" {if $bassinSearch.bassin_actif == ""}checked{/if}>Indifférent
</td>
</tr>
<tr>
<td>
Type de bassin :</td><td> 
<select name="bassin_type">
<option value="" {if $bassinSearch.bassin_type==""}selected{/if}>Sélectionnez le type de bassin...</option>
{section name=lst loop=$bassin_type}
<option value="{$bassin_type[lst].bassin_type_id}" {if $bassinSearch.bassin_type == $bassin_type[lst].bassin_type_id}selected{/if}>
{$bassin_type[lst].bassin_type_libelle}
</option>
{/section}
</select>
</td>
<td>
Usage : </td><td>
<select name="bassin_usage">
<option value="" {if $bassinSearch.bassin_usage==""}selected{/if}>Sélectionnez l'usage du bassin...</option>
{section name=lst loop=$bassin_usage}
<option value="{$bassin_usage[lst].bassin_usage_id}" {if $bassinSearch.bassin_usage == $bassin_usage[lst].bassin_usage_id}selected{/if}>
{$bassin_usage[lst].bassin_usage_libelle}
</option>
{/section}
</select>
</td>
</tr>
<tr>
<td>
Zone d'implantation : </td><td>
<select name="bassin_zone">
<option value="" {if $bassinSearch.bassin_zone==""}selected{/if}>Sélectionnez la zone d'implantation...</option>
{section name=lst loop=$bassin_zone}
<option value="{$bassin_zone[lst].bassin_zone_id}" {if $bassinSearch.bassin_zone == $bassin_zone[lst].bassin_zone_id}selected{/if}>
{$bassin_zone[lst].bassin_zone_libelle}
</option>
{/section}
</select>
</td>
<td>
Circuit d'eau : </td><td>
<select name="circuit_eau">
<option value="" {if $bassinSearch.circuit_eau==""}selected{/if}>Sélectionnez le circuit d'eau...</option>
{section name=lst loop=$circuit_eau}
<option value="{$circuit_eau[lst].circuit_eau_id}" {if $bassinSearch.circuit_eau == $circuit_eau[lst].circuit_eau_id}selected{/if}>
{$circuit_eau[lst].circuit_eau_libelle}
</option>
{/section}
</select>
</td>
</tr>
<tr>
<td>Site :</td>
<td>
<select name="site_id">
<option value="" {if $bassinSearch.site_id == ""}selected{/if}>Sélectionnez le site...</option>
{section name=lst loop=$site}
<option value="{$site[lst].site_id}" {if $bassinSearch.site_id == $site[lst].site_id}selected{/if}>
{$site[lst].site_name}
</option>
{/section}
</select>
</td>
<td colspan="2">

<input type="submit" value="Rechercher">

</td>
</tr>
</table>
</form>