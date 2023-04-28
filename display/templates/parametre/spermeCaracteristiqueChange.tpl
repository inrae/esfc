<h2>Modification d'une caractéristique du sperme</h2>

<a href="index.php?module=spermeCaracteristiqueList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="caracteristiqueForm" method="post" action="index.php?module=spermeCaracteristiqueWrite">
<input type="hidden" name="sperme_caracteristique_id" value="{$data.sperme_caracteristique_id}">
<dl>
<dt>
Nom de la caractéristique <span class="red">*</span> :
</dt>
<dd>
<input name="sperme_caracteristique_libelle" type="text" value="{$data.sperme_caracteristique_libelle}" required autofocus/>
</dd>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>

{if $data.sperme_caracteristique_id > 0 &&($droits["paramAdmin"] == 1 || $droits.reproAdmin == 1)}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="sperme_caracteristique_id" value="{$data.sperme_caracteristique_id}">
<input type="hidden" name="module" value="spermeCaracteristiqueDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
</form>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>