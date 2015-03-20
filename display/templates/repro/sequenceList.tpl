<script>
$(document).ready(function() { 
	$("select").change(function () {
		$("#search").submit();
	} );
	 $('#confirmation').on('click', function () {
	        return confirm("Confirmez-vous l'initialisation à partir des bassins actifs identifiés pour la reproduction ?");
	    } );
} ) ;
</script>
<form method="get" action="index.php" id="search">
<input type="hidden" name="module" value="sequenceList">
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
<h2>Séquences</h2>
<a href="index.php?module=sequenceChange&sequence_id=0">Nouvelle séquence pour l'année</a>
<table id="csequenceList" class="tableliste">
<thead>
<tr>
<th>Nom de la séquence</th>
<th>Date de début</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$data}
<tr>
<td>
<a href="index.php?module=sequenceDisplay&sequence_id={$data[lst].sequence_id}">
{$data[lst].sequence_nom}
</a>
</td>
<td>{$data[lst].sequence_date_debut}</td>
</tr>
{/section}
</tdata>
</table>

<h2>Bassins</h2>
{if $droits.reproGestion == 1}
<a id="confirmation" href="index.php?module=bassinCampagneInit&annee={$annee}">Initialiser la liste des bassins pour la campagne</a>
{/if}
{include file="repro/bassinCampagneList.tpl"}