<a href="index.php?module=circuitEauList">Retour à la liste des circuits d'eau</a>
> <a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data.circuit_eau_id}">Retour au circuit d'eau</a>
<h2>Modification d'un événement survenu dans le circuit d'eau {$dataCircuit.circuit_eau_libelle}</h2>
<div class="formSaisie">
<div>
<form id="circuitEvenementForm" method="post" action="index.php?module=circuitEvenementWrite">
<input type="hidden" name="circuit_evenement_id" value="{$data.circuit_evenement_id}">
<input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
<dl>
<dt>Type d'événement <span class="red">*</span> :</dt>
<dd>
<select name="circuit_evenement_type_id">
{section name=lst loop=$dataEvntType}
<option value="{$dataEvntType[lst].circuit_evenement_type_id}" {if $dataEvntType[lst].circuit_evenement_type_id == $data.circuit_evenement_type_id}selected{/if}>
{$dataEvntType[lst].circuit_evenement_type_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Date <span class="red">*</span> :</dt>
<dd><input class="date" name="circuit_evenement_date" value="{$data.circuit_evenement_date}"></dd>
</dl>
<dl>
<dt>Commentaires :</dt>
<dd>
<input name="circuit_evenement_commentaire" value="{$data.circuit_evenement_commentaire}" style="size:40;">
</dd>
</dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.circuit_evenement_id > 0 &&$droits["bassinAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="circuit_evenement_id" value="{$data.circuit_evenement_id}">
<input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
<input type="hidden" name="module" value="circuitEvenementDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>