<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}&sequence_id={$data.sequence_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2{t}Données du poisson pour la séquence considérée{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="poissonSequenceForm" method="post" action="index.php?module=poissonSequenceWrite">
<input type="hidden" name="poisson_sequence_id" value="{$data.poisson_sequence_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Séquence de reproduction <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="sequence_id" >
{section name=lst loop=$sequences}
<option value="{$sequences[lst].sequence_id}" {if $sequences[lst].sequence_id == $data.sequence_id}selected{/if}>
{$sequences[lst].site_name} - {$sequences[lst].sequence_nom} ({$sequences[lst].sequence_date_debut})
</option>
{/section}
</select>
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Statut du poisson pour la séquence :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="ps_statut_id">
{section name=lst loop=$statuts}
<option value="{$statuts[lst].ps_statut_id}" {if $statuts[lst].ps_statut_id == $data.ps_statut_id}selected{/if}>
{$statuts[lst].ps_statut_libelle}
</option>
{/section}
</select>
</dd>
</div>
</div>
<div class="form-group"></div>
{if $dataPoisson.sexe_id == 2}
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de l'expulsion<br>des ovocytes :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="date" name="ovocyte_expulsion_date"  value="{$data.ovocyte_expulsion_date}">
<input class="timepicker" name="ovocyte_expulsion_time" value="{$data.ovocyte_expulsion_time}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Masse totale des ovocytes (grammes) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="ovocyte_masse" value="{$data.ovocyte_masse}">
</dd>
</div>
{/if}
{if $dataPoisson.sexe_id == 1}
<fieldset><legend>{t}Prélèvements de sperme{/t}<legend>
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Accédez à la fiche du poisson pour réaliser la saisie
</a>
</fieldset>
{/if}

<div class="form-group"></div>
{if $droits.reproGestion == 1}

{/if}
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.poisson_sequence_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="poissonSequenceDelete">
<input type="hidden" name="poisson_sequence_id" value="{$data.poisson_sequence_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input type="hidden" name="sequence_id" value="{$data.sequence_id}">
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
<br>

{if $data.poisson_sequence_id > 0}
<div>
<fieldset>
<legend>{t}Événements{/t}<legend>

{if $droits.reproGestion == 1 }
<a href="index.php?module=psEvenementChange&ps_evenement_id=0&poisson_sequence_id={$data.poisson_sequence_id}&sequence_id={$data.sequence_id}">
Nouvel événement...
</a>
{if $ps_evenement_id > -1}
{include file="repro/psEvenementChange.tpl"}
<br>
{/if}
{/if}

<table id="cpsEvenement" class="tableaffichage">
<thead>
<tr>
<th>{t}Date{/t}</th>
<th>{t}Libellé{/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$evenements}
<tr>
<td>
{if $droits.reproGestion == 1}
<a href="index.php?module=psEvenementChange&ps_evenement_id={$evenements[lst].ps_evenement_id}&poisson_sequence_id={$data.poisson_sequence_id}&sequence_id={$data.sequence_id}">
{$evenements[lst].ps_datetime}
</a>
{else}
{$evenements[lst].ps_datetime}
{/if}</td>
<td>{$evenements[lst].ps_libelle}</td>
<td>{$evenements[lst].ps_commentaire}</td>
</tr>
{/section}
</tbody>
</table>
</fieldset>
</div>
{/if}
