<link href="display/javascript/c3/c3.css" rel="stylesheet" type="text/css">
<script src="display/javascript/c3/d3.min.js" charset="utf-8"></script>
<script src="display/javascript/c3/c3.min.js"></script>
<script>
$(document).ready(function() {
	{if $graphicsEnabled == 1}
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
	var chart1 = c3.generate( { 
		bindto:'#tauxSanguin',
		data: { 
			xs: { 
				'E2': 'x1',
				'Ca': 'x2'
			},
			xFormat: '%d/%m/%Y',
			columns: [ 
			  [{$e2x}],
			  [{$e2y}],
			  [{$cax}],
			  [{$cay}]
			  ] ,
			  
			axes: { 
				E2: 'y',
				Ca: 'y2'
			}  			
		} ,

	    axis: {
	        x: {
	            type: 'timeseries',
	            tick: {
	                format: '%d/%m'
	           	 	}
	        	},
	        y2: {
	        	show: true
	        }
	    	}
	});
	{/if}
} );
</script>
<h2>Détail d'un reproducteur</h2>
<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">Retour à la liste des poissons</a>
{if $droits["reproGestion"]==1}
&nbsp;
<a href="index.php?module=poissonCampagneChange&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&poisson_id={$dataPoisson.poisson_id}">
Modifier les informations générales...
</a>
&nbsp;
{/if}
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&graphicsEnabled=1">
Afficher les graphiques...
</a>
<table class="tablemulticolonne">
<tr>
<td colspan="2">
{include file="repro/poissonCampagneDetail.tpl"}
</td>
</tr>
<tr>
<td>
<fieldset>
<legend>Séquences de reproduction</legend>
{include file="repro/poissonSequenceList.tpl"}
</fieldset>
<br>
<fieldset>
<legend>Échographies de l'année</legend>
{if $droits.reproGestion == 1}
<a href="index.php?module=evenementChange&evenement_id=0&poisson_id={$dataPoisson.poisson_id}">
Nouvelle échographie (nouvel événement)...
</a>
{/if}
{include file="poisson/echographieList.tpl"}
</fieldset>
</td>
<td>
<fieldset>
<legend>Événements liés aux séquences</legend>
{include file="repro/psEvenementList.tpl"}
</fieldset>
<br>
<fieldset>
<legend>Analyses sanguines</legend>
{include file="repro/poissonSanguinList.tpl"}
</fieldset>
<br>
<fieldset>
<legend>Injections</legend>
{include file="repro/injectionList.tpl"}
</fieldset>
</td>
</tr>
<td colspan="2">
<fieldset>
<legend>Biopsies</legend>
{include file="repro/poissonBiopsieList.tpl"}
</fieldset>
</td>
</tr>
<tr>
<td>
<fieldset>
<legend>Profil thermique du poisson</legend>
<div id="profilThermique"></div>
</fieldset>
</td>
<td>
<fieldset>
<legend>Taux sanguins</legend>
<div id="tauxSanguin"></div>
</fieldset>

</tr>
</table>
