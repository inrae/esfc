<h2>{t}Modification de l'endroit d'implantation d'une marque VIE{/t}</h2>

<a href="index.php?module=vieImplantationList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="vieImplantationForm" method="post" action="index.php?module=vieImplantationWrite">
<input type="hidden" name="vie_implantation_id" value="{$data.vie_implantation_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}
Nom de l'endroit d'implantation <span class="red">*</span> :
{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="vie_implantation_libelle" type="text" value="{$data.vie_implantation_libelle}" required autofocus/>

</div>
</div>
<div class="form-group"></div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>

{if $data.vie_implantation_id > 0 &&($droits["paramAdmin"] == 1 || $droits.reproAdmin == 1)}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="vie_implantation_id" value="{$data.vie_implantation_id}">
<input type="hidden" name="module" value="vieImplantationDelete">
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