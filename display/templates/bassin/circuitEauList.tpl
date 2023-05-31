<h2>{t}Circuits d'alimentation en eau{/t}</h2>
{include file="bassin/circuitEauSearch.tpl"}

{if $isSearch == 1}
{if $droits["bassinAdmin"] == 1}
<div class="row">
    <div class="col-lg-12">
        <a href="index.php?module=circuitEauChange&circuit_eau_id=0">
            {t}Nouveau...{/t}
        </a>
    </div>
</div>
{/if}

<div class="row">
    <div class="col-md-4">
        <table class="table table-bordered table-hover datatable" id="ccircuitEauList" class="tableliste">
            <thead>
                <tr>
                    <th>{t}libellé{/t}</th>
                    <th>{t}En service{/t}</th>
                    {if $droits["bassinGestion"] == 1}
                    <th>{t}Nouvelles données{/t}</th>
                    {/if}
                    <th>{t}Dernière analyse{/t}</th>
                </tr>
            </thead>
            <tbody>
                {section name=lst loop=$data}
                <tr>
                    <td>
                        <a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data[lst].circuit_eau_id}">
                            {$data[lst].circuit_eau_libelle}
                        </a>
                    </td>
                    <td class="center">
                        {if $data[lst].circuit_eau_actif == 1}{t}oui{/t}{else}{t}non{/t}{/if}
                    </td>
                    {if $droits["bassinGestion"] == 1}
                    <td>
                        <div class="center">
                            <a
                                href="index.php?module=analyseEauChange&analyse_eau_id=0&circuit_eau_id={$data[lst].circuit_eau_id}&origine=List">
                                <img src="display/images/sonde.png" height="20" border="0">
                            </a>
                        </div>
                    </td>
                    {/if}
                    <td class="center">
                        <a href="index.php?module=circuitEauList&circuit_eau_id={$data[lst].circuit_eau_id}">
                            <img src="display/images/eprouvette.png" height="20" border="0">
                        </a>
                    </td>
                </tr>
                {/section}
            </tbody>
        </table>
    </div>
    <div class="col-md-8">
        {if $dataAnalyse.analyse_eau_id > 0}
        {include file="bassin/analyseEauDetail.tpl"}
        {/if}
    </div>
</div>
{/if}