<h2{t}Modification d'un modèle de marquage VIE{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="vieModeleForm" method="post" action="index.php?module=vieModeleWrite">
<input type="hidden" name="vie_modele_id" value="{$data.vie_modele_id}">
<input type="hidden" name="annee" value="{$data.annee}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Couleur de la marque <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="couleur" class="commentaire" autofocus required value={$data.couleur}>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Premier emplacement <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="vie_implantation_id">
{section name=lst loop=$implantations}
<option value="{$implantations[lst].vie_implantation_id}" {if $data.vie_implantation_id == $implantations[lst].vie_implantation_id}selected{/if}>
{$implantations[lst].vie_implantation_libelle}
</option>
{/section}
</select>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Second emplacement <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="vie_implantation_id2">
{section name=lst loop=$implantations}
<option value="{$implantations[lst].vie_implantation_id}" {if $data.vie_implantation_id2 == $implantations[lst].vie_implantation_id}selected{/if}>
{$implantations[lst].vie_implantation_libelle}
</option>
{/section}
</select>
</div>
</div>
<div class="form-group"></div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.vie_modele_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="vieModeleDelete">
<input type="hidden" name="vie_modele_id" value="{$data.vie_modele_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>