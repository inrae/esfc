<h2>Modification d'un conservateur de sperme</h2>

<a href="index.php?module=spermeConservateurList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="conservateurForm" method="post" action="index.php?module=spermeConservateurWrite">
<input type="hidden" name="sperme_conservateur_id" value="{$data.sperme_conservateur_id}">
<dl>
<dt>
Nom du conservateur <span class="red">*</span> :
</dt>
<dd>
<input name="sperme_conservateur_libelle" type="text" value="{$data.sperme_conservateur_libelle}" required autofocus/>
</dd>
</dl>
<dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>

{if $data.sperme_conservateur_id > 0 &&($droits["paramAdmin"] == 1 || $droits.reproAdmin == 1)}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="sperme_conservateur_id" value="{$data.sperme_conservateur_id}">
<input type="hidden" name="module" value="spermeConservateurDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
</form>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>