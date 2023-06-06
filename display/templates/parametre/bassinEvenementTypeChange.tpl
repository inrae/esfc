<h2>{t}Modification d'un type d'événement survenant dans les bassins{/t}</h2>

<a href="index.php?module=bassinEvenementTypeList">{t}Retour à la liste{/t}</a>


<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="bassinEvenementTypeForm" method="post" action="index.php?module=bassinEvenementTypeWrite">
<input type="hidden" name="bassin_evenement_type_id" value="{$data.bassin_evenement_type_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Type d'événement :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" name="bassin_evenement_type_libelle" size="40" value="{$data.bassin_evenement_type_libelle}" autofocus>
</div>


<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>
</div>

{if $data.bassin_evenement_type_id > 0 &&$droits["paramAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="bassin_evenement_type_id" value="{$data.bassin_evenement_type_id}">
<input type="hidden" name="module" value="bassinEvenementTypeDelete">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>