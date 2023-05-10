<h2{t}Modification d'un stade de maturation d'un œuf{/t}</h2>

<a href="index.php?module=stadeOeufList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="caracteristiqueForm" method="post" action="index.php?module=stadeOeufWrite">
<input type="hidden" name="stade_oeuf_id" value="{$data.stade_oeuf_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}
Nom du stade de maturation de l'œuf <span class="red">*</span> :
{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="stade_oeuf_libelle"  value="{$data.stade_oeuf_libelle}" required autofocus/>
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

{if $data.stade_oeuf_id > 0 &&($droits["paramAdmin"] == 1)}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="stade_oeuf_id" value="{$data.stade_oeuf_id}">
<input type="hidden" name="module" value="stadeOeufDelete">
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