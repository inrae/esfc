<script>
$(document).ready(function() { 
	$("select").change(function () {
		// $("#search").submit();
	} );
	$(".date").datepicker({ dateFormat: "dd/mm/yy" });
} ) ;
</script>
<form method="get" action="index.php" id="search">
<input type="hidden" name="isSearch" value="1">
<input type="hidden" name="module" value="repartitionList">
<table class="tableaffichage">
<tr>
<td>
Catégorie d'alimentation : 
<select name="categorie_id" id="categorie_id">
<option value="" {if $repartitionSearch.categorie_id==""}selected{/if}>Sélectionnez la catégorie...</option>
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $repartitionSearch.categorie_id == $categorie[lst].categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>
<br>
Date à partir de laquelle sont affichées les répartitions : 
<input class="date" name="date_reference" value="{$repartitionSearch.date_reference}">
</td>
</tr>
<tr>
<td>
<label for "limit">Nombre d'éléments à afficher : </label>
<input id="limit" name="limit" value="{$repartitionSearch.limit}" pattern="[0-9]+" required size="5">
<label for "offset">Afficher à partir de l'enregistrement n° : </label> 
<input id="offset" name="offset" value="{$repartitionSearch.offset}" pattern="[0-9]+" required size="5">
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