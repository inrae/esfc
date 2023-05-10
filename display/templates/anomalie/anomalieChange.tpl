<script>
$(document).ready(function() { 
	$( ".date" ).datepicker( { dateFormat: "dd/mm/yy" } );
	$( "#anomalie_db_statut").change(function() { 
		var valeur=$(this).val();
		if (valeur == 1 ) {
			$ ( "#statut_img").attr("src", "display/images/ok_icon.png");
			/* Traitement de la date de resolution */
			var date_traitement = $("#anomalie_db_date_traitement").val();
			if (date_traitement.length == 0 ) {
				$("#anomalie_db_date_traitement").datepicker("setDate",new Date());
			} 
		} else {
			$ ( "#statut_img").attr("src", "display/images/warning_icon.png");
		}
	} );
} );
</script>
<h2{t}Traitement d'une anomalie{/t}</h2>
{if $module_origine == "poissonDisplay"}
<a href="index.php?module={$poissonDetailParent}">Retour à la liste des poissons</a>
>
<a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">Retour au poisson</a>
{else}
<a href="index.php?module=anomalieList">Retour à la liste des anomalies</a>
{/if}
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="anomalieForm" method="post" action="index.php?module={if $module_origine == "poissonDisplay"}poissonAnomalieWrite{else}anomalieWrite{/if}">
<input type="hidden" name="anomalie_db_id" value="{$data.anomalie_db_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="evenement_id" value="{$data.evenement_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de détection de l'anomalie :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" type="text" class="date" name="anomalie_db_date" value="{$data.anomalie_db_date}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Type d'anomalie <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="anomalie_db_type_id">
{section name=lst loop=$anomalieType}
<option value="{$anomalieType[lst].anomalie_db_type_id}" {if $anomalieType[lst].anomalie_db_type_id == $data.anomalie_db_type_id}selected{/if}>
{$anomalieType[lst].anomalie_db_type_libelle}
</option>
{/section}
</select>
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Poisson concerné :{/t}</label>
<dd>
{if $data.poisson_id > 0}
<a href="index.php?module=poissonDisplay&poisson_id={$data.poisson_id}" onclick='return confirm("Vous allez quitter la saisie en cours. Confirmez-vous cette opération ?")'>
{$data.matricule}
{if strlen($data.matricule) == 0}
{$data.prenom}
{if strlen($data.prenom) == 0}
{$data.pittag_valeur}
{/if}
{/if}
</a>
{/if}
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Commentaire :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="anomalie_db_commentaire" value="{$data.anomalie_db_commentaire}" size="40">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Statut :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="anomalie_db_statut" id="anomalie_db_statut">
<option value="0" {if $data.anomalie_db_statut != 1}selected{/if}>
Anomalie non levée
</option>
<option value="1" {if $data.anomalie_db_statut == 1}selected{/if}>
Anomalie levée
</option>
</select>
{if $data.anomalie_db_statut == 1}
<img id="statut_img" src="display/images/ok_icon.png" height="20">
{else}
<img id="statut_img" src="display/images/warning_icon.png" height="20">
{/if}
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de traitement de l'anomalie :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="date" name="anomalie_db_date_traitement" id="anomalie_db_date_traitement" value="{$data.anomalie_db_date_traitement}">
</dd>
</div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>


{if $data.anomalie_db_id > 0 &&$droits["poissonAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="anomalie_db_id" value="{$data.anomalie_db_id}">
<input type="hidden" name="module" value="anomalieDelete">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>