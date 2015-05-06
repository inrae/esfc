<h2>Modification d'un métal analysé</h2>

<a href="index.php?module=metalList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="metalForm" method="post" action="index.php?module=metalWrite">
<input type="hidden" name="metal_id" value="{$data.metal_id}">
<dl>
<dt>
Nom du métal <span class="red">*</span> :
</dt>
<dd>
<input name="metal_nom" type="text" value="{$data.metal_nom}" required autofocus/>
</dd>
</dl>
<dl>
<dt>Unité utilisée pour<br>quantifier les analyses :</dt>
<dd>
<input name="metal_unite" type="text" value="{$data.metal_unite}">
</dd>
</dl>
<dl>
<dt>Actif ?</dt>
<dd>
<input type="radio" id="cactif_0" name="metal_actif" value="1" {if $data.metal_actif == 1} checked{/if}>oui 
<input type="radio" id="cactif_1" name="metal_actif" value="0" {if $data.metal_actif == 0} checked{/if}>non 
</dd>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>

{if $data.metal_id > 0 &&($droits["paramAdmin"] == 1 || $droits.bassinAdmin == 1)}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="metal_id" value="{$data.metal_id}">
<input type="hidden" name="module" value="metalDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
</form>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>