<h2>Modification d'une catégorie d'aliment</h2>

<a href="index.php?module=categorieList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form id="categorieForm" method="post" action="index.php?module=categorieWrite">
<input type="hidden" name="categorie_id" value="{$data.categorie_id}">
<dl>
<dt>Type de poisson nourri <span class="red">*</span> :</dt>
<dd><input name="categorie_libelle" size="40" value="{$data.categorie_libelle}" autofocus></dd>
</dl>

<div class="formBouton">
<br>
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.categorie_id > 0 &&$droits["paramAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="categorie_id" value="{$data.categorie_id}">
<input type="hidden" name="module" value="categorieDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>