<script>
$(document).ready(function() { 
	$(".date").datepicker( { dateFormat: "dd/mm/yy" } );
} ) ;
</script>
<form method="get" action="index.php">
<input type="hidden" name="module" value="bassinDisplay">
<input type="hidden" name="bassin_id" value="{$dataBassin.bassin_id}">
<table class="tableaffichage">
<tr>
<td>
Date de départ : 
<input class="date" name="date_debut" value="{$searchAlim.date_debut}">
Date de fin : 
<input class="date" name="date_fin" value="{$searchAlim.date_fin}">
<input type="submit" value="Rechercher">
</table>
</form>
<script>
setDataTables("calimList");
</script>
<table id="calimList" class="tableaffichage">
<thead>
<tr>
<th>Date</th>
<th>Total<br>distribué</th>
<th>Reste</th>
{section name=lst loop=$alimentListe}
<th>{$alimentListe[lst].aliment_libelle_court}</th>
{/section}
</tr>
</thead>
<tbody>
{section name=lst loop=$dataAlim}
<tr>
<td>{$dataAlim[lst].distrib_quotidien_date}</td>
<td>{$dataAlim[lst].total_distribue}</td>
<td>{$dataAlim[lst].reste}</td>
{section name=ali loop=$alimentListe}
{$nom=$alimentListe[ali].aliment_libelle_court}
<td>{$dataAlim[lst][$nom]}</td>
{/section}
</tr>
{/section}
</tbody>
</table>