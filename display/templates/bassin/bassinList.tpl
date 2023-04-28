{include file="bassin/bassinSearch.tpl"}
{if $isSearch == 1}

<table class="tableaffichage">
<tr>
<td>
Récapitulatif hebdomadaire des quantités d'aliments distribués<br>
<form name="f_distrib" method="get" action="index.php">
<input type="hidden" name="module" value="bassinRecapAlim">
du <input class="date" name="dateDebut" value="{$dateDebut}"> au <input class="date" name="dateFin" value="{$dateFin}">
<input value="Générer le fichier (peut être long...)" type="submit">
</form>
</td>
</tr>
</table>
{if $droits.bassinGestion == 1}
<a href="index.php?module=bassinChange&bassin_id=0">Nouveau bassin...</a>
{/if}
<script>
setDataTables("cbassinList",true, true, false, 50);
</script>
<table id="cbassinList" class="tableliste">
<thead>
<tr>
<th>Nom</th>
<th>Description</th>
<th>Zone<br>d'implantation</th>
<th>Type</th>
<th>Utilisation</th>
<th>Circuit<br>d'eau</th>
<th>dimensions<br>(longueur x largeur x hauteur d'eau)</th>
<th>Surface - volume d'eau</th>
<th>Utilisé<br>actuellement ?</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
<a href="index.php?module=bassinDisplay&bassin_id={$data[lst].bassin_id}">
{$data[lst].bassin_nom}
</a>
</td>
<td>{$data[lst].bassin_description}</td>
<td>{$data[lst].bassin_zone_libelle}</td>
<td>{$data[lst].bassin_type_libelle}</td>
<td>{$data[lst].bassin_usage_libelle}</td>
<td>
<a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data[lst].circuit_eau_id}">
{$data[lst].circuit_eau_libelle}
</a>
</td>
<td>{$data[lst].longueur}x{$data[lst].largeur_diametre}x{$data[lst].hauteur_eau}</td>
<td>{$data[lst].surface} - {$data[lst].volume}</td>
<td>
<div class="center">
{if $data[lst].actif == 1}oui{elseif $data[lst].actif == 0}non{/if}
</div>
</td>
</tr>
{/section}
</tbody>
</table>
<br>
{/if}