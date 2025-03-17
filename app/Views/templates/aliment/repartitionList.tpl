<h2>{t}Liste des répartitions d'aliments{/t}</h2>
{include file="aliment/repartitionSearch.tpl"}
{if $isSearch == 1}
<div class="row">
    <div class="col-md-6">
        <table class="table table-bordered table-hover datatable-nopaging display" id="repartitionList">
            <thead>
                <tr>
                    {if $rights.bassinGestion == 1}
                    <th>{t}Modif{/t}</th>
                    {/if}
                    <th>{t}Catégorie{/t}</th>
                    <th>{t}Nom{/t}</th>
                    <th>{t}Date début{/t}</th>
                    <th>{t}Date fin{/t}</th>
                    {if $rights.bassinGestion == 1}
                    <th>{t}Saisir les restes{/t}</th>
                    <th>{t}Dupliquer{/t}</th>
                    {/if}
            </thead>
            <tbody>
                {section name=lst loop=$dataList}
                <tr>
                    {if $rights.bassinGestion == 1}
                    <td class="center">
                        <a href="repartitionChange?repartition_id={$dataList[lst].repartition_id}">
                            <img src="display/images/edit.gif" height="20">
                        </a>
                    </td>
                    {/if}
                    <td>{$dataList[lst].categorie_libelle}</td>
                    <td>{$dataList[lst].repartition_name}</td>
                    <td>{$dataList[lst].date_debut_periode}</td>
                    <td>{$dataList[lst].date_fin_periode}</td>
                    {if $rights.bassinGestion == 1}
                    <td class="center">
                        <a href="repartitionResteChange?repartition_id={$dataList[lst].repartition_id}"
                            title="Saisir les restes pour la période considérée">
                            <img src="display/images/bin.png" height="20">
                        </a>
                    <td>
                        <a href="repartitionDuplicate?repartition_id={$dataList[lst].repartition_id}"
                            title="Créer une nouvelle répartition à partir de celle-ci">
                            <div class="center"><img src="display/images/copy.png" height="20"></div>
                        </a>
                    </td>
                    {/if}
                </tr>
                {/section}
            </tbody>
        </table>
    </div>
    <div class="col-md-6">
        {if $isSearch == 1 && $rights.bassinGestion == 1}
        <h3>Créer une nouvelle répartition vierge</h3>
        {include file="aliment/repartitionCreate.tpl"}
        {/if}
    </div>
</div>
{/if}