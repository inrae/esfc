<script>
$(document).ready(function() {
$( "#ccapture_date" ).datepicker( { dateFormat: "dd/mm/yy" } );
$("#cpittag_date_pose").datepicker( { dateFormat: "dd/mm/yy" } );
$("#cdate_naissance").datepicker( { dateFormat: "dd/mm/yy" } );

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
 <h2>Modification d'un poisson</h2>
<table class="tablesaisie">
<form id="poissonForm" method="post" action="index.php?module=poissonWrite">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="sexe_id" value="{$data.sexe_id}">
<tr>
<td class="libelleSaisie">
Statut <span class="red">*</span> :</td>
<td class="datamodif">
<select id="cpoisson_statut_id" name="poisson_statut_id">
{section name=lst loop=$poissonStatut}
<option value="{$poissonStatut[lst].poisson_statut_id}" {if $poissonStatut[lst].poisson_statut_id == $data.poisson_statut_id}selected{/if}>
{$poissonStatut[lst].poisson_statut_libelle}
</option>
{/section}
</select>
</td>
</tr>
<tr>
<td class="libelleSaisie">
Catégorie <span class="red">*</span> :</td>
<td class="datamodif">
<select id="ccategorie_id" name="categorie_id" >
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $categorie[lst].categorie_id == $data.categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>
</tr>
<tr>
<td class="libelleSaisie">
Sexe :</td>
<td class="datamodif">
<select id="csexe_id" name="sexe_id" disabled>
{section name=lst loop=$sexe}
<option value="{$sexe[lst].sexe_id}" {if $sexe[lst].sexe_id == $data.sexe_id}selected{/if}>
{$sexe[lst].sexe_libelle}
</option>
{/section}
</select>
<input type="hidden" name=sexe_id" value="{$data.sexe_id}">
</td>
</tr>
<tr>
<td class="libelleSaisie">
Pittag <span class="red">*</span> : 
</td>
<td class="datamodif">
<input name="pittag_id" type="hidden" value="{$dataPittag.pittag_id}">
<input type="text" name="pittag_valeur" id="cpittag_valeur" size="20" value="{$dataPittag.pittag_valeur}" pattern="(([A-F0-9][A-F0-9])*|[0-9]*)" placeholder="01AB2C ou 12345" title="Nombre hexadécimal ou numérique" autofocus>
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
<input name="pittag_date_pose" id="cpittag_date_pose" size="10" maxlength="10" value="{$dataPittag.pittag_date_pose}" title="Date de pose de la marque" placeholder="jj/mm/aaaa">
</td>
</tr>

<tr>
<td class="libelleSaisie">
Matricule :
</td>
<td class="datamodif">
<input name="matricule" id="cmatricule" value="{$data.matricule}" size="30">
</td>
</tr>
<tr>
<td class="libelleSaisie">
Prénom :
</td>
<td class="datamodif">
<input name="prenom" id="cprenom" value="{$data.prenom}"  size="30">
</td>
</tr>
<td class="libelleSaisie">
Cohorte :
</td>
<td class="datamodif">
<input name="cohorte" id="ccohorte" value="{$data.cohorte}" size="10">
</td>
</tr>
<tr>
<td class="libelleSaisie">Date de capture :</td>
<td class="datamodif">
<input name="capture_date" id="ccapture_date" size="10" maxlength="10" value="{$data.capture_date}" placeholder="jj/mm/aaaa">
</td>
</tr>
<tr>
<td class="libelleSaisie">Date de naissance :</td>
<td class="datamodif">
<input name="date_naissance" id="cdate_naissance" size="10" maxlength="10" value="{$data.date_naissance}" placeholder="jj/mm/aaaa">
</td>
</tr>
<tr>
<td class="libelleSaisie">Commentaire :</td>
<td class="datamodif">
<input name="commentaire" id="ccommentaire" size="50" value="{$data.commentaire}">
</td>
<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
</form>


{if $data.poisson_id > 0 &&$droits["poissonAdmin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="module" value="poissonDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>