<form method="get" action="index.php" id="search">
<input type="hidden" name="module" value="reproInitExec">
<table class="tableaffichage">
<tr><td>Campagne à initialiser : 
<select name="annee">
{section name=lst loop=$annees}
<option value="{$annees[lst].annee}" {if $annees[lst].annee == $annee}selected{/if}>
{$annees[lst].annee}
</option>
{/section}
</select>
</td></tr>
<tr>
<td>
<div class="center">
<input type="submit" value="Initialiser l'année">
</div>
</td>
</tr>
</table>
</form>