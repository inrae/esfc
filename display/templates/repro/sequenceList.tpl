<script>
$(document).ready(function() { 
	$("#annee").change(function () { 
		$("#campagneAnnee").val($("#annee").val());
	});
	$("#site").change(function () { 
		var site = $(this).val();
		if (site.length > 0) {
		$("#campagneSite").val(site);
		}
	});
	$("#initForm").submit(function(event) { 
		if (!confirm ("Confirmez l'initialisation des bassins pour la campagne et le site considérés")) {
			event.preventDefault();
		}
	});
} ) ;
</script>
<form method="get" action="index.php" id="search">
<input type="hidden" name="module" value="sequenceList">
<table class="table table-bordered table-hover datatable" class="tableaffichage">
<tr><td>Année : 
<select id="annee" name="annee">
{section name=lst loop=$annees}
<option value="{$annees[lst].annee}" {if $annees[lst].annee == $annee}selected{/if}>
{$annees[lst].annee}
</option>
{/section}
</select>
Site : 
<select id="site" name="site_id">
<option value="" {if $site_id == ""}selected{/if}>Sélectionnez le site...</option>
{section name=lst loop=$site}
<option value="{$site[lst].site_id}"} {if $site[lst].site_id == $site_id}selected{/if}>
{$site[lst].site_name}
</option>
{/section}
</select>
<input type="submit" value="Rechercher">
</td>
</tr>
</table>
</form>
<h2{t}Séquences{/t}</h2>
<a href="index.php?module=sequenceChange&sequence_id=0">Nouvelle séquence pour l'année</a>
<table class="table table-bordered table-hover datatable" id="csequenceList" class="tableliste">
<thead>
<tr>
<th>Site</th>
<th>Nom de la séquence</th>
<th>Date de début</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>{$data[lst].site_name}</td>
<td>
<a href="index.php?module=sequenceDisplay&sequence_id={$data[lst].sequence_id}">
{$data[lst].sequence_nom}
</a>
</td>
<td>{$data[lst].sequence_date_debut}</td>
</tr>
{/section}
</tbody>
</table>

<h2{t}Bassins{/t}</h2>
{if $droits.reproGestion == 1}
<form id="initForm" method="post" action="index.php?module=bassinCampagneInit">
Initialiser la liste des bassins pour la campagne 
<select id="campagneAnnee" name="annee">
{section name=lst loop=$annees}
<option value="{$annees[lst].annee}" {if $annees[lst].annee == $annee}selected{/if}>
{$annees[lst].annee}
</option>
{/section}
</select>
, site 
<select id="campagneSite" name="site_id">
{section name=lst loop=$site}
<option value="{$site[lst].site_id}"} {if $site[lst].site_id == $site_id}selected{/if}>
{$site[lst].site_name}
</option>
{/section}
</select>
<input type="submit" value="Initialiser">
</form>
{/if}
{include file="repro/bassinCampagneList.tpl"}