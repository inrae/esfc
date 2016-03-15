
{if $droits.reproGestion == 1}
<script>
$('document').ready(function() { 
	var clicked = 1;
	var duree = $('#duree').val();
	if (duree > 1) {
		$('#densite').prop("disabled", true);
	}
	$('#duree').change(function () { 
		var duree = $(this).val();
		if (duree == 1) {
			$('#densite').prop("disabled", false);
		} else {
			$("#densite").prop("disabled", true);
		}
	});
	$("#bassinCheck").on("change", function () { 
		clicked == 1 ? clicked = 0 : clicked = 1;
		if (clicked == 1) {
			$('.check').prop("checked",true);
		} else {
			$('.check').prop("checked", false);
		}
	});
});
</script>
<a href="index.php?module=lotChange&lot_id=0">Nouveau lot de larves...</a>
<form name="alimJuv" method="post" action="index.php">
{/if}
<table id="clotlist" class="tableliste">
<thead>
<tr>
<th>Nom du lot</th>
<th>Parents</th>
<th>Séquence</th>
<th>Bassin</th>
<th>Date<br>d'éclosion</th>
<th>Age<br>(jours)</th>
<th>Nbre de larves<br>estimé</th>
<th>Nbre de larves<br>comptées</th>
<th>Marque VIE</th>
<th>Date de marquage<br>VIE</th>
{if $droits.reproGestion == 1}
<th>Fiche<br>alim.
<br>
<div class="center">
<input type="checkbox" id="bassinCheck" checked value="1">
</div>
</th>
{/if}
</tr>
</thead>
<tbody>
{section name=lst loop=$lots}
<tr>
<td>
<a href="index.php?module=lotDisplay&lot_id={$lots[lst].lot_id}">
{$lots[lst].lot_nom}
</a>
</td>
<td>{$lots[lst].parents}</td>
<td class="center">
<a href="index.php?module=sequenceDisplay&sequence_id={$lots[lst].sequence_id}">
{$lots[lst].sequence_nom}
&nbsp;
{$lots[lst].croisement_nom}
</a>
</td>
<td>
<a href="index.php?module=bassinDisplay&bassin_id={$lots[lst].bassin_id}">
{$lots[lst].bassin_nom}
</a>
</td>
<td>{$lots[lst].eclosion_date}</td>
<td class="center">{$lots[lst].age}</td>
<td class="right">{$lots[lst].nb_larve_initial}</td>
<td class="right">{$lots[lst].nb_larve_compte}</td>
<td>
{if $lots[lst].vie_modele_id > 0}
{$lots[lst].couleur}, {$lots[lst].vie_implantation_libelle}, {$lots[lst].vie_implantation_libelle2}
{/if}
</td>
<td>{$lots[lst].vie_date_marquage}</td>
{if $droits.reproGestion == 1}
<td class="center">
<input type="checkbox" class="check" name="lots[]" value="{$lots[lst].lot_id}" checked>
</td>
{/if}
</tr>
{/section}
</tbody>
</table>

{if $droits.reproGestion == 1}
<fieldset><legend>Alimentation quotidienne</legend>

<input type="hidden" name="module" value="lotalimGenerate">
Date de début d'alimentation :
<input name="date_debut_alim" class="date" value="{$dataAlim.date_debut_alim}">
Durée d'alimentation (en jours) : 
<input id="duree" name="duree" required value="{$dataAlim.duree}" class="nombre">
<br>
Nombre d'artémies par ml : 
<input id="densite" name="densite" value="{$dataAlim.densite}" class="nombre">
<br>
<div class="center">
<input type="submit" value="Générer la fiche d'alimentation">
</div>
</fieldset>
</form>
{/if}
