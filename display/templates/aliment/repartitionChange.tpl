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
	$(".num5, .num10").attr( {
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
<h2>Modification d'une répartion</h2>
<a href="index.php?module=repartitionList">Retour à la liste</a>
<a href="index.php?module=repartitionPrint&repartition_id={$data.repartition_id}" id="repartitionPrint">Imprimer la répartition</a>
<div class="formSaisie">
<div>
<form id="repartitionForm" method="post" action="index.php?module=repartitionWrite">
<input type="hidden" name="repartition_id" value="{$data.repartition_id}">
<dl>
<dt>Catégorie d'alimentation <span class="red">*</span> :</dt> 
<dd>
<select name="categorie_id" id="categorie_id" {if $data.repartition_id > 0}disabled{/if}>
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $data.categorie_id == $categorie[lst].categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>
</dd>
</dl>
 <dl>
 <dt>Date début :</dt>
 <dd><input class="date" name="date_debut_periode" value="{$data.date_debut_periode}"></dd>
 </dl>
 <dl>
 <dt>Date fin :</dt>
 <dd><input class="date" name="date_fin_periode" value="{$data.date_fin_periode}"></dd>
 </dl>
 <fieldset>
 <legend>Jours de distribution</legend>
lun : <input type="checkbox" name="lundi" value="1" {if $data.lundi == 1}checked{/if}>
mar : <input type="checkbox" name="mardi" value="1" {if $data.mardi == 1}checked{/if}>
mer : <input type="checkbox" name="mercredi" value="1" {if $data.mercredi == 1}checked{/if}>
jeu : <input type="checkbox" name="jeudi" value="1" {if $data.jeudi == 1}checked{/if}>
ven : <input type="checkbox" name="vendredi" value="1" {if $data.vendredi == 1}checked{/if}>
sam : <input type="checkbox" name="samedi" value="1" {if $data.samedi == 1}checked{/if}>
dim : <input type="checkbox" name="dimanche" value="1" {if $data.dimanche == 1}checked{/if}>
 </fieldset>
<fieldset>
<legend>Répartition des aliments par bassin</legend>
<div id="afficher" class="masquageText"><i>Afficher tous les éléments</i></div>
{section name=lst loop=$dataBassin}
<input type="hidden" name="distribution_id_{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].distribution_id}">
<input type="hidden" name="bassin_id_{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].bassin_id}">
<fieldset class="fsMasquable">
<legend>{$dataBassin[lst].bassin_nom}</legend>
<div class="masquage">
<dl>
<dt>Modèle de distribution utilisé <span class="red">*</span> :</dt>
<dd>
<select name="repart_template_id_{$dataBassin[lst].bassin_id}" id="repart_template_id_{$dataBassin[lst].bassin_id}">
<option value="0" {if $dataBassin[lst].repart_template_id == 0}selected{/if}>Sélectionnez le modèle...</option>
{section name=lst1 loop=$dataTemplate}
<option value="{$dataTemplate[lst1].repart_template_id}" {if $dataTemplate[lst1].repart_template_id == $dataBassin[lst].repart_template_id}selected{/if}>
{$dataTemplate[lst1].repart_template_libelle}
</option>
{/section}
</select>
<div class="erreur"></div>
</dd>
</dl>
<dl>
<dt>Masse (poids) des poissons dans le bassin (en grammes) :</dt>
<dd>
<input class="num10 masse" name="distribution_masse_{$dataBassin[lst].bassin_id}" id="distribution_masse_{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].distribution_masse}" data-cle="{$dataBassin[lst].bassin_id}">
<input type="button" class="calcul" data-cle="{$dataBassin[lst].bassin_id}" value="Recalcul...">
</dd>
</dl>
<dl>
<dt>Nourrissage précédent :</dt>
<dd>
Taux :
<input name="taux_nourrissage_precedent_{$dataBassin[lst].bassin_id}" id="taux_nourrissage_precedent_{$dataBassin[lst].bassin_id}" data-cle="{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].taux_nourrissage_precedent}" class="num5" readonly>
Reste :
<input class="num5" name="reste_precedent_{$dataBassin[lst].bassin_id}" id="reste_precedent_{$dataBassin[lst].bassin_id}" data-cle="{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].reste_precedent}">
<br>
<input name="ration_commentaire_{$dataBassin[lst].bassin_id}" id="ration_commentaire_{$dataBassin[lst].bassin_id}" data-cle="{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].ration_commentaire}" size="30" placeholder="Commentaires..." title="Commentaires concernant le reste">
</dd>
</dl>
<dl>
<dt>Taux de nourrissage :</dt>
<dd>
Évolution :
<input class="num5 evol" name="evol_taux_nourrissage_{$dataBassin[lst].bassin_id}" id="evol_taux_nourrissage_{$dataBassin[lst].bassin_id}"  data-cle="{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].evol_taux_nourrissage}">
Nouveau taux :
<input class="num5 taux" name="taux_nourrissage_{$dataBassin[lst].bassin_id}" id="taux_nourrissage_{$dataBassin[lst].bassin_id}"  data-cle="{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].taux_nourrissage}">
</dd>
</dl>
<dl>
<dt>Ration distribuée :</dt>
<dd>
<input class="num10 ration" name="total_distribue_{$dataBassin[lst].bassin_id}" id="total_distribue_{$dataBassin[lst].bassin_id}" data-cle="{$dataBassin[lst].bassin_id}" value="{$dataBassin[lst].total_distribue}">
<br>
<input name="distribution_consigne_{$dataBassin[lst].bassin_id}" id="distribution_consigne_{$dataBassin[lst].bassin_id}"  data-cle="{$dataBassin[lst].bassin_id}" value="{$dataPoisson[lst].distribution_consigne}" placeholder="Consignes..." Title="Consignes de distribution" size="30">
</dd>
</dl>
</div>
</fieldset>
{/section}


</fieldset>


 
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>
{if $data.repartition_id > 0 &&$droits["bassinAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="repartition_id" value="{$data.repartition_id}">
<input type="hidden" name="module" value="repartitionDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>