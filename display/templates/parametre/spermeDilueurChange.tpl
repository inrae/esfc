<h2>Modification d'un dilueur de sperme</h2>

<a href="index.php?module=spermeDilueurList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="dilueurForm" method="post" action="index.php?module=spermeDilueurWrite">
<input type="hidden" name="sperme_dilueur_id" value="{$data.sperme_dilueur_id}">
<dl>
<dt>
Nom du dilueur <span class="red">*</span> :
</dt>
<dd>
<input name="sperme_dilueur_libelle" type="text" value="{$data.sperme_dilueur_libelle}" required autofocus/>
</dd>
</dl>
<dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>

{if $data.sperme_dilueur_id > 0 &&($droits["paramAdmin"] == 1 || $droits.reproAdmin == 1)}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="sperme_dilueur_id" value="{$data.sperme_dilueur_id}">
<input type="hidden" name="module" value="spermeDilueurDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
</form>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>