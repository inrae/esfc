<script>
$(document).ready(function() { 
	$("select").change(function () {
		$("#search").submit();
	} );
} ) ;
</script>
<form method="get" action="index.php" id="search">
<input type="hidden" name="isSearch" value="1">
<input type="hidden" name="module" value="poissonList">
<table class="tableaffichage">
<tr>
<td colspan='2'>
Libellé à rechercher (tag, prenom, matricule, cohorte) : 
<input name="texte" value="{$poissonSearch.texte}" size="40" maxlength="40">
<br>
Catégorie :
<select name="categorie" id="categorie">
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $poissonSearch.categorie == $categorie[lst].categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>
 Statut de l'animal : 
<select name="statut" id="statut">
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
<td>Afficher : <label>les données morphologiques ?</label>
<input type="radio" name="displayMorpho" value="0" {if $poissonSearch.displayMorpho == 0}checked{/if}> non
<input type="radio" name="displayMorpho" value="1" {if $poissonSearch.displayMorpho == 1}checked{/if}> oui
<label>&nbsp;le bassin ?</label>
<input type="radio" name="displayBassin" value="0" {if $poissonSearch.displayBassin == 0}checked{/if}> non
<input type="radio" name="displayBassin" value="1" {if $poissonSearch.displayBassin == 1}checked{/if}> oui

</td>
<td>
<div>
<input type="submit" value="Rechercher">
</div>
</td>
</tr>
<tr>
<td colspan = "2">
Afficher : <label>le cumul des températures ? </label>
<input type="radio" name="displayCumulTemp" value="0" {if $poissonSearch.displayCumulTemp == 0}checked{/if}> non
<input type="radio" name="displayCumulTemp" value="1" {if $poissonSearch.displayCumulTemp == 1}checked{/if}> oui
(du 
<input class="date" name="dateDebutTemp" value="{$poissonSearch.dateDebutTemp}">
au 
<input class="date" name="dateFinTemp" value="{$poissonSearch.dateFinTemp}">
- calcul long...)
</td>
<tr>
</table>
</form>