<script>
$(document).ready(function() {
	$(".taux").attr("pattern","[0-9]+(\.[0-9]+)?");
	$(".taux").attr("title","valeur numérique");
	$(".taux").attr("size", "5");
	$(".taux").attr("maxlength", "10");
	$(".commentaire").attr("size","30");
});
</script>
<a href="index.php?module=poissonCampagneList">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2>Données du poisson pour la séquence considérée</h2>
<div class="formSaisie">
<div>
<form id="poissonSequenceForm" method="post" action="index.php?module=poissonSequenceWrite">
<input type="hidden" name="poisson_sequence_id" value="{$data.poisson_sequence_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<dl>
<dt>Séquence de reproduction <span class="red">*</span> :</dt>
<dd>
<select name="sequence_id" >
{section name=lst loop=$sequences}
<option value="{$sequences[lst].sequence_id}" {if $sequences[lst].sequence_id == $data.sequence_id}selected{/if}>
{$sequences[lst].sequence_nom} ({$sequences[lst].sequence_date_debut})
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Qualité de la semence :</dt>
<dd>
<input class="commentaire" name="qualite_semence" value="{$data.qualite_semence}">
</dd>
</dl>
<dl>
<dt>Masse de l'ovocyte (en grammes) :</dt>
<dd>
<input class="taux" name="ovocyte_masse" value="{$data.ovocyte_masse}">
</dd>
</dl>
{if $droits.reproGestion == 1}
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
{/if}
</form>
{if $data.poisson_sequence_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="poissonSequenceDelete">
<input type="hidden" name="poisson_sequence_id" value="{$data.poisson_sequence_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>
<br>

{if $data.poisson_sequence_id > 0}
<div>
<fieldset>
<legend>Événements</legend>

{if $droits.reproGestion == 1 }
{include file="repro/psEvenementChange.tpl"}
<br>
<a href="index.php?module=psEvenementChange&ps_evenement_id=0&poisson_sequence_id={$data.poisson_sequence_id}">
Nouvel événement...
</a>
{/if}

<table id="cpsEvenement" class="tableaffichage">
<thead>
<tr>
<th>Date</th>
<th>Libellé</th>
<th>Commentaire</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$evenements}
<tr>
<td>
{if $droits.reproGestion == 1}
<a href="index.php?module=psEvenementChange&ps_evenement_id={$evenements[lst].ps_evenement_id}&poisson_sequence_id={$data.poisson_sequence_id}">
{$evenements[lst].ps_date}
</a>
{else}
{$evenements[lst].ps_date}
{/if}</td>
<td>{$evenements[lst].ps_libelle}</td>
<td>{$evenements[lst].ps_commentaire}</td>
</tr>
{/section}
</tdata>
</table>
</fieldset>
</div>
{/if}
