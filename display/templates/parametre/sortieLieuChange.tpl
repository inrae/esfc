<h2>Modification d'un lieu de lâcher/destination</h2>

<a href="index.php?module=sortieLieuList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form id="sortieLieuForm" method="post" action="index.php?module=sortieLieuWrite">
<input type="hidden" name="sortie_lieu_id" value="{$data.sortie_lieu_id}">
<dl>
<dt>Nom du lieu <span class="red">*</span> :</dt>
<dd><input name="localisation" size="40" value="{$data.localisation}" autofocus></dd>
</dl>
<dl>
<dt>Longitude (coord. décimales, WGS84) :</dt>
<dd>
<input name="longitude_dd" value="{$data.longitude_dd}" pattern="-?[0-9]+(\.[0-9]+)?" title="Nombre décimal">
</dd>
</dl>
<dl>
<dt>Latitude (coord. décimales, WGS84) :</dt>
<dd>
<input name="latitude_dd" value="{$data.latitude_dd}" pattern="-?[0-9]+(\.[0-9]+)?" title="Nombre décimal">
<dd>
</dl>
<dl>
<dt>Statut pris par le poisson :</dt>
<dd>
<select name="poisson_statut_id">
{section name=lst loop=$poissonStatut}
<option value={$poissonStatut[lst].poisson_statut_id} {if $poissonStatut[lst].poisson_statut_id == $data.poisson_statut_id} selected {/if}>
{$poissonStatut[lst].poisson_statut_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Lieu actuellement utilisé ?</dt>
<dd>
<input type="radio" name="actif" value="0" {if $data.actif == 0}checked{/if} > non
<br>
<input type="radio" name="actif" value="1" {if $data.actif == 1}checked{/if} > oui
</dd>
</dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>

{if $data.sortie_lieu_id > 0 &&$droits["paramAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="sortie_lieu_id" value="{$data.sortie_lieu_id}">
<input type="hidden" name="module" value="sortieLieuDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>