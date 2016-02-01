{if $devenirOrigine == "lot"}
<a href="index.php?module=lotList">Retour à la liste des lots</a>&nbsp;
<a href="index.php?module=lotDisplay&lot_id={$data.lot_id}">Retour au lot</a>
{include file="repro/lotDetail.tpl"}
{else}
<a href="index.php?module=devenirList">Retour à la liste des lâchers et entrées dans le stock</a>
{/if}
<h2>Saisie du devenir d'une reproduction</h2>
<div class="formSaisie">
<div>
<form id="devenirForm" method="post" action="index.php?module=devenir{$devenirOrigine}Write">
<input type="hidden" name="devenir_id" value="{$data.devenir_id}">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
<input type="hidden" name="devenirOrigine" value="{$devenirOrigine}">
<dl>
<dt>Date <span class="red">*</span> :</dt>
<dd>
<input class="date"  name="devenir_date" required value="{$data.devenir_date}">
</dd>
</dl>
<dl><dt>Nature<span class="red">*</span> :</dt>
<dd>
<select name="devenir_type_id">
{section name=lst loop=$devenirType}
<option value="{$devenirType[lst].devenir_type_id}" {if $devenirType[lst].devenir_type_id == $data.devenir_type_id}selected{/if}>
{$devenirType[lst].devenir_type_libelle}
</option>
{/section}
</select>
</dd>
</dl>

<dl><dt>Stade biologique<span class="red">*</span> :<dt>
<dd>
<select name="categorie_id">
{section name=lst loop=$categories}
<option value="{$categories[lst].categorie_id}" {if $categories[lst].categorie_id == $data.categorie_id}selected{/if}>
{$categories[lst].categorie_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Lieu de lâcher :</dt>
<dd>
<select name="sortie_lieu_id">
<option value="" {if $data.sortie_lieu_id == ""}selected{/if}>
{section name=lst loop=$sorties}
<option value="{$sorties[lst].sortie_lieu_id}" {if $sorties[lst].sortie_lieu_id == $data.sortie_lieu_id}selected{/if}>
{$sorties[lst].localisation}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Nombre de poissons concernés :</dt>
<dd>
<input class="nombre" name="poisson_nombre" value="{$data.poisson_nombre}">
</dd>
</dl>
<dl></dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.devenir_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="devenir{$devenirOrigine}Delete">
<input type="hidden" name="devenir_id" value="{$data.devenir_id}">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
<input type="hidden" name="devenirOrigine" value="{$devenirOrigine}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>