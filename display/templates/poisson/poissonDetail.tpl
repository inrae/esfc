<div class="row">
    <div class="col-md-6 form-display">
        <dl class="dl-horizontal">
            <dt>{t}Matricule :{/t}</dt>
            <dd>{$dataPoisson.matricule} {$dataPoisson.prenom}</dd>
        </dl>
        <dl class="dl-horizontal">
            <dt>{t}Sexe :{/t}</dt>
            <dd>{$dataPoisson.sexe_libelle} - {$dataPoisson.categorie_libelle} {$dataPoisson.poisson_statut_libelle}
            </dd>
        </dl>
        <dl class="dl-horizontal">
            <dt>{t}(Pit)tag :{/t}</dt>
            <dd>{$dataPoisson.pittag_valeur}</dd>
        </dl>
        <dl class="dl-horizontal">
            <dt>{t}Cohorte :{/t}</dt>
            <dd>{$dataPoisson.cohorte}</dd>
        </dl>

        {if strlen($dataPoisson.capture_date) > 0}
        <dl class="dl-horizontal">
            <dt>{t}capturé le{/t}</dt>
            <dd>{$dataPoisson.capture_date}</dd>
        </dl>
        {/if}
        {if !empty($dataPoisson.date_naissance)}
        <dl class="dl-horizontal">
            <dt>{t}né le{/t}</dt>
            <dd>{$dataPoisson.date_naissance}{/if}
            </dd>
        </dl>
        {if $dataPoisson.poisson_statut_id != 3 and $dataPoisson.poisson_statut_id != 4}
        <dl class="dl-horizontal">
            <dt>{t}Bassin :{/t}</dt>
            <dd>
                <a href="index.php?module=bassinDisplay&bassin_id={$dataPoisson.bassin_id}">
                    {$dataPoisson.bassin_nom}
                </a>
            </dd>
        </dl>
        <dl class="dl-horizontal">
            <dt>{t}Site :{/t}</dt>
            <dd>{$dataPoisson.site_name}</dd>
        </dl>
        {/if}
        {if !empty($dataPoisson.commentaire) }
        <dl class="dl-horizontal">
            <dt>{t}Commentaire{/t}</dt>
            <dd>{$dataPoisson.commentaire}</dd>
        </dl>
        {/if}
    </div>
    <div class="col-md-6">
        <fieldset>
            <legend>{t}Liste des parents{/t}</legend>
            {if $droits["poissonGestion"]==1}
            <div class="row">
                <a href="index.php?module=parentPoissonChange&poisson_id={$dataPoisson.poisson_id}&parent_poisson_id=0">
                    {t}Nouveau parent...{/t}
                </a>
            </div>

            {/if}
            {include file="poisson/parentPoissonList.tpl"}
        </fieldset>
    </div>
    <div class="col-md-6">
        <fieldset>
            <legend>{t}Liste des (pit)tags attribués{/t}</legend>
            {if $droits["poissonGestion"]==1}
            <div class="row">
                <a href="index.php?module=pittagChange&poisson_id={$dataPoisson.poisson_id}&pittag_id=0">
                    {t}Nouveau pittag ou étiquette...{/t}
                </a>
            </div>
            {/if}
            {include file="poisson/pittagList.tpl"}
        </fieldset>
    </div>
    <div class="col-md-6">
        <fieldset>
            <legend>{t}Sortie du stock{/t}</legend>
            <div>
                {include file="poisson/sortieList.tpl"}
                <br>
            </div>
        </fieldset>
    </div>
    <div class="col-md-6">
<fieldset>
            <legend>{t}Mortalité{/t}</legend>
            <div>
                {include file="poisson/mortaliteList.tpl"}
                <br>
            </div>
        </fieldset>
    </div>
</div>