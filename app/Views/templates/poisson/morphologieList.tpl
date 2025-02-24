<link href="display/node_modules/c3/c3.min.css" rel="stylesheet" type="text/css">
<script src="display/node_modules/d3/dist/d3.min.js" charset="utf-8"></script>
<script src="display/node_modules/c3/c3.min.js"></script>
<div class="row">
<div class="col-lg-6 col-md-12">
<table class="table table-bordered table-hover datatable ok" id="cmorphologieList"  data-order='[[1,"desc"]]'  data-tabicon="okmorphologie">
<thead>
<tr>
<th>{t}Événement associé{/t}</th>
<th>{t}Date de mesure{/t}</th>
<th>{t}Longueur à la fourche (cm){/t}</th>
<th>{t}Longueur totale (cm){/t}</th>
<th>{t}Masse (g){/t}</th>
<th>{t}Circonférence (cm){/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataMorpho}
<tr>
<td>
{if $rights["poissonGestion"]==1}
<a href="evenementChange?poisson_id={$dataMorpho[lst].poisson_id}&evenement_id={$dataMorpho[lst].evenement_id}">
{$dataMorpho[lst].evenement_type_libelle}
</a>
{else}
{$dataMorpho[lst].evenement_type_libelle}
{/if}
</td>
<td class="center">
{$dataMorpho[lst].morphologie_date}
</td>
<td class="right">{$dataMorpho[lst].longueur_fourche}</td>
<td class="right">{$dataMorpho[lst].longueur_totale}</td>
<td class="right">{$dataMorpho[lst].masse}</td>
<td class="right">{$dataMorpho[lst].circonference}</td>
<td>{$dataMorpho[lst].morphologie_commentaire}</td>
</tr>
{/section}
</tbody>
</table>
</div>
    <div class="col-lg-6 col-md-12" id="morphologyGraph"></div>
</div>
<script>
        c3.generate({
        "bindto": "#morphologyGraph",
        "data": {$dataMorphoGraph },
        axis: {
            x: {
                type: 'timeseries',
                tick: {
                    format: '{$dateFormat}',
                    rotate: 60
                },
                min: "{$firstdate}",
                max: "{$lastdate}"
            },
            y: {
                label: '{t}Poids en grammes{/t}',
                min: 0,
                max: {$maxy }
            },
            y2: {
                label:'{t}Taille en cm{/t}',
                min: 0,
                max: {$maxy2 },
                show: true
            }
        },
        size: {
            height: 640
        },
        padding: {
            top: 40
        },
        grid: {
            y: {
                show: true
            }
        }
    }
    );

</script>
