<h2>Modification d'un modèle de marquage VIE</h2>
<div class="formSaisie">
<div>
<form id="vieModeleForm" method="post" action="index.php?module=vieModeleWrite">
<input type="hidden" name="vie_modele_id" value="{$data.vie_modele_id}">
<input type="hidden" name="annee" value="{$data.annee}">
<dl>
<dt>Couleur de la marque <span class="red">*</span> :</dt>
<dd>
<input name="couleur" class="commentaire" autofocus required value={$data.couleur}>
</dd>
</dl>
<dl>
<dt>Premier emplacement <span class="red">*</span> :</dt>
<dd>
<select name="vie_implantation_id">
{section name=lst loop=$implantations}
<option value="{$implantations[lst].vie_implantation_id}" {if $data.vie_implantation_id == $implantations[lst].vie_implantation_id}selected{/if}>
{$implantations[lst].vie_implantation_libelle}
</option>
{/section}
</select>
</dl>
<dl>
<dt>Second emplacement <span class="red">*</span> :</dt>
<dd>
<select name="vie_implantation_id2">
{section name=lst loop=$implantations}
<option value="{$implantations[lst].vie_implantation_id}" {if $data.vie_implantation_id2 == $implantations[lst].vie_implantation_id}selected{/if}>
{$implantations[lst].vie_implantation_libelle}
</option>
{/section}
</select>
</dl>
<dl></dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.vie_modele_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="vieModeleDelete">
<input type="hidden" name="vie_modele_id" value="{$data.vie_modele_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>