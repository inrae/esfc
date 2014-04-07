 <script>
 
$(document).ready(function() { 
	/*
	* Affichage ou masquage des différentes zones
	*/
	var afficher = $.cookie("evenementChangeAfficher");
	if (isNaN(afficher)) afficher = 1;
	if (afficher == 1) {
		$("#afficher").text("Masquer tous les éléments");
	} else {
		$("#afficher").text("Afficher tous les éléments");
		$ ("fieldset > .masquage").hide("");
	}
	$ ("fieldset legend").click(function() {
		if ($(this).nextAll(".masquage") .is (":visible") == true ) {
			$(this).nextAll(".masquage").hide("10");
			$(this).next( ".icone").attr("src", "display/images/arrow_down.png");
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
		$.cookie("evenementChangeAfficher", afficher);
	} );
$( "#cevenement_date" ).datepicker( { dateFormat: "dd/mm/yy" } );
$( "#bassin_origine").change( function() {
	/*
	* On verifie si le dernier bassin connu correspond à celui indiqué
	* l'anomalie est positionnée à 1 (valeur de la table anomalie_db_type) en cas d'erreur
	*/
	var db = $("#dernier_bassin_connu").val();
	var bo = $("#bassin_origine").val();
	if (db > 0 && bo != db && bo > 0 ) {
		$( this ).next(".erreur").show().text( "Le bassin d'origine indiqué ne correspond pas au dernier bassin connu dans la base (" + 
				$( "#dernier_bassin_connu_libelle").val() + ")");
		$( "#anomalie_flag" ).val("1");
		$( "#anomalie_db_commentaire").val("Dernier bassin connu : " + $( "#dernier_bassin_connu_libelle").val());
	} else {
		$( this ).next(".erreur").hide();
		$( "#anomalie_flag" ).val("0");
	}
} ) ;
$( "#evenementForm" ).submit(function() {
	valid=true;
	var bd = $("#bassin_destination").val();
	var bo = $("#bassin_origine").val();
	if (bd > 0 && bd == bo) {
		valid = false;
		$("#bassin_destination").next(".erreur").show().text("Le bassin de destination ne peut être égal au bassin d'origine");
	} else {
		$("#bassin_destination").css("border_color", "initial");
		$("#bassin_destination").next(".erreur").hide();
	};
	return valid;
	} );
 } );
</script>
<a href="index.php?module=poissonList">
Retour à la liste des poissons
</a>
 > 
 <a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">
 Retour au poisson
 </a>
 {include file="poisson/poissonDetail.tpl"}
<h2>Modification d'un événément</h2>
<div class="formSaisie">
<div>
<form id="evenementForm" method="post" action="index.php?module=evenementWrite">
<input type="hidden" name="evenement_id" value="{$data.evenement_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="morphologie_id" value="{$dataMorpho.morphologie_id}">
<input type="hidden" name="pathologie_id" value="{$dataPatho.pathologie_id}">
<input type="hidden" name="gender_selection_id" value="{$dataGender.gender_selection_id}">
<input type="hidden" name="transfert_id" value="{$dataTransfert.transfert_id}">
<input type="hidden" name="dernier_bassin_connu" id="dernier_bassin_connu" value="{$dataTransfert.dernier_bassin_connu}">
<input type="hidden" name="dernier_bassin_connu_libelle" id="dernier_bassin_connu_libelle" value="{$dataTransfert.dernier_bassin_connu_libelle}">
<input type="hidden" name="anomalie_flag" id="anomalie_flag" value="0">
<input type="hidden" name="anomalie_db_commentaire" id="anomalie_db_commentaire" value="">
<input type="hidden" name="mortalite_id" id="mortalite_id" value="{$dataMortalite.mortalite_id}" >
<input type="hidden" name="cohorte_id" id="cohorte_id" value="{$dataCohorte.cohorte_id}" >

<fieldset>
<legend>Données liées à l'événement lui-même</legend>
<dl>
<dt>
Type d'événement <span class="red">*</span> :</dt>
<dd>
<select name="evenement_type_id">
{section name=lst loop=$evntType}
<option value="{$evntType[lst].evenement_type_id}" {if $evntType[lst].evenement_type_id == $data.evenement_type_id}selected{/if}>
{$evntType[lst].evenement_type_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Date <span class="red">*</span> :</dt>
<dd>
<input class="date" name="evenement_date" id="cevenement_date" required size="10" maxlength="10" value="{$data.evenement_date}">
</dd>
</dl>
</fieldset>

<div id="afficher" class="masquageText">Afficher tous les éléments</div>

<fieldset class="fsMasquable">
<legend>Données morphologiques</legend>
<div class="masquage">
<dl>
<dt>Longueur à la fourche :</dt>
<dd>
<input name="longueur_fourche" id="clongueur_fourche" value="{$dataMorpho.longueur_fourche}" size="10" maxlength="10" title="Valeur numérique" pattern="[0-9]+(\.[0-9]+)?">
</dd>
</dl>
<dl>
<dt>Longueur totale :</dt>
<dd>
<input name="longueur_totale" id="clongueur_totale" value="{$dataMorpho.longueur_totale}" size="10" maxlength="10" title="Valeur numérique" pattern="[0-9]+(\.[0-9]+)?">
</dd>
</dl>
<dl>
<dt>Masse :</dt>
<dd>
<input name="masse" id="cmasse" value="{$dataMorpho.masse}" size="10" maxlength="10" title="Valeur numérique" pattern="[0-9]+(\.[0-9]+)?">
</dd>
</dl>
<dl>
<dt>Commentaire :</dt>
<dd>
<input name="morphologie_commentaire" id="cmorphologie_commentaire" value="{$dataMorpho.morphologie_commentaire}" size="40">
</dd>
</dl>
</div>
</fieldset>

<fieldset class="fsMasquable">
<legend>Pathologie</legend>
<div class="masquage">
<dl>
<dt>Type de pathologie <span class="red">*</span> :</dt>
<dd>
<select name="pathologie_type_id">
<option value="" {if $dataPatho.pathologie_type_id == ""}selected{/if}>
Sélectionnez la pathologie...
</option>
{section name=lst loop=$pathoType}
<option value="{$pathoType[lst].pathologie_type_id}" {if $pathoType[lst].pathologie_type_id == $dataPatho.pathologie_type_id}selected{/if}>
{$pathoType[lst].pathologie_type_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Valeur numérique associée :</dt>
<dd>
<input name="pathologie_valeur" id="cpathologie_valeur" value="{$dataPatho.pathologie_valeur}" title="Valeur numérique" size="10" pattern="[0-9]+(\.[0-9]+)?">
</dd>
</dl>
<dl>
<dt>Commentaire :</dt>
<dd>
<input name="pathologie_commentaire" id="cpathologie_commentaire" value="{$dataPatho.pathologie_commentaire}" size="40">
</dd>
</dl>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>Changement de bassin</legend>
<div class="masquage">
<dl>
<dt>Bassin d'origine <span class="red">*</span> : </dt>
<dd>
<select name="bassin_origine" id="bassin_origine">
<option value="" {if $dataTransfert.bassin_origine == ""} selected {/if}>
Sélectionnez le bassin d'origine...
</option>
{section name=lst loop=$bassinList}
<option value="{$bassinList[lst].bassin_id}" {if $bassinList[lst].bassin_id == $dataTransfert.bassin_origine} selected {/if}>
{$bassinList[lst].bassin_nom}
</option>
{/section}
</select>
<span class="erreur"></span>
</dd>
</dl>
<dl>
<dt>Bassin de destination <span class="red">*</span> : </dt>
<dd>
<select name="bassin_destination" id="bassin_destination">
<option value="" {if $dataTransfert.bassin_destination == ""} selected {/if}>
Sélectionnez le bassin de destination...
</option>
{section name=lst loop=$bassinListActif}
<option value="{$bassinListActif[lst].bassin_id}" {if $bassinListActif[lst].bassin_id == $dataTransfert.bassin_destination} selected {/if}>
{$bassinListActif[lst].bassin_nom}
</option>
{/section}
</select>
<span class="erreur"style="display:none; color:red;"></span>
</dd>
</dl>
</div>
</fieldset>
<fieldset class="fsMasquable">
<legend>Détermination du sexe</legend>
<div class="masquage">
<dl>

<dt>Méthode utilisée :</dt>
<dd>
<select name="gender_methode_id">
<option value="" {if $dataGender.gender_methode_id == ""}selected{/if}>
Sélectionnez la méthode...
</option>
{section name=lst loop=$genderMethode}
<option value="{$genderMethode[lst].gender_methode_id}" {if $genderMethode[lst].gender_methode_id == $dataGender.gender_methode_id}selected{/if}>
{$genderMethode[lst].gender_methode_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Sexe déterminé <span class="red">*</span> :</dt>
<dd>
<select name="sexe_id" >
<option value="" {if $dataGender.sexe_id == ""}selected{/if}>
Sélectionnez le sexe...
</option>
{section name=lst loop=$sexe}
<option value="{$sexe[lst].sexe_id}" {if $sexe[lst].sexe_id == $dataGender.sexe_id}selected{/if}>
{$sexe[lst].sexe_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Commentaire :</dt>
<dd>
<input name="gender_selection_commentaire" id="cgender_selection_commentaire" value="{$dataGender.gender_selection_commentaire}" size="40">
</dd>
</dl>
</div>
</fieldset>

<fieldset class="fsMasquable">
<legend>Détermination de la cohorte</legend>
<div class="masquage">
<dl>
<dt>Type de détermination <span class="red">*</span> : </dt>
<dd>
<select name="cohorte_type_id" id="cohorte_type_id">
<option value="" {if $dataCohorte.cohorte_type_id == ""} selected {/if}>
Sélectionnez le type de détermination...
</option>
{section name=lst loop=$cohorteType}
<option value="{$cohorteType[lst].cohorte_type_id}" {if $cohorteType[lst].cohorte_type_id == $dataCohorte.cohorte_type_id} selected {/if}>
{$cohorteType[lst].cohorte_type_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Détermination effectuée :</dt>
<dd><input name="cohorte_determination" value="{$dataCohorte.cohorte_determination}"></dd>
</dl>
<dl>
<dt>Commentaire : </dt>
<dd>
<input name="cohorte_commentaire" value="{$dataCohorte.cohorte_commentaire}" size="40">
</dd>
</dl>
</div>
</fieldset>

<fieldset class="fsMasquable">
<legend>Mortalité</legend>
<div class="masquage">
<dl>
<dt>Type de mortalité <span class="red">*</span> : </dt>
<dd>
<select name="mortalite_type_id" id="mortalite_type_id">
<option value="" {if $dataMortalite.mortalite_type_id == ""} selected {/if}>
Sélectionnez le type de mortalité...
</option>
{section name=lst loop=$mortaliteType}
<option value="{$mortaliteType[lst].mortalite_type_id}" {if $mortaliteType[lst].mortalite_type_id == $dataMortalite.mortalite_type_id} selected {/if}>
{$mortaliteType[lst].mortalite_type_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Commentaire : </dt>
<dd>
<input name="mortalite_commentaire" value="{$dataMortalite.mortalite_commentaire}" size="40">
</dd>
</dl>
</div>
</fieldset>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>


{if $data.evenement_id > 0 &&$droits["admin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="evenement_id" value="{$data.evenement_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="module" value="evenementDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>
{if $data.evenement_id > 0}

<h3>Documents associés</h3>
{include file="document/documentList.tpl"}
{/if}