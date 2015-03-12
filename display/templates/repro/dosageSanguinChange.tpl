<script>
$(document).ready(function() {
	$(".taux").attr("pattern","[0-9]+(\.[0-9]+)?");
	$(".taux").attr("title","valeur numérique");
	$(".taux").attr("size", "10");
	$(".taux").attr("maxlength", "10");
	$( ".date" ).datepicker( { dateFormat: "dd/mm/yy" } );
});
</script>
<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2>Modification d'un dosage sanguin</h2>
<div class="formSaisie">
<div>
<form id="dosageSanguinForm" method="post" action="index.php?module=dosageSanguinWrite">
<input type="hidden" name="dosage_sanguin_id" value="{$data.dosage_sanguin_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<fieldset>
<legend>Dosage sanguin</legend>
<dl>
<dt>Date du prélèvement <span class="red">*</span> :</dt>
<dd>
<input class="date" name="dosage_sanguin_date" required size="10" maxlength="10" value="{$data.dosage_sanguin_date}">
</dd>
</dl>
<dl>
<dt>Taux E2 :</dt>
<dd>
<input class="taux" name="tx_e2" value="{$data.tx_e2}">
</dd>
</dl>
<dl>
<dt>Taux E2 (forme textuelle) :</dt>
<dd>
<input name="tx_e2_texte" size="20" value="{$data.tx_e2_texte}">
</dd>
</dl>
<dl>
<dt>Taux de calcium :</dt>
<dd>
<input class="taux" name="tx_calcium" value="{$data.tx_calcium}">
</dd>
</dl>
<dl>
<dt>Commentaires :</dt>
<dd>
<input name="dosage_sanguin_commentaire" size="30" value="{$data.dosage_sanguin_commentaire}">
</dl>
</fieldset>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.dosage_sanguin_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="dosageSanguinDelete">
<input type="hidden" name="dosage_sanguin_id" value="{$data.dosage_sanguin_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>