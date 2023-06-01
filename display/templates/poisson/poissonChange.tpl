<script>
$(document).ready(function() {
$(".date").datepicker( { dateFormat: "dd/mm/yy" } );

$( "#poissonForm" ).submit(function() {
	var valid = true;
	var prenom_l = $("#cprenom").val().length;
	var matricule_l = $("#cmatricule").val().length;
	var pittag_l = $("#cpittag_valeur").val().length;
	if ( prenom_l == 0 && matricule_l == 0 && pittag_l == 0) {
	$("#cpittag_valeur").next(".erreur").show().text("Le pittag doit être renseigné, à défaut le matricule ou le prénom pour les anciens poissons");
	valid = false;
	} else {
		$("#cpittag_valeur").next(".erreur").hide();
	} ;
	return valid;
	} ) ;
	$("#cpittag_valeur").change(function () {
		var pittag = $("#cpittag_valeur").val();
		if (pittag.length > 0 && $("#cmatricule").val().length == 0) {
			$("#cmatricule").val(pittag);
		}
		
	});
 } );
</script>
<a href="index.php?module=poissonList">
Retour à la liste des poissons
</a>
{if $data.poisson_id > 0}
 > 
 <a href="index.php?module=poissonDisplay&poisson_id={$data.poisson_id}">
 Retour au poisson
 </a>
 {/if}
 <h2>{t}Modification d'un poisson{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="poissonForm" method="post" action="index.php?module=poissonWrite">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="sexe_id" value="{$data.sexe_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Statut :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<select id="" class="form-control" id="cpoisson_statut_id" name="poisson_statut_id">
{section name=lst loop=$poissonStatut}
<option value="{$poissonStatut[lst].poisson_statut_id}" {if $poissonStatut[lst].poisson_statut_id == $data.poisson_statut_id}selected{/if}>
{$poissonStatut[lst].poisson_statut_libelle}
</option>
{/section}
</select>

</div>

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Catégorie :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<select id="" class="form-control" id="ccategorie_id" name="categorie_id" >
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $categorie[lst].categorie_id == $data.categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>

</div>

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Sexe :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" id="csexe_id" name="sexe_id" disabled>
{section name=lst loop=$sexe}
<option value="{$sexe[lst].sexe_id}" {if $sexe[lst].sexe_id == $data.sexe_id}selected{/if}>
{$sexe[lst].sexe_libelle}
</option>
{/section}
</select>
<input type="hidden" name=sexe_id" value="{$data.sexe_id}">

</div>
<fieldset>
<legend>{t}Pittag{/t}</legend>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Numéro de pittag <span class="red">*</span> : {/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="pittag_id" type="hidden" value="{$dataPittag.pittag_id}">
<input type="text" name="pittag_valeur" id="cpittag_valeur" size="20" value="{$dataPittag.pittag_valeur}" pattern="(([A-F0-9][A-F0-9])*|[0-9]*)" placeholder="01AB2C ou 12345" title="Nombre hexadécimal ou numérique" autofocus>


</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Type de marque :{/t}</label>
<dd>
<span class="erreur" ></span>
<select name="pittag_type_id">
<option value="" {if $pittagType.pittag_type_id == ""}selected{/if}>
Sélectionnez le type de marque...
</option>
{section name=lst loop=$pittagType}
<option value="{$pittagType[lst].pittag_type_id}" {if $pittagType[lst].pittag_type_id == $dataPittag.pittag_type_id}selected{/if}>
{$pittagType[lst].pittag_type_libelle}
</option>
{/section}
</select>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de pose :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="pittag_date_pose" class="date" id="cpittag_date_pose" value="{$dataPittag.pittag_date_pose}" title="Date de pose de la marque" >

</div>

</fieldset>

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Matricule:{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" name="matricule" id="cmatricule" value="{$data.matricule}" size="30" required>

</div>

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Prénom :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="prenom" id="cprenom" value="{$data.prenom}"  size="30">

</div>

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Cohorte :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="cohorte" id="ccohorte" value="{$data.cohorte}" size="10">

</div>

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de capture :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="capture_date" id="ccapture_date" class="date" value="{$data.capture_date}" >

</div>

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de naissance :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="date_naissance" id="cdate_naissance" class="date" value="{$data.date_naissance}" >

</div>

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Commentaire :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="commentaire" id="ccommentaire" class="commentaire" value="{$data.commentaire}">

</div>
<fieldset><legend>{t}Marquage VIE au stade juvénile - lot{/t}</legend>
<label>La sélection du modèle de marquage VIE entraîne une mise
à jour automatique de la date de naissance, de la cohorte et des parents
à partir des données de reproduction</label>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Modèle de marque :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="vie_modele_id" title="Pour générer automatiquement les parents...">
<option value="" {if $data.vie_modele_id == ""}selected{/if}>
Sélectionnez pour générer les parents...
</option>
{section name=lst loop=$modeles}
<option value="{$modeles[lst].vie_modele_id}" {if $data.vie_modele_id == $modeles[lst].vie_modele_id}selected{/if}>
{$modeles[lst].annee} - {$modeles[lst].couleur}, {$modeles[lst].vie_implantation_libelle}, {$modeles[lst].vie_implantation_libelle2}
</option>
{/section}
</select>

</div>
</fieldset>

<div class="form-group"></div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>


{if $data.poisson_id > 0 &&$droits["poissonAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="module" value="poissonDelete">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>
{/if}
</div>
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>