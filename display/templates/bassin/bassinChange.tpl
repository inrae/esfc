<a href="index.php?module={$bassinParentModule}">
Retour à la liste des bassins
</a>
{if $data.bassin_id > 0}
 > 
<a href="index.php?module=bassinDisplay&bassin_id={$data.bassin_id}"> Retour au bassin</a>
{/if}
<h2{t}Modification d'un bassin{/t}</h2>
<table class="tablesaisie">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="bassinform" method="post" action="index.php?module=bassinWrite">
<input type="hidden" name="bassin_id" value="{$data.bassin_id}">
<tr>
<td class="libelleSaisie">
Nom du bassin <span class="red">*</span> :</td>
<td class="datamodif">
<input id="cbassin_nom" name="bassin_nom" value="{$data.bassin_nom}" size="20" required>
</td>
</tr>
<tr>
<td class="libelleSaisie">
Description :
</td>
<td class="datamodif">
<input id="cbassin_description" name="bassin_description" value="{$data.bassin_description}" size="20">
</td>
</tr>

<tr>
<td class="libelleSaisie">
Type de bassin :</td>
<td class="datamodif">
<select id="cbassin_type_id" name="bassin_type_id">
<option value="" {if $bassinType[lst].bassin_type_id == ""}selected{/if}>
Sélectionnez le type de bassin...
</option>
{section name=lst loop=$bassin_type}
<option value="{$bassin_type[lst].bassin_type_id}" {if $bassin_type[lst].bassin_type_id == $data.bassin_type_id}selected{/if}>
{$bassin_type[lst].bassin_type_libelle}
</option>
{/section}
</select>
</td>
</tr>

<tr>
<td class="libelleSaisie">Site d'implantation :</td>
<td class="datamodif">
<select name="site_id">
<option value="" {if $data.site_id == ""}selected{/if}>Sélectionnez le site...</option>
{section name=lst loop=$site}
<option value="{$site[lst].site_id}" {if $data.site_id == $site[lst].site_id}selected{/if}>
{$site[lst].site_name}
</option>
{/section}
</select>
</td>
</tr>

<tr>
<td class="libelleSaisie">
Utilisation du bassin :</td>
<td class="datamodif">
<select id="cbassin_usage_id" name="bassin_usage_id">
<option value="" {if $bassin_usage[lst].bassin_usage_id == ""}selected{/if}>
Sélectionnez l'utilisation du bassin...
</option>
{section name=lst loop=$bassin_usage}
<option value="{$bassin_usage[lst].bassin_usage_id}" {if $bassin_usage[lst].bassin_usage_id == $data.bassin_usage_id}selected{/if}>
{$bassin_usage[lst].bassin_usage_libelle}
</option>
{/section}
</select>
</td>
</tr>

<tr>
<td class="libelleSaisie">
Zone d'implantation du bassin :</td>
<td class="datamodif">
<select id="cbassin_zone_id" name="bassin_zone_id">
<option value="" {if $bassin_zone[lst].bassin_zone_id == ""}selected{/if}>
Sélectionnez la zone d'implantation du bassin...
</option>
{section name=lst loop=$bassin_zone}
<option value="{$bassin_zone[lst].bassin_zone_id}" {if $bassin_zone[lst].bassin_zone_id == $data.bassin_zone_id}selected{/if}>
{$bassin_zone[lst].bassin_zone_libelle}
</option>
{/section}
</select>
</td>
</tr>

<tr>
<td class="libelleSaisie">
Circuit d'eau :</td>
<td class="datamodif">
<select id="ccircuit_eau_id" name="circuit_eau_id">
<option value="" {if $circuit_eau[lst].circuit_eau_id == ""}selected{/if}>
Sélectionnez le circuit d'eau...
</option>
{section name=lst loop=$circuit_eau}
<option value="{$circuit_eau[lst].circuit_eau_id}" {if $circuit_eau[lst].circuit_eau_id == $data.circuit_eau_id}selected{/if}>
{$circuit_eau[lst].circuit_eau_libelle}
</option>
{/section}
</select>
</td>
</tr>

<tr>
<td class="libelleSaisie">
<label for="longueur">
Longueur (en cm) :
</label>
</td>
<td class="datamodif">
<input id="longueur" name="longueur" value="{$data.longueur}" size="10" pattern="[0-9]+(\.[0-9]+)?" />
</td>
</tr>

<tr>
<td class="libelleSaisie">
Largeur ou diamètre (en cm) :
</td>
<td class="datamodif">
<input id="clargeur_diametre" name="largeur_diametre" value="{$data.largeur_diametre}" size="10" pattern="[0-9]+" >
</td>
</tr>



<tr>
<td class="libelleSaisie">
Surface (en cm2) :
</td>
<td class="datamodif">
<input id="csurface" name="surface" value="{$data.surface}" size="10" pattern="[0-9]+">
</td>
</tr>

<tr>
<td class="libelleSaisie">
Hauteur d'eau (en cm) :
</td>
<td class="datamodif">
<input id="chauteur_eau" name="hauteur_eau" value="{$data.hauteur_eau}" size="10" type="number" pattern="[0-9]+">
</td>
</tr>

<tr>
<td class="libelleSaisie">
Volume (en litres) :
</td>
<td class="datamodif">
<input id="cvolume" name="volume" value="{$data.volume}" size="10" type="number" pattern="[0-9]+">
</td>
</tr>

<tr>
<td class="libelleSaisie">
Bassin en activité :
</td>
<td class="datamodif">
<input type="radio" id="cactif_0" name="actif" value="1" {if $data.actif == 1} checked{/if}>oui 
<input type="radio" id="cactif_1" name="actif" value="0" {if $data.actif == 0} checked{/if}>non 
</td>
</tr>

<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>

{if $data.bassin_id > 0 &&$droits["bassinAdmin"] == 1}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="bassin_id" value="{$data.bassin_id}">
<input type="hidden" name="module" value="bassinDelete">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>