<script>
    $(document).ready(function () {
        $("#checkPoissonSelect").change(function () {
            $(".checkPoisson").prop("checked", this.checked);
        });
        $("#checkedButtonFish").on("keypress click", function (event) {
            var bassinDest = $("#bassin_destination").val();
            if (bassinDest > 0) {
                var nbchecked = $(".checkPoisson:checked").length;
                if (nbchecked > 0) {
                    var conf = confirm("{t}Attention : cette opération est définitive. Est-ce bien ce que vous voulez faire ?{/t}");
                    if (conf) {
                        $(this.form).prop('target', '_self').submit();
                    } else {
                        event.preventDefault();
                    }
                } else {
                    alert("{t}Aucun poisson sélectionné !{/t}");
                    event.preventDefault();
                }
            } else {
                alert("{t}Vous devez sélectionner le bassin de destination{/t}");
                event.preventDefault();
            }
        });
    });
</script>
<form id="fBassinPoisson" action="index.php" method="post">
    <input type="hidden" name="module" value="bassinPoissonTransfert">
    <input type="hidden" name="bassin_id" value="{$dataBassin.bassin_id}">
    <table id="cbassinPoissonList" class="table table-bordered table-hover datatable-nopaging" data-order='[[1,"asc"]]'>
        <thead>
            <tr>
            <tr>{if $droits.bassinGestion == 1}
                <th class="center">
                    <input type="checkbox" id="checkPoissonSelect">
                </th>
                {/if}
                <th>{t}matricule{/t}</th>
                <th>{t}tag(s){/t}</th>
                <th>{t}prénom{/t}</th>
                <th>{t}Sexe{/t}</th>
                <th>{t}Cohorte{/t}</th>
                <th>{t}Date d'arrivée{/t}</th>
                <th>{t}Masse{/t}</th>
            </tr>
        </thead>
        <tbody>
            {assign var=mt value=0}
            {section name=lst loop=$dataPoisson}
            <tr>
                {if $droits.bassinGestion == 1}
                <td class="center">
                    <input type="checkbox" class="checkPoisson" name="poissons[]"
                        value="{$dataPoisson[lst].poisson_id}">
                </td>
                {/if}
                <td>
                    <a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson[lst].poisson_id}">
                        {$dataPoisson[lst].matricule}
                    </a>
                </td>
                <td>{$dataPoisson[lst].pittag_valeur}</td>
                <td>
                    {$dataPoisson[lst].prenom}
                </td>
                <td>{$dataPoisson[lst].sexe_libelle_court}</td>
                <td>{$dataPoisson[lst].cohorte}</td>
                <td>{$dataPoisson[lst].transfert_date}</td>
                <td>{$dataPoisson[lst].masse}</td>
                {if $dataPoisson[lst].masse > 0}
                {assign var=mt value=$mt + $dataPoisson[lst].masse}
                {/if}
            </tr>
            {/section}
        </tbody>
        <tfoot>
            <td colspan="7">Masse totale des poissons dans le bassin :</td>
            <td>{$mt}</td>
        </tfoot>
    </table>
    <div class="col-md-8 col-lg-6">
        <input type="hidden" name="bassin_origine" value="{$dataBassin.bassin_id}">
        <div class="form-horizontal">
            <div class="form-group">
                <label for="bassin_destination" class="control-label col-md-4">
                    {t}Déplacez les poissons sélectionnés vers le bassin :{/t}
                </label>
                <div class="col-md-8">
                    <select class="form-control" name="bassin_destination" id="bassin_destination">
                        <option value="" selected>
                            {t}Sélectionnez le bassin de destination...{/t}
                        </option>
                        {section name=lst loop=$bassinListActif}
                        {if $bassinListActif[lst].bassin_id != $dataBassin.bassin_id}
                        <option value="{$bassinListActif[lst].bassin_id}">
                            {$bassinListActif[lst].bassin_nom}
                        </option>
                        {/if}
                        {/section}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="evenement_type_id" class="control-label col-md-4">
                    {t}Type d'événement :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <select id="evenement_type_id" class="form-control" name="evenement_type_id">
                        {section name=lst loop=$evntType}
                        <option value="{$evntType[lst].evenement_type_id}" {if
                            $evntType[lst].evenement_type_id==24}selected{/if}>
                            {$evntType[lst].evenement_type_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="cevenement_date" class="control-label col-md-4">
                    {t}Date :{/t}
                    <span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input class="form-control datepicker" name="evenement_date" id="cevenement_date" required
                        value="{$currentDate}">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">{t}Commentaire :{/t}</label>
                <div class="col-md-8">
                    <input id="" class="form-control" name="transfert_commentaire" value="">

                </div>
            </div>
            <div class="center">
                <button id="checkedButtonFish" class="btn btn-danger">{t}Réaliser le transfert{/t}</button>
            </div>
        </div>
    </div>
</form>