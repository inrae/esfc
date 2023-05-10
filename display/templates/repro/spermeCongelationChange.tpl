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
<fieldset><legend>{t}Modification d'une congélation de sperme{/t}<legend>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="spermeForm" method="post" action="index.php?module=spermeCongelationWrite">


<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de congélation<span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="date" name="congelation_date" value="{$data.congelation_date}" required ></dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Volume total congelé (ml) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="congelation_volume" value="{$data.congelation_volume}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Volume de sperme (ml) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="volume_sperme" value="{$data.volume_sperme}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nombre total de paillettes :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="nombre" name="nb_paillette" value="{$data.nb_paillette}"></dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nombre total de visiotubes :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="nombre" name="nb_visiotube" value="{$data.nb_visiotube}"></dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Dilueur utilisé : {/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="sperme_dilueur_id">
<option value="" {if $data.sperme_dilueur_id == ""}selected{/if}>Choisissez...</option>
{section name=lst loop=$spermeDilueur}
<option value="{$spermeDilueur[lst].sperme_dilueur_id}" {if $data.sperme_dilueur_id == $spermeDilueur[lst].sperme_dilueur_id}selected{/if}>
{$spermeDilueur[lst].sperme_dilueur_libelle}
</option>
{/section}
</select>
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Volume de dilueur utilisé (ml) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="volume_dilueur" value="{$data.volume_dilueur}">
</dd>
</div>

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Conservateur utilisé : {/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="sperme_conservateur_id">
<option value="" {if $data.sperme_conservateur_id == ""}selected{/if}>Choisissez...</option>
{section name=lst loop=$spermeConservateur}
<option value="{$spermeConservateur[lst].sperme_conservateur_id}" {if $data.sperme_conservateur_id == $spermeConservateur[lst].sperme_conservateur_id}selected{/if}>
{$spermeConservateur[lst].sperme_conservateur_libelle}
</option>
{/section}
</select>
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Volume de conservateur utilisé (ml) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="volume_conservateur" value="{$data.volume_conservateur}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nb de paillettes utilisées en repro :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="nombre" name="nb_paillettes_utilisees" value="{$data.nb_paillettes_utilisees}" readonly>
</dd>
</div>

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Commentaire :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="commentaire" name="sperme_congelation_commentaire" value="{$data.sperme_congelation_commentaire}">
</div>


<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.sperme_congelation_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="spermeCongelationDelete">
<input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
<input type="hidden" name="sperme_id" value="{$data.sperme_id}">
<input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>
</fieldset>
</td>
<td>
<fieldset><legend>{t}Vitesse de congélation{/t}<legend>
{include file="repro/spermeFreezingMeasureList.tpl"}
<br>
<div id="freeze"></div>
</fieldset>
</td>
</tr>
<tr>
<td>
{include file='repro/spermeMesureList.tpl'}
</td>
<td>
<fieldset>
<legend>{t}Liste des emplacements de congélation{/t}<legend>
{include file='repro/spermeFreezingPlaceList.tpl'}
</fieldset>
</td>
<td>
</td>
</tr>
</table>

