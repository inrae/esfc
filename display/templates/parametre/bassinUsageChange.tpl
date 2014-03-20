<h2>Modification d'un type d'utilisation des bassins</h2>

<a href="index.php?module=bassinUsageList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="bassinUsageForm" method="post" action="index.php?module=bassinUsageWrite">
<input type="hidden" name="bassin_usage_id" value="{$data.bassin_usage_id}">
<dl>
<dt>
Utilisation <span class="red">*</span> :
</dt>
<dd>
<input id="cbassin_usage_libelle" name="bassin_usage_libelle" type="text" value="{$data.bassin_usage_libelle}" required autofocus/>
</dd>
</dl>
<dl>
<dt>Catégorie d'alimentation :</dt>
<dd>
<select name="categorie_id">
<option value="" {if $data.categorie_id == ""}selected{/if}>
Sélectionnez la catégorie...
</option>
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $categorie[lst].categorie_id == $data.categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>

{if $data.bassin_usage_id > 0 &&$droits["paramAdmin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="bassin_usage_id" value="{$data.bassin_usage_id}">
<input type="hidden" name="module" value="bassinUsageDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
</form>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>