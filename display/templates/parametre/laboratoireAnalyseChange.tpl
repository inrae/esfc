<h2>Modification d'un laboratoire d'analyse</h2>

<a href="index.php?module=laboratoireAnalyseList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form id="laboratoireAnalyseForm" method="post" action="index.php?module=laboratoireAnalyseWrite">
<input type="hidden" name="laboratoire_analyse_id" value="{$data.laboratoire_analyse_id}">
<dl>
<dt>Nom du laboratoire <span class="red">*</span> :</dt>
<dd><input name="laboratoire_analyse_libelle" value="{$data.laboratoire_analyse_libelle}" size="40" autofocus required></dd>
</dl>
<dl>
<dt>Sollicité actuellement ?</dt>
<dd>
<input type="radio" name="laboratoire_analyse_actif" value="1" {if $data.laboratoire_analyse_actif == 1}checked{/if}>oui
<input type="radio" name="laboratoire_analyse_actif" value="0" {if $data.laboratoire_analyse_actif == 0}checked{/if}>non
</dd>
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.laboratoire_analyse_id > 0 &&$droits["paramAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="laboratoire_analyse_id" value="{$data.laboratoire_analyse_id}">
<input type="hidden" name="module" value="laboratoireAnalyseDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>