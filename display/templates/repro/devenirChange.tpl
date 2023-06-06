{if $devenirOrigine == "lot"}
<a href="index.php?module=lotList">Retour à la liste des lots</a>&nbsp;
<a href="index.php?module=lotDisplay&lot_id={$data.lot_id}">Retour au lot</a>
{include file="repro/lotDetail.tpl"}
{else}
<a href="index.php?module=devenirList">Retour à la liste des lâchers et entrées dans le stock</a>
{/if}
<h2>{t}Saisie de la destination d'une reproduction{/t}</h2>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="devenirForm" method="post" action="index.php?module=devenir{$devenirOrigine}Write">
<input type="hidden" name="devenir_id" value="{$data.devenir_id}">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
<input type="hidden" name="devenirOrigine" value="{$devenirOrigine}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" class="date"  name="devenir_date" required value="{$data.devenir_date}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Destination parente :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="parent_devenir_id">
<option value ="" {if $data.parent_devenir_id = ""}selected{/if}>Sélectionnez...</option>
{section name=lst loop=$devenirParent}
<option value="{$devenirParent[lst].devenir_id}" {if $devenirParent[lst].devenir_id == $data.devenir_id}selected{/if}>
{$devenirParent[lst].devenir_date} {$devenirParent[lst].devenir_type_libelle} {$devenirParent[lst].categorie_libelle}
{$devenirParent[lst].localisation} {$devenirParent[lst].poisson_nombre}
</option>
{/section}
</select>
</div>

<div class="form-group"><label for="" class="control-label col-md-4">{t}Nature:{/t}<span class="red">*</span></label>
<div class="col-md-8">
<select id="" class="form-control" name="devenir_type_id">
{section name=lst loop=$devenirType}
<option value="{$devenirType[lst].devenir_type_id}" {if $devenirType[lst].devenir_type_id == $data.devenir_type_id}selected{/if}>
{$devenirType[lst].devenir_type_libelle}
</option>
{/section}
</select>

</div>

<div class="form-group"><label for="" class="control-label col-md-4">{t}Stade biologique<span class="red">*</span> :<label for="" class="control-label col-md-4">
{t}<div class="col-md-8">
<select id="" class="form-control" name="categorie_id">
{section name=lst loop=$categories}
<option value="{$categories[lst].categorie_id}" {if $categories[lst].categorie_id == $data.categorie_id}selected{/if}>
{$categories[lst].categorie_libelle}
</option>
{/section}
</select>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Lieu de lâcher :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="sortie_lieu_id">
<option value="" {if $data.sortie_lieu_id == ""}selected{/if}>
{section name=lst loop=$sorties}
<option value="{$sorties[lst].sortie_lieu_id}" {if $sorties[lst].sortie_lieu_id == $data.sortie_lieu_id}selected{/if}>
{$sorties[lst].localisation}
</option>
{/section}
</select>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nombre de poissons concernés :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="nombre" name="poisson_nombre" value="{$data.poisson_nombre}">

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
{if $data.devenir_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="devenir{$devenirOrigine}Delete">
<input type="hidden" name="devenir_id" value="{$data.devenir_id}">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
<input type="hidden" name="devenirOrigine" value="{$devenirOrigine}">
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
</div>
<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>