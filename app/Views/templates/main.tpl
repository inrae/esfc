<link href="display/node_modules/c3/c3.min.css" rel="stylesheet" type="text/css">
<script src="display/node_modules/d3/dist/d3.min.js" charset="utf-8"></script>
<script src="display/node_modules/c3/c3.min.js"></script>
<script>
    $(document).ready(function() {
        $(".type").change( function() { 
        Cookies.set("mortalityType", $(this).val(), { expires: 180, secure: true});
        });
        $("#nbyears").change( function() { 
        Cookies.set("nbyears", $(this).val(), { expires: 180, secure: true});
        });
    });
</script>
<div class="center">
   <h1><i>ESFC</i> <span class="red">E</span>x <span class="red">S</span>itu <span class="red">F</span>ish <span class="red">C</span>onservation</h1> 
</div>

{if $displayMortality == 1}
<div class="col-md-12 col-lg-6 col-lg-offset-3">
    <fieldset>
        <legend>
            {t}Mortalité cumulée{/t}
        </legend>
        <form id="refresh" action="index.php" method="get" class="form-inline">
            <input type="hidden" name="module" value="default">
                <div class="radio">
                    <label>
                    <input type="radio" class="type" name="type" id="type1" value="1" {if $type == 1}checked{/if}>
                    {t}Affichage par catégorie{/t}
                    </label>
                </div>
                <div class="radio">
                    <label>
                    <input type="radio" class="type" name="type" id="type2" value="2" {if $type == 2}checked{/if}>
                    {t}Affichage par cohorte{/t}
                    </label>
                </div>
                <label class="control-label">{t}Nombre d'années à afficher :{/t}</label>
                <input type="number" id="nbyears" name="nbyears" value="{$nbyears}" class="form-control">
                <button class="btn btn-primary" type="submit">{t}Afficher{/t}</button>
        </form>
        
        <div class="center">
        <div id="mortality"></div>
    </div>
    </fieldset>
</div>
<script>
    var lastDate = Date.now();
    var firstDate = new Date();
    var years = "{$nbyears}";
    firstDate.setFullYear(firstDate.getFullYear() - years);
    c3.generate({
        "bindto": "#mortality",
        "data": {$data },
        axis: {
            x: {
                type: 'timeseries',
                tick: {
                    format: '{$dateFormat}',
                    rotate: 60
                },
                min: firstDate,
                max: lastDate
            },
            y: {
                label: '{t}Mortalité cumulée{/t}',
                min: 0,
                max: {$max }
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
{else}
<div class="center">
    <img src="display/images/sturio_release.jpg" title="{t}Photo : © Marie-Laure Acolas - 2012 - lâcher d'esturgeons en Dordogne{/t}" width="640">
</div>
{/if}