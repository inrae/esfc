<form method="get" action="index.php">
<input type="hidden" name="isSearch" value="1">
<input type="hidden" name="module" value="poissonList">
<table class="tableaffichage">
<tr>
<td>
Libellé à rechercher (tag, prenom, matricule, cohorte) : 
<input name="texte" value="{$poissonSearch.texte}" size="40" maxlength="40">
<br>
Statut de l'animal : 
<select name="statut">
<option value="" {if $poissonSearch.statut==""}selected{/if}>Sélectionnez le statut...</option>
{section name=lst loop=$statut}
<option value="{$statut[lst].poisson_statut_id}" {if $poissonSearch.statut == $statut[lst].poisson_statut_id}selected{/if}>
{$statut[lst].poisson_statut_libelle}
</option>
{/section}
</select>
 Sexe : 
 <select name="sexe">
 <option value="" {if $poissonSearch.sexe == ""}selected{/if}>Sélectionnez le sexe...</option>
{section name=lst loop=$sexe}
<option value="{$sexe[lst].sexe_id}" {if $poissonSearch.sexe == $sexe[lst].sexe_id}selected{/if}>
{$sexe[lst].sexe_libelle}
</option>
{/section}
 </select>
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