<script>
$(document).ready(function() {
	$(".taux").attr("pattern","[0-9]+(\.[0-9]+)?");
	$(".taux").attr("title","valeur numérique");
	$(".taux").attr("size", "5");
	$(".taux").attr("maxlength", "10");
	$(".date").datepicker( { dateFormat: "dd/mm/yy" } );
	$(".time").attr("pattern","[0-9][0-9]\:[0-9][0-9]");
	$(".time").attr("placeholder","hh:mm");
	$(".time").attr("size", "5");
	$(".commentaire").attr("size","30");
});
</script>
<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2>Modification d'une biopsie</h2>
<div class="formSaisie">
<div>
<form id="biopsieForm" method="post" action="index.php?module=biopsieWrite">
<input type="hidden" name="biopsie_id" value="{$data.biopsie_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<dl>
<dt>Date du prélèvement <span class="red">*</span> :</dt>
<dd>
<input class="date" name="biopsie_date" required size="10" maxlength="10" value="{$data.biopsie_date}">
</dd>
</dl>
<dl>
<dt>Diamètre moyen :</dt>
<dd>
<input class="taux" name="diam_moyen" value="{$data.diam_moyen}">
</dd>
</dl>
<dl>
<dt>Taux d'ovoïdes :</dt>
<dd>
<input class="taux" name="tx_ovoide" value="{$data.tx_ovoide}">
</dd>
</dl>
<dl>
<dt>Taux de coloration normale :</dt>
<dd>
<input class="taux" name="tx_coloration_normal" value="{$data.tx_coloration_normal}">
</dd>
</dl>
<fieldset>
<legend>Test Ringer</legend>
<dl>
<dt>T50 :</dt>
<dd>
<input class="time" name="ringer_t50" value="{$data.ringer_t50}">
</dd>
</dl>
<dl>
<dt>T max :</dt>
<dd>
<input class="taux" name="ringer_tx_max" value="{$data.ringer_tx_max}">
</dd>
</dl>
<dl>
<dt>Durée :</dt>
<dd>
<input class="time" name="ringer_duree" value="{$data.ringer_duree}">
</dd>
</dl>
<dl>
<dt>Commentaires :</dt>
<dd>
<input class="commentaire" name="ringer_commentaire" value="{$data.ringer_commentaire}">
</dd>
</dl>
</fieldset>
<fieldset>
<legend>Test Leibovitz</legend>
<dl>
<dt>T50 :</dt>
<dd>
<input class="time" name="leibovitz_t50" value="{$data.leibovitz_t50}">
</dd>
</dl><dl>
<dt>T max :</dt>
<dd>
<input class="taux" name="leibovitz_tx_max" value="{$data.leibovitz_tx_max}">
</dd>
</dl><dl>
<dt>Durée :</dt>
<dd>
<input class="time" name="leibovitz_duree" value="{$data.tx_ovoide}">
</dd>
</dl><dl>
<dt>Commentaires :</dt>
<dd>
<input class="commentaire" name="leibovitz_commentaire" value="{$data.leibovitz_commentaire}">
</dd>
</dl>
</fieldset>
<dl>
<dt>Commentaire général :</dt>
<dd>
<input class="commentaire" name="biopsie_commentaire" value="{$data.biopsie_commentaire}">
</dd>
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.biopsie_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="biopsieDelete">
<input type="hidden" name="biopsie_id" value="{$data.biopsie_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>