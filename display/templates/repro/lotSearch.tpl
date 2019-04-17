<script>
$(document).ready(function() {
	$('select').change(function () { 
		this.form.submit();
	});
});
</script>
<table class="tablemulticolonne">
<tr><td>
<fieldset>
<legend>Afficher les lots</legend>
<form method="get" action="index.php" id="search">
<input type="hidden" name="module" value="lotList">
Année : 
<select name="annee">
{section name=lst loop=$annees}
<option value="{$annees[lst].annee}" {if $annees[lst].annee == $annee}selected{/if}>
{$annees[lst].annee}
</option>
{/section}
</select>
Site : 
<select id="site" name="site_id">
<option value="" {if $site_id == ""}selected{/if}>Sélectionnez le site...</option>
{section name=lst loop=$site}
<option value="{$site[lst].site_id}"} {if $site[lst].site_id == $site_id}selected{/if}>
{$site[lst].site_name}
</option>
{/section}
</select>

<input type="submit" value="Rechercher">

</form>
</fieldset>
</td>
</tr>
<tr>
<td>
{include file="repro/lotList.tpl"}
</td>
</tr>
</table>