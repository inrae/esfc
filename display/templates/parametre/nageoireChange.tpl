<h2>Modification d'une nageoire (prélèvements génétiques)</h2>

<a href="index.php?module=nageoireList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="caracteristiqueForm" method="post" action="index.php?module=nageoireWrite">
<input type="hidden" name="nageoire_id" value="{$data.nageoire_id}">
<dl>
<dt>
Nom de la nageoire <span class="red">*</span> :
</dt>
<dd>
<input name="nageoire_libelle" type="text" value="{$data.nageoire_libelle}" required autofocus/>
</dd>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>

{if $data.nageoire_id > 0 &&($droits["paramAdmin"] == 1)}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="nageoire_id" value="{$data.nageoire_id}">
<input type="hidden" name="module" value="nageoireDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
</form>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>