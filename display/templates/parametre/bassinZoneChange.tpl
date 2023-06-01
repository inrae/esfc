<h2>{t}Modification d'une zone d'implantation des bassins{/t}</h2>

<a href="index.php?module=bassinZoneList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="bassinZoneForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="bassinZone">
            <input type="hidden" name="bassin_zone_id" value="{$data.bassin_zone_id}">
            <div class="form-group">
                <label for="cbassin_zone_libelle" class="control-label col-md-4">
                    {t}Zone d'implantation :{/t}<span class="red">*</span> </label>
                <div class="col-md-8">
                    <input id="cbassin_zone_libelle" class="form-control" name="bassin_zone_libelle" type="text"
                        value="{$data.bassin_zone_libelle}" required autofocus />
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.bassin_zone_id > 0 &&$droits["paramAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>