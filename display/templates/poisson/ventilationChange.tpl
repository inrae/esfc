<a href="index.php?module={$poissonDetailParent}">
Retour à la liste des poissons
</a>
 > 
 {if isset($poisson_campagne_id)}
 <a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$poisson_campagne_id}">
 {else}
 <a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">
 {/if}
 Retour au poisson
 </a>
 {include file="poisson/poissonDetail.tpl"}
<h2>{t}Modification/saisie d'une mesure du nombre de battements de ventilation{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="biopsieForm" method="post" action="index.php?module={if isset($poisson_campagne_id)}ventilationCampagneWrite{else}ventilationWrite{/if}" >
<input type="hidden" name="poisson_campagne_id" value="{$poisson_campagne_id}">
<input type="hidden" name="biopsie_id" value="{$data.biopsie_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="ventilation_id" value="{$data.ventilation_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de la mesure :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" class="datetimepicker" name="ventilation_date" required value="{$data.ventilation_date}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nb de battements/seconde :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="battement_nb" value="{$data.battement_nb}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Commentaire :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="commentaire" name="ventilation_commentaire" value="{$data.ventilation_commentaire}">

</div>


<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.ventilation_id > 0 && ($droits.poissonGestion == 1 || $droits.reproGestion == 1)}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="{if isset($poisson_campagne_id)}ventilationCampagneDelete{else}ventilationDelete{/if}">
<input type="hidden" name="ventilation_id" value="{$data.ventilation_id}">
<input type="hidden" name="poisson_campagne_id" value="{$poisson_campagne_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
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
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
