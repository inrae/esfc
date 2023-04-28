<script>
$(document).ready(function() { 
	$(".date").datepicker({ dateFormat: "dd/mm/yy" });
} ) ;
</script>
<a href="index.php?module={$bassinParentModule}">Retour à la liste des bassins</a>
> <a href="index.php?module=bassinDisplay&bassin_id={$data.bassin_id}">Retour au bassin</a>
{include file="bassin/bassinDetail.tpl"}
<h2>Modification d'un événement survenu dans le bassin</h2>
<div class="formSaisie">
<div>
<form id="bassinEvenementForm" method="post" action="index.php?module=bassinEvenementWrite">
<input type="hidden" name="bassin_evenement_id" value="{$data.bassin_evenement_id}">
<input type="hidden" name="bassin_id" value="{$data.bassin_id}">
<dl>
<dt>Type d'événement <span class="red">*</span> :</dt>
<dd>
<select name="bassin_evenement_type_id">
{section name=lst loop=$dataEvntType}
<option value="{$dataEvntType[lst].bassin_evenement_type_id}" {if $dataEvntType[lst].bassin_evenement_type_id == $data.bassin_evenement_type_id}selected{/if}>
{$dataEvntType[lst].bassin_evenement_type_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Date <span class="red">*</span> :</dt>
<dd><input class="date" name="bassin_evenement_date" value="{$data.bassin_evenement_date}"></dd>
</dl>
<dl>
<dt>Commentaires :</dt>
<dd>
<input name="bassin_evenement_commentaire" value="{$data.bassin_evenement_commentaire}" style="size:40;">
</dd>
</dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.bassin_evenement_id > 0 &&$droits["bassinAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="bassin_evenement_id" value="{$data.bassin_evenement_id}">
<input type="hidden" name="bassin_id" value="{$data.bassin_id}">
<input type="hidden" name="module" value="bassinEvenementDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>