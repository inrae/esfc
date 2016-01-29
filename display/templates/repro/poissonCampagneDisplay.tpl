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
           	 	},
	        min: '{$dateMini} 00:00:00',
	        max: '{$dateMaxi} 23:59:59'	
        	},
        y: {
        	label: '°C',
        	min: 10,
        	max: 22
        }
    	}
 
	} );
	var chart1 = c3.generate( { 
		bindto:'#tauxSanguin',
		data: { 
			xs: { 
				'E2': 'x1',
				'Ca': 'x2',
				'Injections':'x3',
				'Expulsion':'x4'
			},
			xFormat: '%d/%m/%Y',
			columns: [ 
			  [{$e2x}],
			  [{$e2y}],
			  [{$cax}],
			  [{$cay}],
			  [{$ix}],
			  [{$iy}],
			  [{$expx}],
			  [{$expy}]
			  ] ,
			  
			axes: { 
				E2: 'y',
				Ca: 'y2',
				Injections: 'y2',
				Expulsion: 'y2'
			},
			types: { 
				Injections: 'bar',
				Expulsion: 'bar'
			}
		} ,
		bar: { 
			width: { 
				ratio: '0.05'
			}
		} ,

	    axis: {
	        x: {
	            type: 'timeseries',
	            tick: {
	                format: '%d/%m'
	           	 	},
	           	 min: '{$dateMini}',
	           	 max: '{$dateMaxi}'
	        },
	        y: {
	        	label: 'E2 - pg/ml',
	        	min: 0
	        },
	        y2: {
	        	show: true,
	        	label: 'CA - mg/ml',
	        	min: 0
	        }
	    }
	});
	{if $dataPoisson.sexe_libelle_court == "f"}
	var chart2 = c3.generate( { 
		bindto:'#biopsie',
		data: { 
			xs: { 
				'Tx OPI': 'x1',
				'T50': 'x2',
				'Diam moyen': 'x3'

			},
			xFormat: '%d/%m/%Y',
			columns: [ 
			  [{$opix}],
			  [{$opiy}],
			  [{$t50x}],
			  [{$t50y}],
			  [{$diamx}],
			  [{$diamy}]
			  ] ,
			  
			axes: { 
				"Tx OPI": 'y',
				"T50": 'y',
				"Diam moyen":'y2'
			}
			
		} ,

	    axis: {
	        x: {
	            type: 'timeseries',
	            tick: {
	                format: '%d/%m'
	           	 	},
	           	 min: '{$dateMini}',
	           	 max: '{$dateMaxi}'
	        },
	        y: {
	        	label: 'Tx OPI (%) et heures (fractions décimales)',
	        	min: 0,
	        	max: 20
	        },
	        y2: {
	        	show: true,
	        	label: 'Diamètre - mm',
	        	min: 0,
	        	max: 3
	        }
	    }
	});
	{/if}
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
<br>
<fieldset>
<legend>Analyses sanguines</legend>
{include file="repro/poissonSanguinList.tpl"}
</fieldset>
{if $dataPoisson.sexe_libelle_court == "m"}
<br>
<fieldset>
<legend>Prélèvements de sperme</legend>
{include file="repro/spermeList.tpl"}
</fieldset>
{/if}
</td>
<td>
<fieldset>
<legend>Transferts de l'année</legend>
{include file="poisson/transfertList.tpl"}
</fieldset>
<fieldset>
<legend>Événements liés aux séquences</legend>
{include file="repro/psEvenementList.tpl"}
</fieldset>
<br>

<fieldset>
<legend>Injections</legend>
{include file="repro/injectionList.tpl"}
</fieldset>
</td>
</tr>
{if $dataPoisson.sexe_libelle_court == "f"}
<tr>
<td colspan="2">
<fieldset>
<legend>Biopsies</legend>
{include file="repro/poissonBiopsieList.tpl"}
</fieldset>
</td>
</tr>
{/if}

</table>
<fieldset>
<legend>Taux sanguins, injections et expulsions</legend>
<div id="tauxSanguin"></div>
</fieldset>
{if $dataPoisson.sexe_libelle_court == "f"}
<br>
<fieldset>
<legend>Valeurs de biopsie</legend>
<div id="biopsie"></div>
</fieldset>
{/if}
<br>
<fieldset>
<legend>Profil thermique du poisson</legend>
<div id="profilThermique"></div>
</fieldset>
