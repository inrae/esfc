<script>
$(document).ready(function() {
	var modif = 0;
	$("input").change( function() {
		modif = 1;
	} ) ;
	$("#repartitionPrint").click( function () {
		if (modif == 1 ) {
			alert ("L'impression ne peut pas être déclenchée : des modifications ont été apportées dans le formulaire");
			return false;
		}
	} ) ;
	$(".date").datepicker( { dateFormat: "dd/mm/yy" } );
	$(".date").change( function() {
		$(this).next(".message").show().text("Veuillez enregistrer la fiche avant de poursuivre votre saisie");
	} );
	$(".num5, .num10, .num3").attr( {
		pattern: "\-?[0-9]*(\.[0-9]+)?",
		title: "Donnée numérique" 
		} );
	$(".evol").change (function () {
		/*
		* Recalcul du nouveau taux de nourrissage
		* Recuperation de la cle
		*/
		var cle = $(this).data("cle");
		var valeur = parseFloat($(this).val());
		if (isNaN(valeur)) { valeur = 0 } ;
		var origine_id = "#taux_nourrissage_precedent_" + cle;
		var origine_value = parseFloat($(origine_id).val());
		if (isNaN(origine_value)) { origine_value = 0 } ;
		var taux_id = "#taux_nourrissage_" + cle;
		//var taux_value = parseFloat($(taux_id).val());
		/*
		* Ecriture de la nouvelle valeur
		*/
		$(taux_id).val(origine_value + valeur );
		$(taux_id).trigger ("change");
	} );
	$(".taux").change ( function () {
		/*
		* Recalcul de la quantite 
		*/
		var cle = $(this).data("cle");
		var valeur = parseFloat($(this).val());
		if (isNaN(valeur)) { valeur = 0 } ;
		var masse_id = "#distribution_masse_" + cle;
		var masse = parseFloat($(masse_id).val());
		if (isNaN(masse)) masse = 0 ;
		var ration_id = "#total_distribue_" + cle ;
		$(ration_id).val ( parseInt(masse * valeur / 100));
	} );
	$(".masse").change( function () {
		/*
		* Recalcul de la quantite
		*/
		var cle = $(this).data("cle");
		var masse = parseFloat($(this).val());
		if (isNaN(masse)) masse = 0;
		var taux_id = "#taux_nourrissage_" + cle ;
		var valeur = parseFloat($(taux_id).val ()) ;
		if (isNaN(valeur)) valeur = 0 ;
		var ration_id = "#total_distribue_" + cle ;
		$(ration_id).val ( parseInt(masse * valeur / 100));
	} );
	$(".calcul").on("click keyup", function () {
		/*
		* Recalcul de la masse dans le bassin
		*/
		var cle = $(this).data("cle");
		var masse_id = "#distribution_masse_" + cle;
		var url = "index.php?module=bassinCalculMasseAjax";
		$.getJSON ( url, { "bassin_id": cle } , function( data ) {
			$(masse_id).val(data[0].val);
			$(masse_id).trigger("change");
		} );
	} );
	/*
	$(".reste_zone_calcul").change(function () {
		/*
		* Calcul du reste à partir des données saisies dans la zone de calcul
		*/
		/*
		var zone = $(this).val();
		var valeur_table = zone.split("+");
		var reste = 0;
		for(var i= 0; i < valeur_table.length; i++)
		{
		    var reste_val = parseInt(valeur_table[i]);
		    if (isNaN(reste_val)) reste_val = 0;
			reste = reste + reste_val;
		}
		var cle = $(this).data("cle");
		var reste_id = "#reste_precedent_" + cle;
		$(reste_id).val(reste);
	} );*/
	$( "#repartitionForm" ).submit(function() {
		/*
		* Verification que le modele de distribution est renseigne si ration > 0
		*/
		var valid=true;
		$(".ration").each(function () { 
			var ration = $(this).val() ;
			if (isNaN(ration)) ration = 0 ;
			if (ration > 0 ) {
				/*
				* On teste que le modele de repartition a bien ete renseigne
				*/
				var cle = $(this).data("cle");
				var modele_id = "#repart_template_id_" + cle;
				var modele_val = $(modele_id).val() ;
				if (isNaN(modele_val)) modele_val = 0;
				if (modele_val == 0 ) {
					valid = false ;
					$(modele_id).next(".erreur").show().text("Le modèle de répartition doit être renseigné");
				} else {
					$(modele_id).next(".erreur").hide();
				}
			} 
		} );
		if (valid == false) alert ("Une ou plusieurs anomalies ont été détectées : vérifiez votre saisie (anomalies marquées en rouge)");
	return valid;
	} );
	/*
	* Gestion de l'affichage
	*/
	var afficher = $.cookie("repartitionFormAfficher");
	if (isNaN(afficher)) afficher = 1;
	if (afficher == 1) {
		$("#afficher").text("Masquer tous les éléments");
	} else {
		$("#afficher").text("Afficher tous les éléments");
		$ ("fieldset > .masquage").hide("");
	}
	
	$ (".fsMasquable legend").click(function() {
		if ($(this).nextAll(".masquage") .is (":visible") == true ) {
			$(this).nextAll(".masquage").hide("10");
		} else {
			$(this).nextAll(".masquage").show ("10");
		}
	} );
	$("#afficher").click(function() {
		if (afficher == 0) {
			$( this ).text("Masquer tous les éléments") ;
			afficher = 1 ;
			$ ("fieldset > .masquage").show("");
		} else {
			$ (this ).text ("Afficher tous les éléments") ;
			afficher = 0;
			$ ("fieldset > .masquage").hide("");
		}
		$.cookie("repartitionFormAfficher", afficher);
	} );
} ) ;
</script>
<h2>{t}Modification d'une répartion{/t}</h2>
<a href="index.php?module=repartitionList">{t}Retour à la liste{/t}</a>
<a href="index.php?module=repartitionPrint&repartition_id={$data.repartition_id}" id="repartitionPrint">Imprimer la répartition</a>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="repartitionForm" method="post" action="index.php?module=repartitionWrite">
<input type="hidden" name="repartition_id" value="{$data.repartition_id}">

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Catégorie d'alimentation :{/t}<span class="red">*</span></label> 
<div class="col-md-8">
<select id="" class="form-control" name="categorie_id" id="categorie_id" {if $data.repartition_id > 0}disabled{/if}>
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $data.categorie_id == $categorie[lst].categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>

