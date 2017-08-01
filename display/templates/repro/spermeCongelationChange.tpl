<link href="display/javascript/c3/c3.css" rel="stylesheet" type="text/css">
<script src="display/javascript/c3/d3.min.js" charset="utf-8"></script>
<script src="display/javascript/c3/c3.min.js"></script>

<script>
$(document).ready(function() {
	var chart = c3.generate( {
		bindto: '#freeze',
		data: {
			xs: {
				'Température relevée': 'mx'
			} ,
	    x: 'x',
      xFormat: '%d/%m/%Y %H:%M:%S', // 'xFormat' can be used as custom format of 'x'
      columns: [
          [{$mx}],
          [{$my}]
          ]
	} ,
    axis: {
        x: {
            type: 'timeseries',
            tick: {
                format: '%d/%m %H:%M'
           	 	}
        },
        y: {
        	label: '°C'
        }
    	}
 
	} );
});
	
</script>

<a href="index.php?module={$poissonDetailParent}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Retour au reproducteur
</a>&nbsp;
<a href="index.php?module=spermeChange&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&sperme_id={$data.sperme_id}">
Retour au sperme
</a>
{include file="repro/poissonCampagneDetail.tpl"}

<table class="tablemulticolonne">
<tr>
<td>
<fieldset><legend>Modification d'une congélation de sperme</legend>
<div class="formSaisie">
<div>
<form id="spermeForm" method="post" action="index.php?module=spermeCongelationWrite">


<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
<dl>
<dt>Date de congélation<span class="red">*</span> :</dt>
<dd><input class="date" name="congelation_date" value="{$data.congelation_date}" required ></dd>
</dl>
<dl>
<dt>Volume total congelé (ml) :</dt>
<dd><input class="taux" name="congelation_volume" value="{$data.congelation_volume}">
</dd>
</dl>
<dl>
<dt>Volume de sperme (ml) :</dt>
<dd><input class="taux" name="volume_sperme" value="{$data.volume_sperme}">
</dd>
</dl>
<dl>
<dt>Nombre total de paillettes :</dt>
<dd><input class="nombre" name="nb_paillette" value="{$data.nb_paillette}"></dd>
</dl>
<dl>
<dt>Nombre total de visiotubes :</dt>
<dd><input class="nombre" name="nb_visiotube" value="{$data.nb_visiotube}"></dd>
</dl>
<dl>
<dt>Dilueur utilisé : </dt>
<dd>
<select name="sperme_dilueur_id">
<option value="" {if $data.sperme_dilueur_id == ""}selected{/if}>Choisissez...</option>
{section name=lst loop=$spermeDilueur}
<option value="{$spermeDilueur[lst].sperme_dilueur_id}" {if $data.sperme_dilueur_id == $spermeDilueur[lst].sperme_dilueur_id}selected{/if}>
{$spermeDilueur[lst].sperme_dilueur_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Volume de dilueur utilisé (ml) :</dt>
<dd><input class="taux" name="volume_dilueur" value="{$data.volume_dilueur}">
</dd>
</dl>

<dl>
<dt>Conservateur utilisé : </dt>
<dd>
<select name="sperme_conservateur_id">
<option value="" {if $data.sperme_conservateur_id == ""}selected{/if}>Choisissez...</option>
{section name=lst loop=$spermeConservateur}
<option value="{$spermeConservateur[lst].sperme_conservateur_id}" {if $data.sperme_conservateur_id == $spermeConservateur[lst].sperme_conservateur_id}selected{/if}>
{$spermeConservateur[lst].sperme_conservateur_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Volume de conservateur utilisé (ml) :</dt>
<dd><input class="taux" name="volume_conservateur" value="{$data.volume_conservateur}">
</dd>
</dl>
<dl>
<dt>Nb de paillettes utilisées :</dt>
<dd>
<input class="nombre" name="nb_paillettes_utilisees" value="{$data.nb_paillettes_utilisees}" readonly>
</dd>
</dl>

<dl>
<dt>Commentaire :</dt>
<dd>
<input class="commentaire" name="sperme_congelation_commentaire" value="{$data.sperme_congelation_commentaire}">
</dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.sperme_congelation_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="spermeCongelationDelete">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>
</fieldset>
</td>
<td>
<fieldset><legend>Vitesse de congélation</legend>
{include file="repro/spermeFreezingMeasureList.tpl"}
<br>
<div id="freeze"></div>
</fieldset>
</td>
</tr>
<tr>
<td>
<fieldset>
<legend>Liste des emplacements de congélation</legend>
{include file='repro/spermeFreezingPlaceList.tpl'}
</fieldset>
</td>
<td>
</td>
</tr>
</table>

