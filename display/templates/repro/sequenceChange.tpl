<a href="index.php?module=sequenceList">
    <img src="display/images/list.png" height="25">
    {t}Retour à la liste des séquences{/t}
</a>
<h2>{t}Modification d'une séquence{/t}</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="sequenceForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="sequence">
            <input type="hidden" name="sequence_id" value="{$data.sequence_id}">

            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Année :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="annee" class="form-control" name="annee" readonly size="10" maxlength="10"
                        value="{$data.annee}">
                </div>
            </div>
            <div class="form-group">
                <label for="site_id" class="control-label col-md-4">
                    {t}Site :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <select class="form-control" id="site_id" name="site_id">
                        {section name=lst loop=$site}
                        <option value="{$site[lst].site_id}" } {if $site[lst].site_id==$data.site_id}selected{/if}>
                            {$site[lst].site_name}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Nom de la séquence :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="sequence_nom" class="form-control" name="sequence_nom" required
                        value="{$data.sequence_nom}">
                </div>
            </div>
            <div class="form-group">
                <label for="sequence_date_debut" class="control-label col-md-4">
                    {t}Date de début de la séquence :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="sequence_date_debut" class="form-control datepicker" name="sequence_date_debut" required
                        value="{$data.sequence_date_debut}">
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.sequence_id > 0 &&$droits["reproAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>