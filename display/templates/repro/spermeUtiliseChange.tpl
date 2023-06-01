<script>
/*
 * mise a jour de sperme_id et sperme_congelation_id en fonction de la saisie effectuee
 */
 $(document).ready(function() { 
	 function setSpermeId() {
		 var tab = $("#sperme_select").val();
		 var atab = tab.split(":");
		 $("#sperme_id").val(atab[0]);
		 $("#sperme_congelation_id").val(atab[1]);
		 console.log("sperme_id:"+atab[0]);
		 console.log("sperme_congelation_id:"+atab[1]);
	 }
	 $("#sperme_select").change(function () {
		 setSpermeId();
	 });
	 /*
	  * lancement a l'ouverture de la page
	  */
	  setSpermeId();
 });
</script>

<a href="index.php?module=sequenceList">
Retour à la liste des séquences
</a>
&nbsp;
<a href="index.php?module=sequenceDisplay&sequence_id={$croisementData.sequence_id}">
Retour à la séquence&nbsp;
</a>
<a href="index.php?module=croisementDisplay&croisement_id={$croisementData.croisement_id}">
&nbsp;Retour au croisement {$croisementData.parents}</a>
{include file="repro/sequenceDetail.tpl"}
<h2>{t}Modification du sperme utilisé pour le croisement{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="spermeUtiliseForm" method="post" action="index.php?module=spermeUtiliseWrite">
<input type="hidden" name="sperme_utilise_id" value="{$data.sperme_utilise_id}">
<input type="hidden" name="croisement_id" value="{$data.croisement_id}">
<input type="hidden" id="sperme_id" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" id="sperme_congelation_id" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Sperme:{/t}<span class="red">*</span></label>
<div class="col-md-8">
<select id="" class="form-control" id="sperme_select" name="sperme_select">
{section name=lst loop=$spermes}
<option value="{$spermes[lst].sperme_id}:{$spermes[lst].sperme_congelation_id}" {if $spermes[lst].sperme_id == $data.sperme_id}selected{/if}>
{$spermes[lst].matricule} {$spermes[lst].prenom} - {$spermes[lst].sperme_date}
{if strlen($spermes[lst].congelation_date) > 0}
&nbsp;- congelé le {$spermes[lst].congelation_date} ({$spermes[lst].nb_paillette} paillettes)
{/if}
</option>
{/section}
</select>
 
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Volume utilisé (ml) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="volume_utilise" value="{$data.volume_utilise}">
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nbre de paillettes utilisées :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="nombre" name="nb_paillette_croisement" value="{$data.nb_paillette_croisement}">
</div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.sperme_utilise_id > 0 && $droits["reproGestion"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="spermeUtiliseDelete">
<input type="hidden" name="sperme_utilise_id" value="{$data.sperme_utilise_id}">
<input type="hidden" name="croisement_id" value="{$data.croisement_id}">
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