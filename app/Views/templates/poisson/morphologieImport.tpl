<script>
    $(document).ready(function () {
        var localStorage = window.localStorage;
        var storagename = "morphoImportHeaderNumber";
        var headernumber;
        var separator;
        try {
            headernumber = localStorage.getItem(storagename);
        } catch (Exception) {
            headernumber = 7;
        }
        if (!headernumber) {
            headernumber = 7;
        }
        $("#headernumber").val(headernumber);
        $("#headernumber").change(function () {
            localStorage.setItem(storagename, $(this).val());
        });

        var separatorname = "morphoImportSeparator";
        try {
            separator = localStorage.getItem(separatorname);
        } catch (Exception) {
            separator = ";";
        }
        if (!separator) {
            separator = ";";
        }
        $("#separator").val(separator);
        $("#separator").change(function () {
            localStorage.setItem(separatorname, $(this).val());
        });
        $(".source").draggable({
            revert: "invalid",
            cursor: "move",
            helper: "clone"
        });
        $(".dest").droppable({
            hoverClass: "ui-state-active",
            drop: function (event, ui) {
                var content = $("input", ui.draggable).val();
                $("input", ui.draggable).val("");
                if (content === undefined) {
                    content = ui.draggable.text();
                    $(ui.draggable).addClass("blue");
                }
                $("input", this).val(content);
            }
        });
    });
</script>
<h2>{t}Importation de mesures de morphologie à partir d'un fichier CSV{/t}</h2>

<!-- Appariement-->
{if $matching == 1}
<form id="matching" method="post" action="morphologieImportControl">
    <div class="row">
        <fieldset class="col-md-6">
            <legend>{t}Appariement des colonnes{/t}</legend>
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>{t}Nom du champ utilisé dans l'application{/t}</th>
                        <th>{t}Nom de la colonne correspondante dans le fichier{/t}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $columns as $column}
                    <tr>
                        <td>{$column}</td>
                        <td class="dest">
                            <input id="{$column}" name="{$column}" value="" class="form-control">
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </fieldset>
        <fieldset class="col-md-6">
            <legend>{t}Colonnes dans le fichier d'origine{/t}</legend>
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>{t}Nom de la colonne{/t}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $headerFile as $column}
                    <tr>
                        <td class="source">{$column}</td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </fieldset>
    </div>
    <div class="row">
        <div class="form-group center">
            <button type="submit" class="btn btn-primary">{t}Vérifier le fichier{/t}</button>
        </div>
    </div>
    <div class="row">
        <div class="bg-info col-md-6">
            {t}Indiquez le nom de la colonne présente dans le fichier à charger en face de chaque colonne attendue.{/t}
            <br>
            {t}Vous pouvez utiliser la souris pour déplacer les libellés du tableau de droite vers le tableau de gauche.{/t}
        </div>
    </div>
    
{$csrf}</form>
{/if}

<!-- Lancement de l'import -->
{if $controleOk == 1}
<div class="row col-md-8">
    <form id="importForm" method="post" action="morphologieImportExec">
        {t}Contrôles OK.{/t} {t 1=$filename}Vous pouvez réaliser l'import du fichier (%1) :{/t}
        <button type="submit" class="btn btn-danger">{t}Déclencher l'import{/t}</button>
    {$csrf}</form>
</div>
{/if}

<!-- Affichage des erreurs decouvertes -->
{if $erreur == 1}
<div class="row col-md-12">
    <table id="containerList" class="table table-bordered table-hover datatable ">
        <thead>
            <tr>
                <th>{t}N° de ligne{/t}</th>
                <th>{t}Anomalie(s) détectée(s){/t}</th>
            </tr>
        </thead>
        <tbody>
            {section name=lst loop=$erreurs}
            <tr>
                <td class="center">{$erreurs[lst].line}</td>
                <td>{$erreurs[lst].message}</td>
            </tr>
            {/section}
        </tbody>
    </table>
</div>
{/if}

<!-- Selection du fichier a importer -->

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="controlForm" method="post" action="morphologieImportMatching" enctype="multipart/form-data">
            <div class="form-group">
                <label for="upfile" class="control-label col-md-4"><span class="red">*</span>
                    {t}Nom du fichier à importer (CSV) :{/t}
                </label>
                <div class="col-md-8">
                    <input type="file" name="upfile" class="form-control" required>
                </div>
            </div>
            <div class="form-group">
                <label for="separator" class="control-label col-md-4">{t}Séparateur utilisé :{/t}</label>
                <div class="col-md-8">
                    <select id="separator" name="separator" class="form-control">
                        <option value="," >{t}Virgule{/t}</option>
                        <option value=";" >{t}Point-virgule{/t}</option>
                        <option value="tab" >{t}Tabulation{/t}</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="headernumber" class="control-label col-md-4"><span class="red">*</span>
                    {t}Numéro de la ligne contenant l'entête :{/t}
                </label>
                <div class="col-md-8">
                    <input type="number" class="form-control" name="headernumber" id="headernumber" value="" required>
                </div>
            </div>
            <div class="form-group">
                <label for="utf8_encode" class="control-label col-md-4">{t}Encodage du fichier :{/t}</label>
                <div class="col-md-8">
                    <select class="form-control" id="utf8_encode" name="utf8_encode">
                        <option value="0" {if $utf8_encode==0}selected{/if}>UTF-8</option>
                        <option value="1" {if $utf8_encode==1}selected{/if}>ISO-8859-x</option>
                    </select>
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary">{t}Apparier les colonnes{/t}</button>
            </div>
        {$csrf}</form>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="bg-info">
            {t}Ce module permet d'importer des mesures réalisées sur les poissons à partir d'un fichier CSV, et crée les événements correspondants.{/t}
            <br>
            {t}Il n'accepte que des fichiers au format CSV. La ligne d'entête doit comprendre les colonnes suivantes :{/t}
            <br>
            <ul>
                <li><b>pittag</b><span class="red">*</span> : {t}PITTAG du poisson{/t}</li>
                <li><b>date</b><span class="red">*</span> : {t}Date de mesure (format dd/mm/yyyy){/t}</li>
                <li><b>length</b> : {t}Longueur totale mesurée, en cm{/t}</li>
                <li><b>fork_length</b> : {t}Longueur fourche mesurée, en cm{/t}</li>
                <li><b>weight</b> : {t}Poids mesuré, en grammes{/t}</li>
            </ul>
            {t}Le nom des colonnes dans le fichier peut être différent, un mécanisme d'appariement est proposé pendant l'importation{/t}
            <span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>
        </div>
    </div>
</div>
