<script>
$(document).ready(function() {
	$(".taux").attr("pattern","[0-9]+(\.[0-9]+)?");
	$(".taux").attr("title","valeur numérique");
	$(".taux").attr("size", "5");
	$(".taux").attr("maxlength", "10");
	$(".nombre").attr("pattern","[0-9]+");
	$(".nombre").attr("title","valeur numérique");
	$(".nombre").attr("size", "5");
	$(".nombre").attr("maxlength", "10");
	
	$(".date").datepicker( { dateFormat: "dd/mm/yy" } );
	$(".commentaire").attr("size","30");
} );
</script>
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
<form id="croisementForm" method="post" action="index.php?module=croisementWrite">
<input type="hidden" name="croisement_id" value="{$data.croisement_id}">
<input type="hidden" name="sequence_id" value="{$data.sequence_id}">
<dl>
<dt>Date de la reproduction <span class="red">*</span> :</dt>
<dd>
<input class="date" name="croisement_date" required size="10" maxlength="10" value="{$data.croisement_date}">
</dd>
</dl>
<dl>
<dt>Masse des ovocytes :</dt>
<dd><input class="taux" name="ovocyte_masse" value="{$data.ovocyte_masse}">
</dd>
</dl>
<dl>
<dt>Densité des ovocytes :</dt>
<dd><input class="taux" name="ovocyte_densite" value="{$data.ovocyte_densite}">
</dd>
</dl>
<dl>
<dt>Taux de fécondation :</dt>
<dd><input class="taux" name="tx_fecondation" value="{$data.tx_fecondation}">
</dd>
</dl>
<dl>
<dt>Taux de survie estimé :</dt>
<dd><input class="taux" name="tx_survie_estime" value="{$data.tx_survie_estime}">
</dd>
</dl>
<dl>
<dt>Qualité du croisement :</dt>
<dd>
<select name="croisement_qualite_id" >
<option value="" {if $data.croisement_qualite_id == ''}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$croisementQualite}
<option value="{$croisementQualite[lst].croisement_qualite_id}" {if $data.croisement_qualite_id == $croisementQualite[lst].croisement_qualite_id}selected{/if}>
{$croisementQualite[lst].croisement_qualite_libelle}
</option>
{/section}
</select>
</dl>
<dl>
<dt>Poissons utilisés pour la reproduction :</dt>
<dd>
<table>
<tr>
<th>Poisson</th>
<th>Sexe</th>
<th>Sélectionné</th>
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
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.controle_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="controleDelete">
<input type="hidden" name="controle_id" value="{$data.controle_id}">
<input type="hidden" name="sequence_id" value="{$data.sequence_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>