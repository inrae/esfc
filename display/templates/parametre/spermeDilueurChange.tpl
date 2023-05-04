<h2{t}Modification d'un dilueur de sperme{/t}</h2>

<a href="index.php?module=spermeDilueurList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="dilueurForm" method="post" action="index.php?module=spermeDilueurWrite">
<input type="hidden" name="sperme_dilueur_id" value="{$data.sperme_dilueur_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}
Nom du dilueur <span class="red">*</span> :
{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="sperme_dilueur_libelle" type="text" value="{$data.sperme_dilueur_libelle}" required autofocus/>
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

{if $data.sperme_dilueur_id > 0 &&($droits["paramAdmin"] == 1 || $droits.reproAdmin == 1)}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="sperme_dilueur_id" value="{$data.sperme_dilueur_id}">
<input type="hidden" name="module" value="spermeDilueurDelete">
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