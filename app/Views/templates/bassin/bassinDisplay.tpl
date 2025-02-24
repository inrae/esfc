<script>
    $(document).ready(function () {
        /**
           * Management of tabs
           */
        var moduleName = "bassinDisplay";
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
    });
</script>

<h2>{t}Détail du bassin{/t} {$dataBassin.bassin_nom}</h2>
<a href="{$bassinParentModule}">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-xs-12">
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item active">
                <a class="nav-link" id="tab-detail" data-toggle="tab" role="tab" aria-controls="nav-detail"
                    aria-selected="true" href="#nav-detail">
                    <img src="display/images/zoom.png" height="25">
                    {t}Détails{/t}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-fish" href="#nav-fish" data-toggle="tab" role="tab" aria-controls="nav-fish"
                    aria-selected="false">
                    <img src="display/images/fish.png" height="25">
                    {t}Poissons présents{/t}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-event" href="#nav-event" data-toggle="tab" role="tab"
                    aria-controls="nav-event" aria-selected="false">
                    <img src="display/images/event.png" height="25">
                    {t}Événements{/t}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-file" href="#nav-file" data-toggle="tab" role="tab" aria-controls="nav-file"
                    aria-selected="false">
                    <img src="display/images/files.png" height="25">
                    {t}Fichiers{/t}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="tab-aliment" href="#nav-aliment" data-toggle="tab" role="tab"
                    aria-controls="nav-aliment" aria-selected="false">
                    <img src="display/images/shrimp.png" height="25">
                    {t}Aliments{/t}
                </a>
            </li>
        </ul>
        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane active in" id="nav-detail" role="tabpanel" aria-labelledby="tab-detail">
                {if $rights["bassinGestion"]==1}
                <div class="row">
                    <a href="bassinChange?bassin_id={$dataBassin.bassin_id}">
                        {t}Modifier...{/t}
                    </a>
                </div>
                {/if}
                {include file="bassin/bassinDetail.tpl"}
            </div>
            <div class="tab-pane fade" id="nav-fish" role="tabpanel" aria-labelledby="tab-fish">
                {include file="bassin/bassinPoissonPresent.tpl"}
            </div>
            <div class="tab-pane fade" id="nav-event" role="tabpanel" aria-labelledby="tab-event">
                {include file="bassin/bassinEvenementList.tpl"}
            </div>
            <div class="tab-pane fade" id="nav-file" role="tabpanel" aria-labelledby="tab-file">
                {include file="document/documentList.tpl"}
            </div>
            <div class="tab-pane fade" id="nav-aliment" role="tabpanel" aria-labelledby="tab-aliment">
                {include file="bassin/bassinAlimentConsomme.tpl"}
            </div>
        </div>
    </div>
</div>
</div>