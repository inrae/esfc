<h2>Modification d'une stadeGonade (prélèvements génétiques)</h2>

<a href="index.php?module=stadeGonadeList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="caracteristiqueForm" method="post" action="index.php?module=stadeGonadeWrite">
<input type="hidden" name="stade_gonade_id" value="{$data.stade_gonade_id}">
<dl>
<dt>
Nom du stade de maturation de la gonade <span class="red">*</span> :
</dt>
<dd>
<input name="stade_gonade_libelle" type="text" value="{$data.stade_gonade_libelle}" required autofocus/>
</dd>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>

{if $data.stade_gonade_id > 0 &&($droits["paramAdmin"] == 1)}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="stade_gonade_id" value="{$data.stade_gonade_id}">
<input type="hidden" name="module" value="stadeGonadeDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
</form>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>