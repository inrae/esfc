<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">
    <img src="display/images/list.png" height="25">
    {t}Retour à la liste des poissons{/t}
</a>
<a
    href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}&sequence_id={$data.sequence_id}">
    <img src="display/images/fish.svg" height="25">
    {t}Retour au reproducteur{/t}
</a>
<h2>{t}Données du poisson pour la séquence considérée{/t} {$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur} -
	{$dataPoisson.sexe_libelle}
	{if $dataPoisson.poisson_statut_id != 1}- {$dataPoisson.poisson_statut_libelle}{/if}</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="poissonSequenceForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="poissonSequence">
            <input type="hidden" name="poisson_sequence_id" value="{$data.poisson_sequence_id}">
            <input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
            <div class="form-group">
                <label for="sequence_id" class="control-label col-md-4">
                    {t}Séquence de reproduction :{/t}
                    <span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <select id="sequence_id" class="form-control" name="sequence_id">
                        {section name=lst loop=$sequences}
                        <option value="{$sequences[lst].sequence_id}" {if
                            $sequences[lst].sequence_id==$data.sequence_id}selected{/if}>
                            {$sequences[lst].site_name} - {$sequences[lst].sequence_nom}
                            ({$sequences[lst].sequence_date_debut})
                        </option>
                        {/section}
                    </select>

                </div>
            </div>
            <div class="form-group">
                <label for="ps_statut_id" class="control-label col-md-4">
                    {t}Statut du poisson pour la séquence :{/t}
                </label>
                <div class="col-md-8">
                    <select id="ps_statut_id" class="form-control" name="ps_statut_id">
                        {section name=lst loop=$statuts}
                        <option value="{$statuts[lst].ps_statut_id}" {if
                            $statuts[lst].ps_statut_id==$data.ps_statut_id}selected{/if}>
                            {$statuts[lst].ps_statut_libelle}
                        </option>
                        {/section}
                    </select>

                </div>
            </div>
            <div class="form-group"></div>
            {if $dataPoisson.sexe_id == 2}
            <div class="form-group">
                <label for="ovocyte_expulsion_date" class="control-label col-md-4">
                    {t}Date de l'expulsion des ovocytes :{/t}
                </label>
                <div class="col-md-8">
                    <input id="ovocyte_expulsion_date" class="datepicker form-control" name="ovocyte_expulsion_date"
                        value="{$data.ovocyte_expulsion_date}">
                    <input class="timepicker form-control" name="ovocyte_expulsion_time"
                        value="{$data.ovocyte_expulsion_time}">
                </div>
            </div>
            <div class="form-group">
                <label for="ovocyte_masse" class="control-label col-md-4">
                    {t}Masse totale des ovocytes (grammes) :{/t}
                </label>
                <div class="col-md-8">
                    <input id="ovocyte_masse" class="form-control" class="taux" name="ovocyte_masse"
                        value="{$data.ovocyte_masse}">
                </div>
            </div>
            {/if}
            {if $dataPoisson.sexe_id == 1}
            <fieldset>
                <legend>{t}Prélèvements de sperme{/t}</legend>
                <a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
                    {t}Accédez à la fiche du poisson pour réaliser la saisie{/t}
                </a>
            </fieldset>
            {/if}
            {if $droits.reproGestion == 1}
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.poisson_sequence_id > 0 && $droits["reproAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
                {/if}
            </div>
        </form>
    </div>
    <div class="col-md-6">
        {if $data.poisson_sequence_id > 0}
        {if $droits.reproGestion == 1 }
        <a
            href="index.php?module=psEvenementChange&ps_evenement_id=0&poisson_sequence_id={$data.poisson_sequence_id}&sequence_id={$data.sequence_id}">
            <img src="display/images/event.png" height="25">
            {t}Nouvel événement...{/t}
        </a>
        {if $ps_evenement_id > -1}
        {include file="repro/psEvenementChange.tpl"}
        {/if}
        {/if}
        <div class="row">
            <table id="cpsEvenement" class="table table-hover table-bordered datatable-nopaging-nosearching">
                <thead>
                    <tr>
                        <th>{t}Date{/t}</th>
                        <th>{t}Libellé{/t}</th>
                        <th>{t}Commentaire{/t}</th>
                    </tr>
                </thead>
                <tbody>
                    {section name=lst loop=$evenements}
                    <tr>
                        <td>
                            {if $droits.reproGestion == 1}
                            <a
                                href="index.php?module=psEvenementChange&ps_evenement_id={$evenements[lst].ps_evenement_id}&poisson_sequence_id={$data.poisson_sequence_id}&sequence_id={$data.sequence_id}">
                                {$evenements[lst].ps_datetime}
                            </a>
                            {else}
                            {$evenements[lst].ps_datetime}
                            {/if}
                        </td>
                        <td>{$evenements[lst].ps_libelle}</td>
                        <td>{$evenements[lst].ps_commentaire}</td>
                    </tr>
                    {/section}
                </tbody>
            </table>
        </div>
        {/if}
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>