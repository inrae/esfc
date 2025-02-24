<h2>{t}Modification d'une méthode de détermination du sexe{/t}</h2>

<a href="genderMethodeList">{t}Retour à la liste{/t}</a>
<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="genderMethodeForm" method="post" action="genderMethodeWrite">            
            <input type="hidden" name="moduleBase" value="genderMethode">
            <input type="hidden" name="gender_methode_id" value="{$data.gender_methode_id}">
            <div class="form-group">
                <label for="cgender_methode_libelle" class="control-label col-md-4">
                    {t}Nom de la méthode de détermination du sexe :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="cgender_methode_libelle" class="form-control" name="gender_methode_libelle" type="text"
                        value="{$data.gender_methode_libelle}" required autofocus />
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.gender_methode_id > 0 &&$rights["paramAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        {$csrf}</form>
    </div>
</div>


<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>