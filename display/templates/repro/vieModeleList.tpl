<H2>Modèles d'implantation de marques VIE</H2>
<form method="get" action="index.php" id="search">
    <input type="hidden" name="module" value="vieModeleList">
    <div class="row">
        <div class="col-md-6 form-horizontal">
            <div class="form-group">
                <label for="annee" class="control-label col-md-4">
                    {t}Année :{/t}
                </label>
                <div class="col-md-4">
                    <select name="annee" id="annee" class="form-control">
                        {foreach $annees as $year}
                        <option value="{$year}" {if $annee==$year}selected{/if}>
                            {$year}
                        </option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-md-4 center">
                    <input type="submit" class="btn btn-success" value="{t}Rechercher{/t}" </div>
                </div>
            </div>
        </div>
    </div>
</form>

{if $droits.reproGestion == 1}
<a href="index.php?module=vieModeleChange&vie_modele_id=0">Nouveau modèle d'implantation VIE...</a>
{/if}
<table class="table table-bordered table-hover datatable" id="cvieModelelist">
    <thead>
        <tr>
            <th>{t}Couleur{/t}</th>
            <th>{t}Marque 1{/t}</th>
            <th>{t}Marque 2{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$data}
        <tr>
            <td>
                {if $droits.reproGestion == 1}
                <a href="index.php?module=vieModeleChange&vie_modele_id={$data[lst].vie_modele_id}">
                    {$data[lst].couleur}
                </a>
                {else}
                {$data[lst].couleur}
                {/if}
            </td>
            <td>{$data[lst].vie_implantation_libelle}</td>
            <td>{$data[lst].vie_implantation_libelle2}</td>
        </tr>
        {/section}
    </tbody>
</table>