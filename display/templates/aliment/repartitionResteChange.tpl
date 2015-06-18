<script>
$(document).ready(function() {
	$(".num5").attr( {
		pattern: "[0-9]*",
		title: "Donnée numérique"
		} );
	$(".reste").focus(function () { 
		//store old value
        $(this).data('oldValue',$(this).val());
	} );
	$(".reste").change(function ()  {
		/*
		* calcule le reste total
		*/
		var oldValue = $(this).data('oldValue');
		if (isNaN(oldValue)) oldValue = 0 ;
		if (oldValue == "") oldValue = 0;
		var newValue = $(this).val();
		if (isNaN(newValue)) newValue = 0;
		if (newValue == "") newValue = 0 ;
		var cle = $(this).data('cle');
		var nomChamp = "#reste_total_"+cle;
		var total = $(nomChamp).val();
		if (isNaN(total)) total = 0;
		if (total == "") total = 0;
		total = parseInt(total) - parseInt(oldValue) + parseInt(newValue) ;
		$(nomChamp).val(total);
		/*
		* Calcul du pourcentage de reste
		*/
		nomChamp = "#total_distribue_"+cle;
		var totalDistrib = $(nomChamp).val();
		if (isNaN(totalDistrib)) totalDistrib = 0 ;
		if (totalDistrib == "" ) totalDistrib = 0 ;
		if (totalDistrib > 0) {
			nomChamp = "#taux_reste_"+cle;
			var taux = parseFloat(total) / parseFloat(totalDistrib) * 100 ;
			$(nomChamp).val(taux);
		}
	} );
	$(".resteTotal").change(function () {
		var total = $(this).val() ;
		if (isNaN(total)) total = 0 ;
		if (total == "") total = 0 ;
		var cle = $(this).data('cle');
		/*
		* Calcul du pourcentage de reste
		*/
		nomChamp = "#total_distribue_"+cle;
		var totalDistrib = $(nomChamp).val();
		if (isNaN(totalDistrib)) totalDistrib = 0 ;
		if (totalDistrib == "" ) totalDistrib = 0 ;
		if (totalDistrib > 0) {
			nomChamp = "#taux_reste_"+cle;
			var taux = parseFloat(total) / parseFloat(totalDistrib) * 100 ;
			$(nomChamp).val(taux);
		}
	} );
} );
</script>
<a href="index.php?module=repartitionList">Retour à la liste</a>
<h2>Saisie des restes</h2>
<b>{$data.categorie_libelle}</b> - Période du <b>{$data.date_debut_periode}</b> au <b>{$data.date_fin_periode}</b>
<div>
<form id="repartitionForm" method="post" action="index.php?module=repartitionResteWrite">
<input type="hidden" name="repartition_id" value="{$data.repartition_id}">
<input type="hidden" name="date_debut_periode" value="{$data.date_debut_periode}">
<input type="hidden" name="date_fin_periode" value="{$data.date_fin_periode}">
<input type="hidden" name="nbJour" value="{$nbJour}">
<table>
<tr>
<th>Bassin</th>
{section name=lst loop=$dateArray}
<th>{$dateArray[lst].libelle}</th>
{/section}
<th>Total<br>reste</th>
<th>Commentaire</th>
<th>Total<br>distribué</th>
<th>Taux de<br>reste</th>
</tr>
{section name=lst loop=$dataBassin}
<input name="distribution_id_{$dataBassin[lst].distribution_id}" type="hidden" value="{$dataBassin[lst].distribution_id}">
<input name="bassin_id_{$dataBassin[lst].distribution_id}" type="hidden" value="{$dataBassin[lst].bassin_id}">
<tr>
<td>{$dataBassin[lst].bassin_nom}</td>
{foreach from=$dataBassin[lst].reste key=k item=v}
<td>
<input class="reste num5" data-cle="{$dataBassin[lst].distribution_id}" name="reste_{$k}_{$dataBassin[lst].distribution_id}" id="reste_{$k}_{$dataBassin[lst].distribution_id}" value="{$v}">
</td>
{/foreach}
<td>
<input class="num5 resteTotal" name="reste_total_{$dataBassin[lst].distribution_id}" data-cle="{$dataBassin[lst].distribution_id}" id="reste_total_{$dataBassin[lst].distribution_id}" value="{$dataBassin[lst].reste_total}">
</td>
<td>
<input style="width:10em;" name="ration_commentaire_{$dataBassin[lst].distribution_id}" data-cle="{$dataBassin[lst].distribution_id}" id="ration_commentaire_{$dataBassin[lst].distribution_id}" value="{$dataBassin[lst].ration_commentaire}">
</td>
<td>
<input name="total_periode_distribue_{$dataBassin[lst].distribution_id}" class="num5" readonly id="total_periode_distribue_{$dataBassin[lst].distribution_id}" value="{$dataBassin[lst].total_periode_distribue}">
</td>
<td>
<input name="taux_reste_{$dataBassin[lst].distribution_id}" class="num5" readonly id="taux_reste_{$dataBassin[lst].distribution_id}" value="{$dataBassin[lst].taux_reste}">
</td>
</tr>
{/section}
<tr>
<td style="text_align:center;">
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</td>
</tr>
</table>
</form>
</div>

