{include file="bassin/bassinSearch.tpl"}
{if $isSearch == 1}
<form name="f_distrib" method="get" action="index.php" class="form-horizontal col-lg-8">
    <input type="hidden" name="module" value="bassinRecapAlim">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <label>{t}Récapitulatif hebdomadaire des quantités d'aliments distribués :{/t}</label>
            </div>
            <div class="row">
                <label class="control-label col-md-2">{t}du :{/t}</label>
                <div class="col-md-2">
                    <input class="date form-control" name="dateDebut" value="{$dateDebut}">
                </div>
                <label class="control-label col-md-2">{t}au :{/t}</label>
                <div class="col-md-2">
                    <input class="date form-control" name="dateFin" value="{$dateFin}">
                </div>
                <div class="col-md-4">
                    <input class="button btn-success" value="{t}Générer le fichier (peut être long...){/t}" type="submit">
                </div>
            </div>
        </div>
    </div>
</form>

{if $droits.bassinGestion == 1}
<div class="col-md-12">
    <div class="row">
        <a href="index.php?module=bassinChange&bassin_id=0">Nouveau bassin...</a>
    </div>
</div>
{/if}
<div class="col-lg-12">
    <div class="row">
        <table class="table table-bordered table-hover datatable" id="cbassinList">
            <thead>
                <tr>
                <th>{t}Nom{/t}</th>
                <th>{t}Description{/t}</th>
                <th>{t}Zoned'implantation{/t}</th>
                <th>{t}Type{/t}</th>
                <th>{t}Utilisation{/t}</th>
                <th>{t}Circuitd'eau{/t}</th>
                <th>{t}dimensions (longueur x largeur x hauteur d'eau){/t}</th>
                <th>{t}Surface - volume d'eau{/t}</th>
                <th>{t}Utilisé actuellement ?{/t}</th>
                </tr>
            </thead>
            <tbody>
            {section name=lst loop=$data}
                <tr>
                <td>
                <a href="index.php?module=bassinDisplay&bassin_id={$data[lst].bassin_id}">
                {$data[lst].bassin_nom}
                </a>
                </td>
                <td>{$data[lst].bassin_description}</td>
                <td>{$data[lst].bassin_zone_libelle}</td>
                <td>{$data[lst].bassin_type_libelle}</td>
                <td>{$data[lst].bassin_usage_libelle}</td>
                <td>
                <a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data[lst].circuit_eau_id}">
                {$data[lst].circuit_eau_libelle}
                </a>
                </td>
                <td>{$data[lst].longueur}x{$data[lst].largeur_diametre}x{$data[lst].hauteur_eau}</td>
                <td>{$data[lst].surface} - {$data[lst].volume}</td>
                <td>
                <div class="center">
                {if $data[lst].actif == 1}oui{elseif $data[lst].actif == 0}non{/if}
                </div>
                </td>
                </tr>
            {/section}
            </tbody>
        </table>
    </div>
</div>
{/if}