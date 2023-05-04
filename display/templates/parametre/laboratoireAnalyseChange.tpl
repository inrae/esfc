<h2{t}Modification d'un laboratoire d'analyse{/t}</h2>

<a href="index.php?module=laboratoireAnalyseList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="laboratoireAnalyseForm" method="post" action="index.php?module=laboratoireAnalyseWrite">
<input type="hidden" name="laboratoire_analyse_id" value="{$data.laboratoire_analyse_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nom du laboratoire <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="laboratoire_analyse_libelle" value="{$data.laboratoire_analyse_libelle}" size="40" autofocus required></dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Sollicité actuellement ?{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" type="radio" name="laboratoire_analyse_actif" value="1" {if $data.laboratoire_analyse_actif == 1}checked{/if}>oui
<input type="radio" name="laboratoire_analyse_actif" value="0" {if $data.laboratoire_analyse_actif == 0}checked{/if}>non
</dd>
</div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>

{if $data.laboratoire_analyse_id > 0 &&$droits["paramAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="laboratoire_analyse_id" value="{$data.laboratoire_analyse_id}">
<input type="hidden" name="module" value="laboratoireAnalyseDelete">
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

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>