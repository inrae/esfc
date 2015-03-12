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
<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2>Modification d'une échographie</h2>
<div class="formSaisie">
<div>
<form id="echographieForm" method="post" action="index.php?module=echographieWrite">
<input type="hidden" name="echographie_id" value="{$data.echographie_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<dl>
<dt>Date de l'échographie <span class="red">*</span> :</dt>
<dd>
<input class="date" name="echographie_date" required size="10" maxlength="10" value="{$data.echographie_date}">
</dd>
</dl>
<dl>
<dt>Commentaires :</dt>
<dd>
<input class="commentaire" name="echographie_commentaire" value="{$data.echographie_commentaire}">
</dd>
</dl>
<dl>
<dt>Nombre de clichés :</dt>
<dd>
<input class="nombre" name="cliche_nb" value="{$data.cliche_nb}">
</dd>
</dl>
<dl>
<dt>Référence des clichés :</dt>
<dd>
<input class="commentaire" name="cliche_ref" value="{$data.cliche_ref}">
</dd>
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.echographie_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="echographieDelete">
<input type="hidden" name="echographie_id" value="{$data.echographie_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>

<h3>Photos associées</h3>
{include file="document/documentList.tpl"}