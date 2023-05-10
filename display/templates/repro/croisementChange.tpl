<a href="index.php?module=sequenceList">
Retour à la liste des séquences
</a>
&nbsp;
<a href="index.php?module=sequenceDisplay&sequence_id={$data.sequence_id}">
Retour à la séquence
</a>
{include file="repro/sequenceDetail.tpl"}
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="croisementForm" method="post" action="index.php?module=croisementWrite">
<input type="hidden" name="croisement_id" value="{$data.croisement_id}">
<input type="hidden" name="sequence_id" value="{$data.sequence_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date/heure de la fécondation <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="datetimepicker" name="croisement_date" required value="{$data.croisement_date}">
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nom du croisement <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="croisement_nom" value={$data.croisement_nom}>
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Masse des ovocytes (en grammes) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="ovocyte_masse" value="{$data.ovocyte_masse}">
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nbre ovocytes par gramme :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="ovocyte_densite" value="{$data.ovocyte_densite}">
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Taux de fécondation :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="tx_fecondation" value="{$data.tx_fecondation}">
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Taux de survie estimé :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="tx_survie_estime" value="{$data.tx_survie_estime}">
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Qualité génétique du croisement :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="croisement_qualite_id" >
<option value="" {if $data.croisement_qualite_id == ''}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$croisementQualite}
<option value="{$croisementQualite[lst].croisement_qualite_id}" {if $data.croisement_qualite_id == $croisementQualite[lst].croisement_qualite_id}selected{/if}>
{$croisementQualite[lst].croisement_qualite_libelle}
</option>
{/section}
</select>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Poissons utilisés pour la reproduction :{/t}</label>
<dd>
<table>
<tr>
<th>{t}Poisson{/t}<th>
<th>{t}Sexe{/t}<th>
<th>{t}Sélectionné{/t}<th>
</tr>
{section name=lst loop=$poissonSequence}
<tr>
<td>{$poissonSequence[lst].matricule} {$poissonSequence[lst].prenom} {$poissonSequence[lst].pittag_valeur}</td>
<td class="center">{$poissonSequence[lst].sexe_libelle_court}</td>
<td class="center">
<input name="poisson_campagne_id[]" type="checkbox" value="{$poissonSequence[lst].poisson_campagne_id}" {if $poissonSequence[lst].selected == 1}checked{/if}>
</td>
</tr>
{/section}
</table>
</dd>
</div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.croisement_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="croisementDelete">
<input type="hidden" name="croisement_id" value="{$data.croisement_id}">
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