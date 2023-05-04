<h2{t}Modification d'une stadeGonade (prélèvements génétiques){/t}</h2>

<a href="index.php?module=stadeGonadeList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="caracteristiqueForm" method="post" action="index.php?module=stadeGonadeWrite">
<input type="hidden" name="stade_gonade_id" value="{$data.stade_gonade_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}
Nom du stade de maturation de la gonade <span class="red">*</span> :
{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="stade_gonade_libelle" type="text" value="{$data.stade_gonade_libelle}" required autofocus/>
</dd>
</div>
<div class="form-group"></div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>

{if $data.stade_gonade_id > 0 &&($droits["paramAdmin"] == 1)}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="stade_gonade_id" value="{$data.stade_gonade_id}">
<input type="hidden" name="module" value="stadeGonadeDelete">
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