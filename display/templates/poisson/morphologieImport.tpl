<h2>{t}Importation de mesures de morphologie à partir d'un fichier CSV{/t}</h2>
<!-- Lancement de l'import -->
{if $controleOk == 1}
<div class="row col-md-8">
    <form id="importForm" method="post" action="index.php">
        <input type="hidden" name="module" value="morphologieImportExec">
        {t}Contrôles OK.{/t} {t 1=$filename}Vous pouvez réaliser l'import du fichier (%1) :{/t}
        <button type="submit" class="btn btn-danger">{t}Déclencher l'import{/t}</button>
    </form>
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
        <form class="form-horizontal" id="controlForm" method="post" action="index.php" enctype="multipart/form-data">
            <input type="hidden" name="module" value="morphologieImportControl">
            <div class="form-group">
                <label for="upfile" class="control-label col-md-4"><span class="red">*</span>
                    {t}Nom du fichier à importer (CSV) :{/t}
                </label>
                <div class="col-md-8">
                    <input type="file" name="upfile" required>
                </div>
            </div>
            <div class="form-group">
                <label for="separator" class="control-label col-md-4">{t}Séparateur utilisé :{/t}</label>
                <div class="col-md-8">
                    <select id="separator" name="separator">
                        <option value="," {if $separator=="," }selected{/if}>{t}Virgule{/t}</option>
                        <option value=";" {if $separator==";" }selected{/if}>{t}Point-virgule{/t}</option>
                        <option value="tab" {if $separator=="tab" }selected{/if}>{t}Tabulation{/t}</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="utf8_encode" class="control-label col-md-4">{t}Encodage du fichier :{/t}</label>
                <div class="col-md-8">
                    <select id="utf8_encode" name="utf8_encode">
                        <option value="0" {if $utf8_encode==0}selected{/if}>UTF-8</option>
                        <option value="1" {if $utf8_encode==1}selected{/if}>ISO-8859-x</option>
                    </select>
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary">{t}Vérifier le fichier{/t}</button>
            </div>
        </form>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="bg-info">
            {t}Ce module permet d'importer des mesures réalisées sur les poissons à partir d'un fichier CSV, et crée les événements correspondants.{/t}
            <br>
            {t}Il n'accepte que des fichiers au format CSV. La ligne d'entête doit comprendre exclusivement les colonnes suivantes :{/t}
            <br>
            <ul>
                <li><b>pittag</b><span class="red">*</span> : {t}PITTAG du poisson{/t}</li>
                <li><b>date</b><span class="red">*</span> : {t}Date de mesure (format dd/mm/yyyy){/t}</li>
                <li><b>length</b> : {t}Longueur totale mesurée, en cm{/t}</li>
                <li><b>fork_length</b> : {t}Longueur fourche mesurée, en cm{/t}</li>
                <li><b>weight</b> : {t}Poids mesuré, en grammes{/t}</li>
            </ul>
            <span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>
        </div>
    </div>
</div>