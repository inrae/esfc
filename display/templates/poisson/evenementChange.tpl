 <script>
 
$(document).ready(function() { 
$( "#cevenement_date" ).datepicker( { dateFormat: "dd/mm/yy" } );
$( "#evenementForm" ).submit(function() {
	valid=true;
	var bd = $("#bassin_destination").val();
	var bo = $("#bassin_origine").val();
	if (bd > 0 && bd == bo) {
		valid = false;
		$("#bassin_destination").css("border_color", "red");
		 $("#bassin_destination").next(".erreur").show().text("Le bassin de destination ne peut être égal au bassin d'origine");
	} else {
		$("#bassin_destination").css("border_color", "initial");
		$("#bassin_destination").next(".erreur").hide();
	};
	return valid;
}
		);
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
<table class="tablesaisie">
<form class="cmxform" id="evenementForm" method="post" action="index.php?module=evenementWrite">
<input type="hidden" name="evenement_id" value="{$data.evenement_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="morphologie_id" value="{$dataMorpho.morphologie_id}">
<input type="hidden" name="pathologie_id" value="{$dataPatho.pathologie_id}">
<input type="hidden" name="gender_selection_id" value="{$dataGender.gender_selection_id}">
<input type="hidden" name="transfert_id" value="{$dataTransfert.transfert_id}">


<tr>
<td colspan="2" class="datamodif">
<h3>Données liées à l'événement lui-même</h3>
</td>
</tr>
<tr>
<td class="libelleSaisie">
Type d'événement <span class="red">*</span> :</td>
<td class="datamodif">
<select name="evenement_type_id">
{section name=lst loop=$evntType}
<option value="{$evntType[lst].evenement_type_id}" {if $evntType[lst].evenement_type_id == $data.evenement_type_id}selected{/if}>
{$evntType[lst].evenement_type_libelle}
</option>
{/section}
</select>
</td>
</tr>
<tr>
<td class="libelleSaisie">Date <span class="red">*</span> :</td>
<td class="datamodif">

<input name="evenement_date" id="cevenement_date" required size="10" maxlength="10" value="{$data.evenement_date}">
</td>
</tr>
<tr>
<td colspan="2" class="datamodif">
<h3>Données morphologiques</h3>
</td>
</tr>
<tr>
<td class="libelleSaisie">Longueur à la fourche :</td>
<td class="datamodif">
<input name="longueur_fourche" id="clongueur_fourche" value="{$dataMorpho.longueur_fourche}" size="10" maxlength="10">
</td>
</tr>
<tr>
<td class="libelleSaisie">Longueur totale :</td>
<td class="datamodif">
<input name="longueur_totale" id="clongueur_totale" value="{$dataMorpho.longueur_totale}" size="10" maxlength="10">
</td>
</tr>
<tr>
<td class="libelleSaisie">Masse :</td>
<td class="datamodif">
<input name="masse" id="cmasse" value="{$dataMorpho.masse}" size="10" maxlength="10">
</td>
</tr>
<tr>
<td class="libelleSaisie">Commentaire :</td>
<td class="datamodif">
<input name="morphologie_commentaire" id="cmorphologie_commentaire" value="{$dataMorpho.morphologie_commentaire}" size="40">
</td>
</tr>
<tr>
<td colspan="2" class="datamodif">
<h3>Pathologie</h3>
</td>
</tr>
<tr>
<td class="libelleSaisie">Type de pathologie <span class="red">*</span> :</td>
<td class="datamodif">
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
</td>
</tr>
<tr>
<td class="libelleSaisie">Commentaire :</td>
<td class="datamodif">
<input name="pathologie_commentaire" id="cpathologie_commentaire" value="{$dataPatho.pathologie_commentaire}" size="40">
</td>
</tr>

<tr>
<td colspan="2" class="datamodif">
<h3>Détermination du sexe</h3>
</td>
</tr>
<tr>
<td class="libelleSaisie">Méthode utilisée :</td>
<td class="datamodif">
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
</td>
</tr>
<tr>
<td class="libelleSaisie">Sexe déterminé <span class="red">*</span> :</td>
<td class="datamodif">
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
</td>
</tr>
<tr>
<td class="libelleSaisie">Commentaire :</td>
<td class="datamodif">
<input name="gender_selection_commentaire" id="cgender_selection_commentaire" value="{$dataGender.gender_selection_commentaire}" size="40">
</td>
</tr>

<tr>
<td colspan="2" class="datamodif">
<h3>Changement de bassin</h3>
</td>
</tr>
<tr>
<td class="libelleSaisie">Bassin d'origine <span class="red">*</span> : </td>
<td>
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
</td>
</tr>
<tr>
<td class="libelleSaisie">Bassin de destination <span class="red">*</span> : </td>
<td>
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
</td>
</tr>

<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
</form>

{if $data.evenement_id > 0 &&$droits["admin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="evenement_id" value="{$data.evenement_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="module" value="evenementDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>