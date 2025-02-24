<div class="row">
    <div class="col-lg-8 col-md-12">
        <form method="get" action="anomalieList" class="form-horizontal">
            <input type="hidden" name="isSearch" value="1">
            <div class="row">
                <div class="form-group">
                    <label for="statut0" class="control-label col-md-3">
                        {t}Anomalies traitées ?{/t}
                    </label>
                    <div class="col-md-3">
                        <label class="radio-inline">
                            <input id="statut0" type="radio" name="statut" value="0" {if
                                $anomalieSearch.statut==0}checked{/if}>{t}non{/t}
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="statut" value="1" {if
                                $anomalieSearch.statut==1}checked{/if}>{t}oui{/t}
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="statut" value="-1" {if
                                $anomalieSearch.statut==-1}checked{/if}>{t}Indifférent{/t}
                        </label>
                    </div>
                    <label for="type" class="control-label col-md-2">
                        {t}Type d'anomalie :{/t}
                    </label>
                    <div class="col-md-3">
                        <select class="form-control" id="type" name="type">
                            <option value="" {if $anomalieSearch.type=="" }selected{/if}>
                                {t}Sélectionnez le type d'anomalie...{/t}
                            </option>
                            {section name=lst loop=$anomalieType}
                            <option value="{$anomalieType[lst].anomalie_db_type_id}" {if
                                $anomalieType[lst].anomalie_db_type_id==$anomalieSearch.type}selected{/if}>
                                {$anomalieType[lst].anomalie_db_type_libelle}
                            </option>
                            {/section}
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="center">
                        <input type="submit" class="btn btn-success" value="{t}Rechercher{/t}">
                    </div>
                </div>
            </div>
        {$csrf}</form>
    </div>
</div>
{if $isSearch == 1}
<table class="table table-bordered table-hover datatable display" id="canomalieList" class="tableliste">
    <thead>
        <tr>
            {if $rights["poissonAdmin"] == 1}
            <th>{t}Modif{/t}</th>
            {/if}
            <th>{t}Poisson{/t}</th>
            <th>{t}Événement associé{/t}</th>
            <th>{t}Type d'anomalie{/t}</th>
            <th>{t}Date{/t}</th>
            <th>{t}Commentaire{/t}</th>
            <th>{t}Date de traitement{/t}</th>
            <th>{t}État{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$dataAnomalie}
        <tr>
            {if $rights["poissonAdmin"] == 1}
            <td>
                <div class="center">
                    <a href="anomalieChange?anomalie_db_id={$dataAnomalie[lst].anomalie_db_id}">
                        <img src="display/images/edit.gif" height="20">
                    </a>
                </div>
            </td>
            {/if}
            <td>
                {if $dataAnomalie[lst].poisson_id > 0}
                <a href="poissonDisplay?poisson_id={$dataAnomalie[lst].poisson_id}">
                    {$dataAnomalie[lst].matricule}
                    {if strlen($dataAnomalie[lst].matricule) == 0}
                    {$dataAnomalie[lst].prenom}
                    {if strlen($dataAnomalie[lst].prenom) == 0}
                    {$dataAnomalie[lst].pittag_valeur}
                    {/if}
                    {/if}
                </a>
                {/if}
            <td>
                {if $dataAnomalie[lst].evenement_id > 0 && $rights["poissonGestion"] == 1}
                <a
                    href="evenementChange?poisson_id={$dataAnomalie[lst].poisson_id}&evenement_id={$dataAnomalie[lst].evenement_id}">
                    {$dataAnomalie[lst].evenement_type_libelle}
                </a>
                {else}
                {$dataAnomalie[lst].evenement_type_libelle}
                {/if}
            </td>
            <td>{$dataAnomalie[lst].anomalie_db_type_libelle}</td>
            <td>{$dataAnomalie[lst].anomalie_db_date}</td>
            <td>{$dataAnomalie[lst].anomalie_db_commentaire}</td>
            <td>{$dataAnomalie[lst].anomalie_db_date_traitement}</td>
            <td>
                <div class="center">
                    {if $dataAnomalie[lst].anomalie_db_statut == 1}
                    <img src="display/images/ok_icon.png" height="20">
                    {else}
                    <img src="display/images/cross.png" height="20">
                    {/if}
                </div>
            </td>
        </tr>
        {/section}
    </tbody>
</table>
{/if}