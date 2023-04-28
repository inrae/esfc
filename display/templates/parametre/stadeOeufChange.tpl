<h2>Modification d'un stade de maturation d'un œuf</h2>

<a href="index.php?module=stadeOeufList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="caracteristiqueForm" method="post" action="index.php?module=stadeOeufWrite">
<input type="hidden" name="stade_oeuf_id" value="{$data.stade_oeuf_id}">
<dl>
<dt>
Nom du stade de maturation de l'œuf <span class="red">*</span> :
</dt>
<dd>
<input name="stade_oeuf_libelle"  value="{$data.stade_oeuf_libelle}" required autofocus/>
</dd>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>

{if $data.stade_oeuf_id > 0 &&($droits["paramAdmin"] == 1)}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="stade_oeuf_id" value="{$data.stade_oeuf_id}">
<input type="hidden" name="module" value="stadeOeufDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
</form>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>