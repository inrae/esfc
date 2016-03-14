<a href="index.php?module={$poissonDetailParent}">
Retour à la liste des poissons
</a>
 > 
 <a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">
 Retour au poisson
 </a>
 {include file="poisson/poissonDetail.tpl"}
<h2>Modification/saisie d'une mesure du nombre de battements de ventilation</h2>
<div class="formSaisie">
<div>
<form id="biopsieForm" method="post" action="index.php?module=ventilationWrite" >
<input type="hidden" name="poisson_campagne_id" value="{$poisson_campagne_id}">
<input type="hidden" name="biopsie_id" value="{$data.biopsie_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<dl>
<dt>Date de la mesure <span class="red">*</span> :</dt>
<dd>
<input class="datetimepicker" name="ventilation_date" required value="{$data.ventilation_date}">
</dd>
</dl>
<dl>
<dt>Nb de battements/mn <span class="red">*</span> :</dt>
<dd>
<input class="nombre" name="ventilation_nb" value="{$data.ventilation_nb}">
</dd>
</dl>
<dl>
<dt>Commentaire :</dt>
<dd>
<input class="commentaire" name="ventilation_commentaire" value="{$data.ventilation_commentaire}">
</dd>
</dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.ventilation_id > 0 && ($droits.poissonGestion == 1 || $droits.reproGestion == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="ventilationDelete">
<input type="hidden" name="ventilation_id" value="{$data.ventilation_id}">
<input type="hidden" name="poisson_campagne_id" value="{$poisson_campagne_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span>
<span class="messagebas">Champ obligatoire</span>
