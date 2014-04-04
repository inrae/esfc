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
 <div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>
</div>
 