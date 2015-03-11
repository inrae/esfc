<link href="display/javascript/c3/c3.css" rel="stylesheet" type="text/css">
<script src="display/javascript/c3/d3.min.js" charset="utf-8"></script>
<script src="display/javascript/c3/c3.min.js"></script>
<script>
$(document).ready(function() {
	var chart = c3.generate( {
		bindto: '#profilThermique',
		data: {
			xs: {
				'prévu': 'x1',
				'relevé': 'x2'
			} ,
//	    x: 'x',
      xFormat: '%d/%m/%Y %H:%M:%S', // 'xFormat' can be used as custom format of 'x'
      columns: [
          ['x1', '18/03/2015 15:00:00', '18/03/2015 18:00:00', '18/03/2015 23:50:00', '19/03/2015 12:00:00'],
          ['prévu', 15, 16.5, 17, 16],
          ['x2', '18/03/2015 15:30:00', '18/03/2015 20:00:00', '19/03/2015 08:30:00'],
          ['relevé', 14.7, 16, 18]
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
} );
</script>
<h2>Détail d'un bassin</h2>
<a href="index.php?module={$bassinParentModule}">Retour à la liste des bassins</a>
<table class="tablemulticolonne">
<tr>
<td>
<h3>Identification du bassin</h3>
{include file="bassin/bassinDetail.tpl"}
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