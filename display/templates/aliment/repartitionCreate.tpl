<script>
$(document).ready(function() { 
	$(".date").datepicker({ dateFormat: "dd/mm/yy" });
} ) ;
</script>
<div class="formSaisie400">
<div>
<form id="repartitionForm" method="post" action="index.php?module=repartitionCreate">
<input type="hidden" name="repartition_id" value="0">
<dl>
<dt>Catégorie d'alimentation <span class="red">*</span> :</dt> 
<dd>
<select name="categorie_id" id="categorie_id" {if $data.repartition_id > 0}disabled{/if}>
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $data.categorie_id == $categorie[lst].categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>
</dd>
</dl>
 <dl>
 <dt>Date début :</dt>
 <dd><input class="date" name="date_debut_periode" value="{$data.date_debut_periode}"></dd>
 </dl>
 <dl>
 <dt>Date fin :</dt>
 <dd><input class="date" name="date_fin_periode" value="{$data.date_fin_periode}"></dd>
 </dl>
 <fieldset>
 <legend>Jours de distribution</legend>
lun : <input type="checkbox" name="lundi" value="1" {if $data.lundi == 1}checked{/if}>
mar : <input type="checkbox" name="mardi" value="1" {if $data.mardi == 1}checked{/if}>
mer : <input type="checkbox" name="mercredi" value="1" {if $data.mercredi == 1}checked{/if}>
jeu : <input type="checkbox" name="jeudi" value="1" {if $data.jeudi == 1}checked{/if}>
<br>
ven : <input type="checkbox" name="vendredi" value="1" {if $data.vendredi == 1}checked{/if}>
sam : <input type="checkbox" name="samedi" value="1" {if $data.samedi == 1}checked{/if}>
dim : <input type="checkbox" name="dimanche" value="1" {if $data.dimanche == 1}checked{/if}>
 </fieldset>
 <div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>
</div>
 