<script>
$(document).ready(function() {
	$('#annee').change(function () { 
		this.form.submit();
	});
});
</script>
<form method="get" action="index.php" id="search">
<input type="hidden" name="module" value="devenirList">
<table class="tableaffichage">
<tr><td>Année : 
<select name="annee" id="annee">
{section name=lst loop=$annees}
<option value="{$annees[lst].annee}" {if $annees[lst].annee == $annee}selected{/if}>
{$annees[lst].annee}
</option>
{/section}
</select>
<input type="submit" value="Rechercher">
</td>
</tr>
</table>
</form>
<h2>Destination des poissons</h2>
{include file="repro/devenirList.tpl"}