</div>
</div>
<div class="form-group"><label for="" class="control-label col-md-4">{t}Nom :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="commentaire" name="repartition_name" value="{$data.repartition_name}" placeholder="Élevage, repro...">
</div>
 <div class="form-group">
 <label for="" class="control-label col-md-4">{t}Date début :{/t}</label>
 <div class="col-md-8">
<input id="" class="form-control" class="date" name="date_debut_periode" value="{$data.date_debut_periode}"><span class="message"></span>
 </div>
 <div class="form-group">
 <label for="" class="control-label col-md-4">{t}Date fin :{/t}</label>
 <div class="col-md-8">
<input id="" class="form-control" class="date" name="date_fin_periode" value="{$data.date_fin_periode}"><span class="message"></span>
 </div>
<fieldset>
<legend>{t}Répartition des aliments par bassin{/t}</legend>
<div id="afficher" class="masquageText"><i>Afficher tous les éléments</i></div>
{section name=lst loop=$dataBassin}
<input type="hidden" name="distribution_id_{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].distribution_id}">
<input type="hidden" name="bassin_id_{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].bassin_id}">
<fieldset class="fsMasquable">
<legend>{t}{$dataBassin[lst].bassin_nom}{/t}</legend>
<div class="masquage">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Modèle de distribution utilisé :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<select id="" class="form-control" name="repart_template_id_{$dataBassin[lst].bassin_id}" id="repart_template_id_{$dataBassin[lst].bassin_id}">
<option value="0" {if $dataBassin[lst].repart_template_id == 0}selected{/if}>Sélectionnez le modèle...</option>
{section name=lst1 loop=$dataTemplate}
<option value="{$dataTemplate[lst1].repart_template_id}" {if $dataTemplate[lst1].repart_template_id == $dataBassin[lst].repart_template_id}selected{/if}>
{$dataTemplate[lst1].repart_template_libelle}
</option>
{/section}
</select>
<div class="erreur"></div>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Masse (poids) des poissons dans le bassin (en grammes) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="num10 masse" name="distribution_masse_{$dataBassin[lst].bassin_id}" id="distribution_masse_{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].distribution_masse}" data-cle="{$dataBassin[lst].bassin_id}">
<input type="button" class="calcul" data-cle="{$dataBassin[lst].bassin_id}" value="Recalcul...">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nourrissage des jours précédents (même nbre de jours) :{/t}</label>
<dd>
Taux :
<input name="taux_nourrissage_precedent_{$dataBassin[lst].bassin_id}" id="taux_nourrissage_precedent_{$dataBassin[lst].bassin_id}" data-cle="{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].taux_nourrissage_precedent}" class="num5" readonly>
Qté : 
<input class="num5" name="total_distrib_precedent_{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].total_distrib_precedent}" readonly>
(global : 
<input class="num5" name="total_distrib_precedent_{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].total_periode_distrib_precedent}" readonly>
)
<br>Reste :
<input class="num5" name="reste_precedent_{$dataBassin[lst].bassin_id}" id="reste_precedent_{$dataBassin[lst].bassin_id}" data-cle="{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].reste_precedent}" readonly>
% reste : 
<input class="num5" name="taux_reste_precedent_{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].taux_reste_precedent}" readonly>
<br>
<input name="ration_commentaire_precedent_{$dataBassin[lst].bassin_id}" id="ration_commentaire_precedent_{$dataBassin[lst].bassin_id}" data-cle="{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].ration_commentaire_precedent}" size="30" readonly>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Taux de nourrissage :{/t}</label>
<dd>
Évolution :
<input class="num5 evol" name="evol_taux_nourrissage_{$dataBassin[lst].bassin_id}" id="evol_taux_nourrissage_{$dataBassin[lst].bassin_id}"  data-cle="{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].evol_taux_nourrissage}">
Nouveau taux :
<input class="num5 taux" name="taux_nourrissage_{$dataBassin[lst].bassin_id}" id="taux_nourrissage_{$dataBassin[lst].bassin_id}"  data-cle="{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].taux_nourrissage}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Ration distribuée :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="num10 ration" name="total_distribue_{$dataBassin[lst].bassin_id}" id="total_distribue_{$dataBassin[lst].bassin_id}" data-cle="{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].total_distribue}">
<br>
<input name="distribution_consigne_{$dataBassin[lst].bassin_id}" id="distribution_consigne_{$dataBassin[lst].bassin_id}"  data-cle="{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].distribution_consigne}" placeholder="Consignes..." Title="Consignes de distribution" size="30">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Jours de distribution :{/t}</label>
<dd>
lun <input type="checkbox" name="distribution_jour_1_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_1 == 1}checked{/if}>
mar <input type="checkbox" name="distribution_jour_2_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_2 == 1}checked{/if}>
mer <input type="checkbox" name="distribution_jour_3_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_3 == 1}checked{/if}>
jeu <input type="checkbox" name="distribution_jour_4_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_4 == 1}checked{/if}>
ven <input type="checkbox" name="distribution_jour_5_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_5 == 1}checked{/if}>
sam <input type="checkbox" name="distribution_jour_6_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_6 == 1}checked{/if}>
dim <input type="checkbox" name="distribution_jour_7_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_7 == 1}checked{/if}>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}1/2 ration le soir uniquement :{/t}</label>
<dd>
lun <input type="checkbox" name="distribution_jour_soir_1_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_soir_1 == 1}checked{/if}>
mar <input type="checkbox" name="distribution_jour_soir_2_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_soir_2 == 1}checked{/if}>
mer <input type="checkbox" name="distribution_jour_soir_3_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_soir_3 == 1}checked{/if}>
jeu <input type="checkbox" name="distribution_jour_soir_4_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_soir_4 == 1}checked{/if}>
ven <input type="checkbox" name="distribution_jour_soir_5_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_soir_5 == 1}checked{/if}>
sam <input type="checkbox" name="distribution_jour_soir_6_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_soir_6 == 1}checked{/if}>
dim <input type="checkbox" name="distribution_jour_soir_7_{$dataBassin[lst].bassin_id}" value="1" {if $dataBassin[lst].distribution_jour_soir_7 == 1}checked{/if}>


</div>
</div>
</fieldset>
{/section}


</fieldset>


 

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>
</div>
{if $data.repartition_id > 0 &&$droits["bassinAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="repartition_id" value="{$data.repartition_id}">
<input type="hidden" name="module" value="repartitionDelete">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>