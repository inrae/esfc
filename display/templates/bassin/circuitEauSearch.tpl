<script>
$(document).ready(function() { 
$( "#analyse_date" ).datepicker( { dateFormat: "dd/mm/yy" } );
});
</script>

<form method="get" action="index.php">
<input type="hidden" name="isSearch" value="1">
<input type="hidden" name="module" value="circuitEauList">
<table class="tableaffichage">
<tr>
<td>
<label for "circuit_eau_libelle">Nom du circuit d'eau : </label> 
<input id="circuit_eau_libelle" name="circuit_eau_libelle" value="{$circuitEauSearch.circuit_eau_libelle}" autofocus size="10">
<br>
<label>Circuit d'eau en service ? </label>
<input type="radio" name="circuit_eau_actif" value="1" {if $circuitEauSearch.circuit_eau_actif == 1}checked{/if}> oui
<input type="radio" name="circuit_eau_actif" value="0" {if $circuitEauSearch.circuit_eau_actif == 0}checked{/if}> non
<input type="radio" name="circuit_eau_actif" value="-1" {if $circuitEauSearch.circuit_eau_actif == -1}checked{/if}> indifférent
<br>
<label for "analyse_date">Date de référence pour les analyses d'eau : </label>
<input id="analyse_date" name="analyse_date" value="{$circuitEauSearch.analyse_date}" size="10">
<br>
<div class="center">
<input type="submit" value="Rechercher">
</div>
</td>
</tr>
</table>
</form>