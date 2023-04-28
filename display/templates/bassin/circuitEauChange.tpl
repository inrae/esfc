<h2>Modification du nom d'un circuit d'eau</h2>

<a href="index.php?module=circuitEauList">Retour à la liste des circuits d'eau</a>
{if $data.circuit_eau_id > 0 }
> <a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data.circuit_eau_id}">Retour au détail du circuit d'eau</a>
{/if}
<table class="tablesaisie">
<form class="cmxform" id="circuitEauForm" method="post" action="index.php?module=circuitEauWrite">
<input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
<tr>
<td class="libelleSaisie">
Nom du circuit d'eau <span class="red">*</span> :</td>
<td class="datamodif">
<input id="ccircuit_eau_libelle" name="circuit_eau_libelle" type="text" value="{$data.circuit_eau_libelle}" required autofocus/>
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
Circuit d'eau en service ? 
</td>
<td class="datamodif">
<input type="radio" name="circuit_eau_actif" value="1" {if $data.circuit_eau_actif == 1 || $data.circuit_eau_actif == ""}checked{/if}> oui
<input type="radio" name="circuit_eau_actif" value="0" {if $data.circuit_eau_actif == 0}checked{/if}> non

<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
</form>

{if $data.circuit_eau_id > 0 &&$droits["bassinAdmin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
<input type="hidden" name="module" value="circuitEauDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>