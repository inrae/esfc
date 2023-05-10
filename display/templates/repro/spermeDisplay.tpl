<a href="index.php?module={$poissonDetailParent}&sperme_qualite_id={$sperme_qualite_id}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2{t}Détail d'un prélèvement de sperme{/t}</h2>
<div class="formDisplay">
<dl>
<dt>Date du prélèvement :</dt>
<dd>
{$data.sperme_date}
</dd>
</dl>
<dl>
<dt>Séquence de reproduction :</dt>
<dd>
{$data.sequence_nom}
</dl>
<dl>
<dt>Aspect :</dt>
<dd>
{$data.sperme_aspect_libelle}
</dd>
</dl>
<dl>
<dt>Caractéristiques particulières :</dt>
<dd>
<table>
{section name=lst loop=$spermeCaract}

{if $spermeCaract[lst].sperme_id > 0}
<tr>
<td>{$spermeCaract[lst].sperme_caracteristique_libelle}</td>
</tr>
{/if}
{/section}
</table>
</dd>
</dl>
<dl>
<dt>Commentaire :</dt>
<dd>
{$data.sperme_commentaire}
</dl>
<fieldset>
<legend>{t}Congélation{/t}<legend>
<dl>
<dt>Date de congélation :</dt>
<dd>{$data.congelation_date}</dd>
</dl>
<dl>
<dt>Volume congelé (ml) :</dt>
<dd>{$data.congelation_volume}
</dd>
</dl>
<dl>
<dt>Dilueur utilisé : </dt>
<dd>
{$data.sperme_dilueur_libelle}
</dd>
</dl>
<dl>
<dt>Nombre de paillettes :</dt>
<dd>{$data.nb_paillette}</dd>
</dl>
<dl>
<dt>Numéro de canister :</dt>
<dd>{$data.numero_canister}
</dd>
</dl>
<dl>
<dt>Position du canister :</dt>
<dd>
{if $data.position_canister == "1"}Bas{/if}
{if $data.position_canister == "2"}Haut{/if}
</dd>
</dl>
</fieldset>
</div>
<br>
{include file="repro/spermeMesureList.tpl"}