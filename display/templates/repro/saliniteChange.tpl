<script>
$(document).ready(function() {
	$(".taux").attr( {
			pattern: "[0-9]+(\.[0-9]+)?",
			size: "5",
			title: "valeur numérique",
			maxlength: "10"
	} );
	
	$(".date").datepicker( { dateFormat: "dd/mm/yy" } );
	$(".time").attr( {
		pattern: "[0-9][0-9]\:[0-9][0-9]",
		placeholder: "hh:mm",
		size: "5"
	} );
	$(".timepicker").timepicker( {
		timeFormat: "HH:mm:ss",
//		$.timepicker.regional['fr'],
		stepHour: "1",
		stepMinute: "10",
		size: "5"
	} );
	$("#pf_date").datepicker.parseTime("dd/mm/yy hh:mm:ss");
	$(".commentaire").attr("size","30");
});
</script>
<a href="index.php?module={$bassinParentModule}">Retour à la liste des bassins</a>
> <a href="index.php?module=bassinCampagneDisplay&bassin_campagne_id={$data.bassin_campagne_id}">Retour au bassin</a>
{include file="bassin/bassinDetail.tpl"}
<h2>profil thermique du bassin</h2>
<div class="formSaisie">
<div>
<form id="saliniteForm" method="post" action="index.php?module=saliniteWrite">
<input type="hidden" name="salinite_id" value="{$data.salinite_id}">
<input type="hidden" name="bassin_campagne_id" value="{$data.bassin_campagne_id}">
<dl>
<dt>Date/heure <span class="red">*</span> :</dt>
<dd>
<input class="date"  name="salinite_date" required size="10" value="{$data.salinite_date}">
<input class="timepicker" name="salinite_time" required value="{$data.salinite_time}">
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
<input type="radio" {if $data.profil_thermique_type_id == 1}checked{/if} name="profil_thermique_type_id" value="1">
</dd>
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.profil_thermique_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="saliniteDelete">
<input type="hidden" name="salinite_id" value="{$data.salinite_id}">
<input type="hidden" name="bassin_campagne_id" value="{$data.bassin_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>
<br>
{if $data.profil_thermique_id > 0}
<a href="index.php?module=saliniteNew&bassin_campagne_id={$data.bassin_campagne_id}">
Nouvelle donnée...
</a>
<br>
{/if}
{include file="repro/saliniteList.tpl"}