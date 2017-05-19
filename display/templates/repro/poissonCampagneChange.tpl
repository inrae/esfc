<a href="index.php?module={$poissonDetailParent}">Retour à la liste des poissons</a>
&nbsp;
<a href="index.php?module={$poissonParent}&poisson_campagne_id={$data.poisson_campagne_id}&poisson_id={$data.poisson_id}">
Retour au détail du poisson
</a>
<h2>Sélectionner un poisson pour une campagne</h2>
<div class="formSaisie">
<div>
<form id="poissonCampagneForm" method="post" action="index.php?module=poissonCampagneWrite">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<dl>
<dt>Identification :</dt>
<dd>
<input name="identification" readonly value="{$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur}">
</dd>
</dl>
<dl>
<dt>Année :</dt>
<dd>
<select name="annee">
{section name=lst loop=$annees}
<option value="{$annees[lst].annee}" {if $annees[lst].annee == $data.annee}selected{/if}>
{$annees[lst].annee}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>
Statut du poisson pour la repro :
</dt>
<dd>
<select name="repro_statut_id">
{section name=lst loop=$reproStatut}
<option value="{$reproStatut[lst].repro_statut_id}" {if $reproStatut[lst].repro_statut_id == $data.repro_statut_id}selected{/if}>
{$reproStatut[lst].repro_statut_libelle}
</option>
{/section}
</select>
</dl>

<fieldset>
<legend>Indicateurs de croissance (calculés automatiquement en cas de nouvelle sélection)</legend>
<dl>
<dt>Taux de croissance journalier :</dt>
<dd>
<input class="taux" name="tx_croissance_journalier" size="10" maxlength="10" value="{$data.tx_croissance_journalier}">
</dd>
</dl>
<dl>
<dt>Taux de croissance spécifique :</dt>
<dd>
<input class="taux" name="specific_growth_rate" size="10" maxlength="10" value="{$data.specific_growth_rate}">
</dd>
</dl>
</fieldset>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.poisson_campagne_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="poissonCampagneDelete">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
