<div class="row">
    <div class="col-lg-8 form-display">
        <dl class="dl-horizontal">
            <dt><label>{t}Nom du bassin :{/t}</label></dt>
            <dd>
                {$dataBassin.bassin_nom}
            </dd>
        </dl>
        <dl class="dl-horizontal">
            <dt><label>{t}Site :{/t}</label></dt>
            <dd>
                {$dataBassin.site_name}
            </dd>
        </dl>
        <dl class="dl-horizontal">
            <dt><label>{t}Implantation :{/t}</label></dt>
            <dd>
                {$dataBassin.bassin_zone_libelle}
            </dd>
        </dl>
        <dl class="dl-horizontal">
            <dt>
                <label>{t}Type de bassin :{/t}</label>
            </dt>
            <dd>
                {$dataBassin.bassin_type_libelle}
            </dd>
        </dl>
        <dl class="dl-horizontal">
            <dt><label>{t}Utilisation actuelle :{/t}</label></dt>
            <dd>
                {$dataBassin.bassin_usage_libelle}
            </dd>
        </dl>
        <dl class="dl-horizontal">
            <dt><label>{t}Circuit d'eau :{/t}</label></dt>
            <dd>
                <a style="display:inline;"
                    href="index.php?module=circuitEauDisplay&circuit_eau_id={$dataBassin.circuit_eau_id}">
                    {$dataBassin.circuit_eau_libelle}
                </a>
            </dd>
        </dl>
        <dl class="dl-horizontal">
            <dt><label>{t}État du bassin :{/t}</label></dt>
            <dd>
                {if $dataBassin.actif == 1}{t}Bassin en activité{/t}{else}{t}Bassin non utilisé ou réformé{/t}{/if}
            </dd>
        </dl>
    </div>
</div>