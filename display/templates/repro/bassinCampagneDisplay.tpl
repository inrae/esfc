<link href="display/javascript/c3/c3.css" rel="stylesheet" type="text/css">
<script src="display/javascript/c3/d3.min.js" charset="utf-8"></script>
<script src="display/javascript/c3/c3.min.js"></script>
<script>
$(document).ready(function() {
	var chart = c3.generate( {
		bindto: '#profilThermique',
		data: {
			xs: {
				'constaté': 'x1',
				'prévu': 'x2'
			} ,
//	    x: 'x',
      xFormat: '%d/%m/%Y %H:%M:%S', // 'xFormat' can be used as custom format of 'x'
      columns: [
          [{$pfx1}],
          [{$pfy1}],
          [{$pfx2}],
          [{$pfy2}]
          ]
	} ,
    axis: {
        x: {
            type: 'timeseries',
            tick: {
                format: '%d/%m %H:%M'
           	 	}
        	}
    	}
	} );
	$(".commentaire").attr("size","30");
} );
</script>
<h2>Détail d'un bassin</h2>
<a href="index.php?module={$bassinParentModule}">Retour à la liste des bassins</a>
<table class="tablemulticolonne">
<tr>
<td>
<h3>Identification du bassin</h3>
{include file="bassin/bassinDetail.tpl"}

<label>Usage du bassin pour la reproduction</label> : 
{if $droits.reproGestion == 1}
<form name="cbassincampagne" method="post" action="index.php?module=bassinCampagneWrite">
<input name="bassin_utilisation" value="{$dataBassinCampagne.bassin_utilisation}" class="commentaire">
<input type="hidden" name="bassin_campagne_id" value="{$dataBassinCampagne.bassin_campagne_id}">
<input type="hidden" name="annee" value="{$dataBassinCampagne.annee}">
<input type="hidden" name="bassin_id" value="{$dataBassinCampagne.bassin_id}">
<input class="submit" type="submit" value="Enregistrer">
</form>
{else}
{$dataBassinCampagne.bassin_utilisation}
{/if}
<h3>Liste des poissons présents</h3>
{include file="bassin/bassinPoissonPresent.tpl"}
<br>
<h3>Profil thermique</h3>
{if $droits.reproGestion == 1}
<a href="index.php?module=profilThermiqueChange&profil_thermique_id=0&bassin_campagne_id={$dataBassinCampagne.bassin_campagne_id}">
Nouvelle température prévue/relevée...
</a>
{/if}
{include file="repro/profilThermiqueList.tpl"}
<br>
<div id="profilThermique"></div>
</td>
<td>
<h3>Évenements survenus</h3>
{include file="bassin/bassinEvenementList.tpl"}
</td>
</tr>
</table>