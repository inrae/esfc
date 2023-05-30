<h2{t}Modification d'un produit d'anesthésie{/t}</h2>

<a href="index.php?module=anesthesieProduitList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="anesthesieProduitForm" method="post" action="index.php?module=anesthesieProduitWrite">
<input type="hidden" name="anesthesie_produit_id" value="{$data.anesthesie_produit_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}
Nom du produit d'anesthésie <span class="red">*</span> :
{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="anesthesie_produit_libelle" type="text" value="{$data.anesthesie_produit_libelle}" required autofocus/>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Actif ?{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" type="radio" id="cactif_0" name="anesthesie_produit_actif" value="1" {if $data.anesthesie_produit_actif == 1} checked{/if}>oui 
<input type="radio" id="cactif_1" name="anesthesie_produit_actif" value="0" {if $data.anesthesie_produit_actif == 0} checked{/if}>non 

</div>
</div>
<div class="form-group"></div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>

{if $data.anesthesie_produit_id > 0 && $droits["paramAdmin"] == 1 }
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="anesthesie_produit_id" value="{$data.anesthesie_produit_id}">
<input type="hidden" name="module" value="anesthesieProduitDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>