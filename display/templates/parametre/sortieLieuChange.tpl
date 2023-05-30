<h2>{t}Modification d'un lieu de lâcher/destination{/t}</h2>

<a href="index.php?module=sortieLieuList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="sortieLieuForm" method="post" action="index.php?module=sortieLieuWrite">
<input type="hidden" name="sortie_lieu_id" value="{$data.sortie_lieu_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nom du lieu :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" name="localisation" size="40" value="{$data.localisation}" autofocus>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Longitude (coord. décimales, WGS84) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="longitude_dd" value="{$data.longitude_dd}" pattern="-?[0-9]+(\.[0-9]+)?" title="Nombre décimal">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Latitude (coord. décimales, WGS84) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="latitude_dd" value="{$data.latitude_dd}" pattern="-?[0-9]+(\.[0-9]+)?" title="Nombre décimal">
<dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Statut pris par le poisson :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="poisson_statut_id">
{section name=lst loop=$poissonStatut}
<option value={$poissonStatut[lst].poisson_statut_id} {if $poissonStatut[lst].poisson_statut_id == $data.poisson_statut_id} selected {/if}>
{$poissonStatut[lst].poisson_statut_libelle}
</option>
{/section}
</select>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Lieu actuellement utilisé ?{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" type="radio" name="actif" value="0" {if $data.actif == 0}checked{/if} > non
<br>
<input type="radio" name="actif" value="1" {if $data.actif == 1}checked{/if} > oui

</div>


<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>

{if $data.sortie_lieu_id > 0 &&$droits["paramAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="sortie_lieu_id" value="{$data.sortie_lieu_id}">
<input type="hidden" name="module" value="sortieLieuDelete">
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