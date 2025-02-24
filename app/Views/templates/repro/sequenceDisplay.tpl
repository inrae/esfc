<script>
    $(document).ready(function () {
        var moduleName = "sequenceDisplay";
        var localStorage = window.localStorage;
        try {
            activeTab = localStorage.getItem(moduleName + "Tab");
        } catch (Exception) {
            activeTab = "";
        }
        try {
            if (activeTab.length > 0) {
                $("#" + activeTab).tab('show');
            }
        } catch (Exception) { }
        $('a[data-toggle="tab"]').on('shown.bs.tab', function () {
            localStorage.setItem(moduleName + "Tab", $(this).attr("id"));
        });
        $(".ok").each(function (i, e) {
			try {
				if ($.fn.dataTable.Api(this).data().count()) {
					$("#" + $(this).data("tabicon")).show();
				}
			} catch { };
		});
    });
</script>

<a href="sequenceList">
    <img src="display/images/repro.png" height="25">
    {t}Retour à la liste des séquences{/t}
</a>
{if $rights["reproGestion"]==1}
&nbsp;
<a href="sequenceChange?sequence_id={$dataSequence.sequence_id}">
    <img src="display/images/edit.gif" height="25">
    {t}Modifier les informations générales de la séquence...{/t}
</a>
{/if}
<h2>{t}Détail de la séquence{/t}
    {$dataSequence.annee} {$dataSequence.sequence_date_debut} - {$dataSequence.site_name} {$dataSequence.sequence_nom}
</h2>
<div class="row">
    <div class="col-xs-12">
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item active">
                <a class="nav-link" id="tab-poisson" href="#nav-poisson" data-toggle="tab" role="tab"
                    aria-controls="nav-poisson" aria-selected="false">
                    <img src="display/images/fish.svg" height="25">
                    {t}Poissons rattachés{/t}
                    <img id="oksequence" src="display/images/ok_icon.png" height="15" hidden>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-croisement" href="#nav-croisement" data-toggle="tab" role="tab"
                    aria-controls="nav-croisement" aria-selected="false">
                    <img src="display/images/repro.png" height="25">
                    {t}Croisements réalisés{/t}
                    <img id="okcroisement" src="display/images/ok_icon.png" height="15" hidden>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-lots" href="#nav-lots" data-toggle="tab" role="tab" aria-controls="nav-lots"
                    aria-selected="false">
                    <img src="display/images/fishlot.svg" height="25">
                    {t}Lots issus des croisements{/t}
                    <img id="oklot" src="display/images/ok_icon.png" height="15" hidden>
                </a>
            </li>
        </ul>
        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane active in" id="nav-poisson" role="tabpanel" aria-labelledby="tab-poisson">
                {include file="repro/sequencePoissonList.tpl"}
            </div>
            <div class="tab-pane fade" id="nav-croisement" role="tabpanel" aria-labelledby="tab-croisement">
                {include file="repro/croisementList.tpl"}
            </div>
            <div class="tab-pane fade" id="nav-lots" role="tabpanel" aria-labelledby="tab-lots">
                {include file="repro/lotList.tpl"}
            </div>
        </div>
    </div>
</div>