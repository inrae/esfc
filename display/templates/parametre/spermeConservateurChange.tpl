<h2{t}Modification d'un conservateur de sperme{/t}</h2>

<a href="index.php?module=spermeConservateurList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="conservateurForm" method="post" action="index.php?module=spermeConservateurWrite">
<input type="hidden" name="sperme_conservateur_id" value="{$data.sperme_conservateur_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}
Nom du conservateur <span class="red">*</span> :
{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="sperme_conservateur_libelle" type="text" value="{$data.sperme_conservateur_libelle}" required autofocus/>
</dd>
</div>
<div class="form-group">
<div class="form-group"></div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>

{if $data.sperme_conservateur_id > 0 &&($droits["paramAdmin"] == 1 || $droits.reproAdmin == 1)}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="sperme_conservateur_id" value="{$data.sperme_conservateur_id}">
<input type="hidden" name="module" value="spermeConservateurDelete">
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