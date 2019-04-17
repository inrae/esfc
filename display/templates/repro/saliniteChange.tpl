<a href="index.php?module={$bassinParentModule}">Retour à la liste des bassins</a>
> <a href="index.php?module=bassinCampagneDisplay&bassin_campagne_id={$data.bassin_campagne_id}">Retour au bassin</a>
{include file="bassin/bassinDetail.tpl"}
<h2>profil thermique du bassin</h2>
<div class="formSaisie">
<div>
<form id="saliniteForm" method="post" action="index.php?module=saliniteWrite">
<input type="hidden" name="salinite_id" value="{$data.salinite_id}">
<input type="hidden" name="bassin_campagne_id" value="{$data.bassin_campagne_id}">
<input type="hidden" name="bassin_id" value="{$dataBassin.bassin_id}">
<input type="hidden" name="circuit_eau_id" value="{$dataBassin.circuit_eau_id}">
<dl>
<dt>Date/heure <span class="red">*</span> :</dt>
<dd>
<input class="datetimepicker" name="salinite_datetime" required value="{$data.salinite_datetime}">
</dd>
</dl>
<dl>
<dt>Taux de salinité <span class="red">*</span> :</dt>
<dd>
<input class="taux" name="salinite_tx" required value="{$data.salinite_tx}">
</dd>
</dl>
<dl>
<dt>Type :</dt>
<dd>prévu 
<input type="radio" {if $data.profil_thermique_type_id == 2 || $data.profil_thermique_type_id == ""}checked{/if} name="profil_thermique_type_id" value="2">
&nbsp;constaté
<input type="radio" disabled {if $data.profil_thermique_type_id == 1}checked{/if} name="profil_thermique_type_id" value="1">
</dd>
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.salinite_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="saliniteDelete">
<input type="hidden" name="salinite_id" value="{$data.salinite_id}">
<input type="hidden" name="bassin_campagne_id" value="{$data.bassin_campagne_id}">
<input type="hidden" name="bassin_id" value="{$dataBassin.bassin_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>
<br>

<a href="index.php?module=saliniteNew&bassin_campagne_id={$data.bassin_campagne_id}">
Nouvelle donnée...
</a>
<br>

{include file="repro/saliniteList.tpl"}