<h2>{t}Importation des résultats d'analyse des circuits d'eau à partir des fichiers de sonde{/t}</h2>

<div class="row">
    <div class="col-md-6">
        <form id="documentForm" class="form-horizontal" method="post" action="sondeExec" enctype="multipart/form-data">
            <div class="form-group">
                <label for="sonde_id" class="control-label col-md-4">{t}Modèle d'importation :{/t}</label>
                <div class="col-md-8">
                    <select id="sonde_id" class="form-control" name="sonde_id">
                        {foreach $sondes as $sonde}
                        <option value="{$sonde.sonde_id}" {if $sonde.sonde_id==$sonde_id}selected{/if}>
                            {$sonde.sonde_name}
                        </option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="sondeFileName" class="control-label col-md-4">
                    {t}Fichier(s) à importer :(xlsx, csv){/t}
                </label>
                <div class="col-md-8">
                    <input id="sondeFileName" class="form-control" type="file" name="sondeFileName[]" multiple required>
                    </dd>
                </div>
            </div>
            <div class="form-group">
                <div class="center">
                    <input type="submit" class="btn btn-primary button-valid" value="{t}Importer les données de sonde{/t}">
                </div>
            </div>
        {$csrf}</form>
    </div>
</div>