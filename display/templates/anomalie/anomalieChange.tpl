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
<h2>Traitement d'une anomalie</h2>
{if $module_origine == "poissonDisplay"}
<a href="index.php?module={$poissonDetailParent}">Retour à la liste des poissons</a>
>
<a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">Retour au poisson</a>
{else}
<a href="index.php?module=anomalieList">Retour à la liste des anomalies</a>
{/if}
<div class="formSaisie">
<div>
<form id="anomalieForm" method="post" action="index.php?module={if $module_origine == "poissonDisplay"}poissonAnomalieWrite{else}anomalieWrite{/if}">
<input type="hidden" name="anomalie_db_id" value="{$data.anomalie_db_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="evenement_id" value="{$data.evenement_id}">
<dl>
<dt>Date de détection de l'anomalie :</dt>
<dd>
<input type="text" class="date" name="anomalie_db_date" value="{$data.anomalie_db_date}">
</dd>
</dl>
<dl>
<dt>Type d'anomalie <span class="red">*</span> :</dt>
<dd>
<select name="anomalie_db_type_id">
{section name=lst loop=$anomalieType}
<option value="{$anomalieType[lst].anomalie_db_type_id}" {if $anomalieType[lst].anomalie_db_type_id == $data.anomalie_db_type_id}selected{/if}>
{$anomalieType[lst].anomalie_db_type_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Poisson concerné :</dt>
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
</dl>
<dl>
<dt>Commentaire :</dt>
<dd>
<input name="anomalie_db_commentaire" value="{$data.anomalie_db_commentaire}" size="40">
</dd>
</dl>
<dl>
<dt>Statut :</dt>
<dd>
<select name="anomalie_db_statut" id="anomalie_db_statut">
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
</dl>
<dl>
<dt>Date de traitement de l'anomalie :</dt>
<dd>
<input class="date" name="anomalie_db_date_traitement" id="anomalie_db_date_traitement" value="{$data.anomalie_db_date_traitement}">
</dd>
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>


{if $data.anomalie_db_id > 0 &&$droits["poissonAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="anomalie_db_id" value="{$data.anomalie_db_id}">
<input type="hidden" name="module" value="anomalieDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>