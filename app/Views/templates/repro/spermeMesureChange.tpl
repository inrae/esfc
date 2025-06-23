{if $poissonDetailParent > 0}
<a href="{$poissonDetailParent}?sequence_id={$sequence_id}">
    <img src="display/images/display.png" height="25">
    {t}Retour à la liste des poissons{/t}
</a>&nbsp;
{/if}
<a href="poissonCampagneDisplay?poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
    <img src="display/images/fish.svg" height="25">
    {t}Retour au reproducteur{/t}
</a>
&nbsp;
<a href="spermeChange?sperme_id={$data.sperme_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
    <img src="display/images/eprouvette.png" height="25">
    {t}Retour au prélèvement{/t}
</a>
<h2>{t}Modification de l'analyse du prélèvement{/t} {$dataPoisson.matricule}
    {$dataPoisson.categorie_libelle}
    {$dataPoisson.sexe_libelle}
    {$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})
</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="spermeMesureForm" method="post" action="spermeMesureWrite">            
            <input type="hidden" name="moduleBase" value="spermeMesure">
            <input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
            {include file="repro/spermeMesureChangeCorps.tpl"}
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.sperme_mesure_id > 0 &&$rights["reproGestion"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        {$csrf}</form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>