<h2{t}Modification d'un métal analysé{/t}</h2>

<a href="index.php?module=metalList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="metalForm" method="post" action="index.php?module=metalWrite">
<input type="hidden" name="metal_id" value="{$data.metal_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}
Nom du métal <span class="red">*</span> :
{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="metal_nom" type="text" value="{$data.metal_nom}" required autofocus/>
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Unité utilisée pour<br>quantifier les analyses :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="metal_unite" type="text" value="{$data.metal_unite}">
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Actif ?{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" type="radio" id="cactif_0" name="metal_actif" value="1" {if $data.metal_actif == 1} checked{/if}>oui 
<input type="radio" id="cactif_1" name="metal_actif" value="0" {if $data.metal_actif == 0} checked{/if}>non 
</dd>
</div>
<div class="form-group"></div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>

{if $data.metal_id > 0 &&($droits["paramAdmin"] == 1 || $droits.bassinAdmin == 1)}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="metal_id" value="{$data.metal_id}">
<input type="hidden" name="module" value="metalDelete">
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