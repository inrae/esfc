<a href="index.php?module=sequenceList">
Retour à la liste des séquences
</a>
&nbsp;
<a href="index.php?module=sequenceDisplay&sequence_id={$data.sequence_id}">
Retour à la séquence
</a>
{include file="repro/sequenceDetail.tpl"}
<h2>{t}Détail du croisement <i>{$data.parents}</i>{/t}</h2>
{if $droits.reproGestion == 1}
<a href="index.php?module=croisementChange&croisement_id={$data.croisement_id}">Modifier...</a>
{/if}
<table class="tablemulticolonne">
<tr>
<td>
<div class="formDisplay">
<dl>
<dt>Date/heure de la fécondation :</dt>
<dd>
{$data.croisement_date}
</dd>
</dl>
<dl>
<dt>Nom du croisement :</dt>
<dd>
{$data.croisement_nom}
</dd>
</dl>
<dl>
<dt>Masse des ovocytes (en grammes) :</dt>
<dd>{$data.ovocyte_masse}
</dd>
</dl>
<dl>
<dt>Nbre ovocytes par gramme :</dt>
<dd>{$data.ovocyte_densite}
</dd>
</dl>
<dl>
<dt>Taux de fécondation :</dt>
<dd>{$data.tx_fecondation}
</dd>
</dl>
<dl>
<dt>Taux de survie estimé :</dt>
<dd>{$data.tx_survie_estime}
</dd>
</dl>
<dl>
<dt>Qualité génétique du croisement :</dt>
<dd>
{$data.croisement_qualite_libelle}
</dd>
</dl>
<dl></dl>
</div>
</td>
</tr>
<tr>
<td>
<fieldset><legend>{t}Liste des spermes utilisés{/t}</legend>
{include file="repro/spermeUtiliseList.tpl"}
</fieldset>
</td>
</tr>
</table>