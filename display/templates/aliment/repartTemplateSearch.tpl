<script>
$(document).ready(function() { 
	$("select").change(function () {
		$("#search").submit();
	} );
} ) ;
</script>
<form method="get" action="index.php" id="search">
<input type="hidden" name="isSearch" value="1">
<input type="hidden" name="module" value="repartTemplateList">
<table class="tableaffichage">
<tr>
<td>
Catégorie d'alimentation : 
<select name="categorie_id" id="categorie_id">
<option value="" {if $repartTemplateSearch.categorie_id==""}selected{/if}>Sélectionnez la catégorie...</option>
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $repartTemplateSearch.categorie_id == $categorie[lst].categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>
<br>
 Modèle de répartition actuellement utilisable ? 
 <select name="actif">
 <option value="-1" {if $repartTemplateSearch.actif == "-1"}selected{/if}>Indifférent</option>
 <option value="1" {if $repartTemplateSearch.actif == "1"}selected{/if}>Oui</option>
 <option value="0" {if $repartTemplateSearch.actif == "0"}selected{/if}>Non</option>
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