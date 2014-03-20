<h2>Modification d'un aliment</h2>

<a href="index.php?module=alimentList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form id="alimentForm" method="post" action="index.php?module=alimentWrite">
<input type="hidden" name="aliment_id" value="{$data.aliment_id}">
<dl>
<dt>Nom de l'aliment <span class="red">*</span> :</dt>
<dd><input name="aliment_libelle" value="{$data.aliment_libelle}" size="40" autofocus></dd>
</dl>

<dl>
<dt>Type d'aliment <span class="red">*</span> :</dt>
<dd>
<select name="aliment_type_id">
{section name=lst loop=$alimentType}
<option value="{$alimentType[lst].aliment_type_id}" {if $alimentType[lst].aliment_type_id == $data.aliment_type_id}selected{/if}>
{$alimentType[lst].aliment_type_libelle}
</option>
{/section}
</select>
</dd>
</dl>

<dl>
<dt>Aliment actuellement utilisé ?</dt>
<dd>
<input type="radio" name="actif" value="1" {if $data.actif == 1 or $data.actif == ""}checked{/if}>oui
<input type="radio" name="actif" value="0" {if $data.actif == 0}checked{/if}>non
</dd>
</dl>

<fieldset>
<legend>Catégories de poissons nourris</legend>

<!-- gestion de la saisie des categories -->
{section name=lst loop=$categorie}
<dl>
<dt>{$categorie[lst].categorie_libelle}</dt>
<dd><input type="checkbox" name="categorie[]" value="{$categorie[lst].categorie_id}" {if $categorie[lst].checked == 1}checked{/if}>
</dd>
</dl>
{/section}
</fieldset>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.aliment_id > 0 &&$droits["bassinAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="aliment_id" value="{$data.aliment_id}">
<input type="hidden" name="module" value="alimentDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>