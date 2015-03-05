<script>
$(document).ready(function() { 
	$("select").change(function () {
		$("#search").submit();
	} );
} ) ;
setDataTables("cpoissonList", false, false, true);
</script>
<form method="get" action="index.php" id="search">
<input type="hidden" name="module" value="poissonCampagneList">
<table class="tableaffichage">
<tr><td>Année : 
<select name="annee">
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

<table id="cpoissonList" class="tableaffichage">
<thead>
<tr>
<th>Détail<br>du poisson</th>
<th>Matricule</th>
<th>Prénom</th>
<th>Pittag</th>
<th>Cohorte</th>
<th>Sexe</th>
<th>Tx de croissance<br>journalier</th>
<th>Specific<br>growth rate</th>
<th>Années de<br>croisement</th>
<th>Séquences</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$data}
<tr>
<td class="center">
<a href=index.php?module=poissonDisplay&poisson_id={$data[lst].poisson_id}>
<img src="display/images/fish.png" height="24" title="Accéder à la fiche détaillée du poisson">
</a>
<td>
{$data[lst].matricule}
</td>
<td>
{$data[lst].prenom}
</td>
<td>{$data[lst].pittag_valeur}</td>
<td>{$data[lst].cohorte}</td>
<td>{$data[lst].sexe_libelle_court}</td>
<td class="{if $data[lst].tx_croissance_journalier > 0.02}etat3{else}right{/if}">{$data[lst].tx_croissance_journalier}</td>
<td class="{if $data[lst].specific_growth_rate > 0.02}etat3{else}right{/if}">{$data[lst].specific_growth_rate}</td>
<td>{$data[lst].annees}</td>
<td>{$data[lst].sequences}</td>
</tr>
{/section}
</tdata>
</table>