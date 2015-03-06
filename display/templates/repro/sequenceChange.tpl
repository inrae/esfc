 <script>
 
$(document).ready(function() { 
$( "#cdate_debut" ).datepicker( { dateFormat: "dd/mm/yy" } );
});
</script>
<a href="index.php?module=sequenceList">
Retour à la liste des séquences
</a>
<h2>Modification d'une séquence</h2>
<div class="formSaisie">
<div>
<form id="sequenceForm" method="post" action="index.php?module=sequenceWrite">
<input type="hidden" name="sequence_id" value="{$data.sequence_id}">
<fieldset>
<legend>Séquence</legend>
<dl>
<dt>Année <span class="red">*</span> :</dt>
<dd>
<input name="annee" required readonly size="10" maxlength="10" value="{$data.annee}">
</dd>
</dl>
<dl>
<dt>Nom de la séquence <span class="red">*</span> :</dt>
<dd>
<input name="sequence_nom" required size="20" maxlength="30" value="{$data.sequence_nom}">
</dd>
</dl>
<dl>
<dt>Date de début de la séquence <span class="red">*</span> :</dt>
<dd>
<input class="date" name="sequence_date_debut" id="cdate_debut" required size="10" maxlength="10" value="{$data.sequence_date_debut}">
</dd>
</dl>
</fieldset>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.sequence_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="sequenceDelete">
<input type="hidden" name="sequence_id" value="{$data.sequence_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>
