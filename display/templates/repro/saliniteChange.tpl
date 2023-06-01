<a href="index.php?module={$bassinParentModule}">Retour à la liste des bassins</a>
> <a href="index.php?module=bassinCampagneDisplay&bassin_campagne_id={$data.bassin_campagne_id}">Retour au bassin</a>
{include file="bassin/bassinDetail.tpl"}
<h2>{t}profil thermique du bassin{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="saliniteForm" method="post" action="index.php?module=saliniteWrite">
<input type="hidden" name="salinite_id" value="{$data.salinite_id}">
<input type="hidden" name="bassin_campagne_id" value="{$data.bassin_campagne_id}">
<input type="hidden" name="bassin_id" value="{$dataBassin.bassin_id}">
<input type="hidden" name="circuit_eau_id" value="{$dataBassin.circuit_eau_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date/heure :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" class="datetimepicker" name="salinite_datetime" required value="{$data.salinite_datetime}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Taux de salinité :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="salinite_tx" required value="{$data.salinite_tx}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Type :{/t}</label>
<dd>prévu 
<input type="radio" {if $data.profil_thermique_type_id == 2 || $data.profil_thermique_type_id == ""}checked{/if} name="profil_thermique_type_id" value="2">
&nbsp;constaté
<input type="radio" disabled {if $data.profil_thermique_type_id == 1}checked{/if} name="profil_thermique_type_id" value="1">

</div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.salinite_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="saliniteDelete">
<input type="hidden" name="salinite_id" value="{$data.salinite_id}">
<input type="hidden" name="bassin_campagne_id" value="{$data.bassin_campagne_id}">
<input type="hidden" name="bassin_id" value="{$dataBassin.bassin_id}">
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
<br>

<a href="index.php?module=saliniteNew&bassin_campagne_id={$data.bassin_campagne_id}">
Nouvelle donnée...
</a>
<br>

{include file="repro/saliniteList.tpl"}