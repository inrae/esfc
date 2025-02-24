<h2>{t}Modification d'un site{/t}</h2>

<a href="index.php?module=siteList">Retour à la liste des sites</a>


<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="site" method="post" action="index.php?module=siteWrite">
<input type="hidden" name="site_id" value="{$data.site_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">
{t}Nom du site :{/t}<span class="red">*</span>
</label>
<div class="col-md-8">
<input id="" class="form-control" name="site_name" type="text" value="{$data.site_name}" required autofocus/>

</div>
</div>
<div class="form-group"></div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>

{if $data.site_id > 0 &&($droits["paramAdmin"] == 1)}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="site_id" value="{$data.site_id}">
<input type="hidden" name="module" value="siteDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>