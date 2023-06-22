<a href="index.php?module=sequenceList">
    <img src="display/images/list.png" height="25">
    Retour à la liste des séquences
</a>
&nbsp;
<a href="index.php?module=sequenceDisplay&sequence_id={$data.sequence_id}">
    <img src="display/images/sexe.svg" height="25">
    {t}Retour à la séquence{/t}
    {$dataSequence.annee} {$dataSequence.sequence_date_debut} - {$dataSequence.site_name} {$dataSequence.sequence_nom}
</a>

<h2>{t}Détail du croisement{/t} <i>{$data.parents}</i></h2>
<div class="col-md-4">
    {if $droits.reproGestion == 1}
    <a href="index.php?module=croisementChange&croisement_id={$data.croisement_id}&sequence_id={$data.sequence_id}">
        <img src="display/images/edit.gif" height="25">
        {t}Modifier...{/t}
    </a>
    {/if}
    <div class="dl-horizontal form-display">
        <dl>
            <dt>{t}Date/heure de la fécondation :{/t}</dt>
            <dd>
                {$data.croisement_date}
            </dd>
        </dl>
        <dl>
            <dt>{t}Nom du croisement :{/t}</dt>
            <dd>
                {$data.croisement_nom}
            </dd>
        </dl>
        <dl>
            <dt>{t}Masse des ovocytes (en grammes) :{/t}</dt>
            <dd>{$data.ovocyte_masse}
            </dd>
        </dl>
        <dl>
            <dt>{t}Nbre ovocytes par gramme :{/t}</dt>
            <dd>{$data.ovocyte_densite}
            </dd>
        </dl>
        <dl>
            <dt>{t}Taux de fécondation :{/t}</dt>
            <dd>{$data.tx_fecondation}
            </dd>
        </dl>
        <dl>
            <dt>{t}Taux de survie estimé :{/t}</dt>
            <dd>{$data.tx_survie_estime}
            </dd>
        </dl>
        <dl>
            <dt>{t}Qualité génétique du croisement :{/t}</dt>
            <dd>
                {$data.croisement_qualite_libelle}
            </dd>
        </dl>
    </div>
</div>
<div class="col-md-8">
    <fieldset>
        <legend>{t}Liste des spermes utilisés{/t}</legend>
        {include file="repro/spermeUtiliseList.tpl"}
    </fieldset>
</div>