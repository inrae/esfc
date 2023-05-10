<h2{t}Modification d'une caractéristique du sperme{/t}</h2>

<a href="index.php?module=spermeCaracteristiqueList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="caracteristiqueForm" method="post" action="index.php?module=spermeCaracteristiqueWrite">
<input type="hidden" name="sperme_caracteristique_id" value="{$data.sperme_caracteristique_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}
Nom de la caractéristique <span class="red">*</span> :
{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="sperme_caracteristique_libelle" type="text" value="{$data.sperme_caracteristique_libelle}" required autofocus/>
</dd>
</div>
</div>
<div class="form-group"></div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>

{if $data.sperme_caracteristique_id > 0 &&($droits["paramAdmin"] == 1 || $droits.reproAdmin == 1)}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="sperme_caracteristique_id" value="{$data.sperme_caracteristique_id}">
<input type="hidden" name="module" value="spermeCaracteristiqueDelete">
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