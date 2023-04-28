<h2>Modification de l'endroit d'implantation d'une marque VIE</h2>

<a href="index.php?module=vieImplantationList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="vieImplantationForm" method="post" action="index.php?module=vieImplantationWrite">
<input type="hidden" name="vie_implantation_id" value="{$data.vie_implantation_id}">
<dl>
<dt>
Nom de l'endroit d'implantation <span class="red">*</span> :
</dt>
<dd>
<input name="vie_implantation_libelle" type="text" value="{$data.vie_implantation_libelle}" required autofocus/>
</dd>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>

{if $data.vie_implantation_id > 0 &&($droits["paramAdmin"] == 1 || $droits.reproAdmin == 1)}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="vie_implantation_id" value="{$data.vie_implantation_id}">
<input type="hidden" name="module" value="vieImplantationDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
</form>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>