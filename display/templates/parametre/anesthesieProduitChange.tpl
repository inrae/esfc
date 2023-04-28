<h2>Modification d'un produit d'anesthésie</h2>

<a href="index.php?module=anesthesieProduitList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="anesthesieProduitForm" method="post" action="index.php?module=anesthesieProduitWrite">
<input type="hidden" name="anesthesie_produit_id" value="{$data.anesthesie_produit_id}">
<dl>
<dt>
Nom du produit d'anesthésie <span class="red">*</span> :
</dt>
<dd>
<input name="anesthesie_produit_libelle" type="text" value="{$data.anesthesie_produit_libelle}" required autofocus/>
</dd>
</dl>
<dl>
<dt>Actif ?</dt>
<dd>
<input type="radio" id="cactif_0" name="anesthesie_produit_actif" value="1" {if $data.anesthesie_produit_actif == 1} checked{/if}>oui 
<input type="radio" id="cactif_1" name="anesthesie_produit_actif" value="0" {if $data.anesthesie_produit_actif == 0} checked{/if}>non 
</dd>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>

{if $data.anesthesie_produit_id > 0 && $droits["paramAdmin"] == 1 }
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="anesthesie_produit_id" value="{$data.anesthesie_produit_id}">
<input type="hidden" name="module" value="anesthesieProduitDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
</form>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>