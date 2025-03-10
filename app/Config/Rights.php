<?php

namespace App\Config;

use Ppci\Config\RightsPpci;

/**
 * List of all rights required by modules
 */
class Rights extends RightsPpci
{
    protected array $rights = [
        "pittagTypeList" => ["consult"],
        "pittagTypeChange" => ["paramAdmin"],
        "pittagTypeWrite" => ["paramAdmin"],
        "pittagTypeDelete" => ["paramAdmin"],
        "poissonStatutList" => ["consult"],
        "poissonStatutChange" => ["paramAdmin"],
        "poissonStatutWrite" => ["paramAdmin"],
        "poissonStatutDelete" => ["paramAdmin"],
        "genderMethodeList" => ["consult"],
        "genderMethodeChange" => ["paramAdmin"],
        "genderMethodeWrite" => ["paramAdmin"],
        "genderMethodeDelete" => ["paramAdmin"],
        "evenementTypeList" => ["consult"],
        "evenementTypeChange" => ["paramAdmin"],
        "evenementTypeWrite" => ["paramAdmin"],
        "evenementTypeDelete" => ["paramAdmin"],
        "pathologieTypeList" => ["consult"],
        "pathologieTypeChange" => ["paramAdmin"],
        "pathologieTypeWrite" => ["paramAdmin"],
        "pathologieTypeDelete" => ["paramAdmin"],
        "morphologieImport" => ["manage"],
        "morphologieImportMatching" => ["manage"],
        "morphologieImportControl" => ["manage"],
        "morphologieImportExec" => ["manage"],
        "poissonList" => ["consult"],
        "poissonDisplay" => ["consult"],
        "poissonChange" => ["poissonGestion"],
        "poissonWrite" => ["poissonGestion"],
        "poissonDelete" => ["poissonAdmin"],
        "poissonSearchAjax" => ["consult"],
        "poissonGetFromTag" => ["consult"],
        "evenementChange" => ["poissonGestion"],
        "evenementWrite" => ["poissonGestion"],
        "evenementDelete" => ["poissonAdmin"],
        "evenementGetAllCSV" => ["consult"],
        "pittagChange" => ["poissonGestion"],
        "pittagWrite" => ["poissonGestion"],
        "pittagDelete" => ["poissonGestion"],
        "bassinTypeList" => ["consult"],
        "bassinTypeChange" => ["paramAdmin"],
        "bassinTypeWrite" => ["paramAdmin"],
        "bassinTypeDelete" => ["paramAdmin"],
        "bassinUsageList" => ["consult"],
        "bassinUsageChange" => ["paramAdmin"],
        "bassinUsageWrite" => ["paramAdmin"],
        "bassinUsageDelete" => ["paramAdmin"],
        "bassinZoneList" => ["consult"],
        "bassinZoneChange" => ["paramAdmin"],
        "bassinZoneWrite" => ["paramAdmin"],
        "bassinZoneDelete" => ["paramAdmin"],
        "bassinList" => ["consult"],
        "bassinListniv2" => ["consult"],
        "bassinDisplay" => ["consult"],
        "bassinChange" => ["bassinGestion"],
        "bassinWrite" => ["bassinGestion"],
        "bassinDelete" => ["bassinAdmin"],
        "bassinCalculMasseAjax" => ["consult"],
        "bassinRecapAlim" => ["consult"],
        "bassinPoissonTransfert" => ["bassinGestion"],
        "bassinEvenementChange" => ["bassinGestion"],
        "bassinEvenementWrite" => ["bassinGestion"],
        "bassinEvenementDelete" => ["bassinAdmin"],
        "circuitEvenementChange" => ["bassinGestion"],
        "circuitEvenementWrite" => ["bassinGestion"],
        "circuitEvenementDelete" => ["bassinAdmin"],
        "circuitEauList" => ["consult"],
        "circuitEauDisplay" => ["consult"],
        "circuitEauChange" => ["bassinGestion"],
        "circuitEauWrite" => ["bassinGestion"],
        "circuitEauDelete" => ["bassinAdmin"],
        "analyseEauDisplay" => ["consult"],
        "analyseEauChange" => ["bassinGestion"],
        "analyseEauWriteList" => ["bassinGestion"],
        "analyseEauDeleteList" => ["bassinGestion"],
        "analyseEauWrite" => ["bassinGestion"],
        "analyseEauDelete" => ["bassinAdmin"],
        "sondeImport" => ["bassinGestion"],
        "sondeExec" => ["bassinGestion"],
        "analyseGraph" => ["bassinGestion"],
        "mimeTypeList" => ["consult"],
        "mimeTypeChange" => ["paramAdmin"],
        "mimeTypeWrite" => ["paramAdmin"],
        "mimeTypeDelete" => ["paramAdmin"],
        "mortaliteTypeList" => ["consult"],
        "mortaliteTypeChange" => ["paramAdmin"],
        "mortaliteTypeWrite" => ["paramAdmin"],
        "mortaliteTypeDelete" => ["paramAdmin"],
        "cohorteTypeList" => ["consult"],
        "cohorteTypeChange" => ["paramAdmin"],
        "cohorteTypeWrite" => ["paramAdmin"],
        "cohorteTypeDelete" => ["paramAdmin"],
        "anomalieList" => ["consult"],
        "anomalieChange" => ["poissonGestion"],
        "anomalieWrite" => ["poissonAdmin"],
        "anomalieDelete" => ["poissonAdmin"],
        "poissonAnomalieWrite" => ["poissonGestion"],
        "poissonAnomalieDelete" => ["poissonAdmin"],
        "parentPoissonChange" => ["poissonGestion"],
        "parentPoissonWrite" => ["poissonGestion"],
        "parentPoissonDelete" => ["poissonAdmin"],
        "alimentTypeList" => ["consult"],
        "alimentTypeChange" => ["paramAdmin"],
        "alimentTypeWrite" => ["paramAdmin"],
        "alimentTypeDelete" => ["paramAdmin"],
        "anomalieDbTypeList" => ["consult"],
        "anomalieDbTypeChange" => ["paramAdmin"],
        "anomalieDbTypeWrite" => ["paramAdmin"],
        "anomalieDbTypeDelete" => ["paramAdmin"],
        "laboratoireAnalyseList" => ["consult"],
        "laboratoireAnalyseChange" => ["paramAdmin"],
        "laboratoireAnalyseWrite" => ["paramAdmin"],
        "laboratoireAnalyseDelete" => ["paramAdmin"],
        "bassinEvenementTypeList" => ["consult"],
        "bassinEvenementTypeChange" => ["paramAdmin"],
        "bassinEvenementTypeWrite" => ["paramAdmin"],
        "bassinEvenementTypeDelete" => ["paramAdmin"],
        "circuitEvenementTypeList" => ["consult"],
        "circuitEvenementTypeChange" => ["paramAdmin"],
        "circuitEvenementTypeWrite" => ["paramAdmin"],
        "circuitEvenementTypeDelete" => ["paramAdmin"],
        "sortieLieuList" => ["consult"],
        "sortieLieuChange" => ["paramAdmin"],
        "sortieLieuWrite" => ["paramAdmin"],
        "sortieLieuDelete" => ["paramAdmin"],
        "nageoireList" => ["consult"],
        "nageoireChange" => ["paramAdmin"],
        "nageoireWrite" => ["paramAdmin"],
        "nageoireDelete" => ["paramAdmin"],
        "hormoneList" => ["consult"],
        "hormoneChange" => ["paramAdmin", "reproAdmin"],
        "hormoneWrite" => ["paramAdmin", "reproAdmin"],
        "hormoneDelete" => ["paramAdmin", "reproAdmin"],
        "vieImplantationList" => ["consult"],
        "vieImplantationChange" => ["paramAdmin", "reproAdmin"],
        "vieImplantationWrite" => ["paramAdmin", "reproAdmin"],
        "vieImplantationDelete" => ["paramAdmin", "reproAdmin"],
        "metalList" => ["consult"],
        "metalChange" => ["paramAdmin", "bassinAdmin"],
        "metalWrite" => ["paramAdmin", "bassinAdmin"],
        "metalDelete" => ["paramAdmin", "bassinAdmin"],
        "anesthesieProduitList" => ["consult"],
        "anesthesieProduitChange" => ["paramAdmin", "reproAdmin"],
        "anesthesieProduitWrite" => ["paramAdmin", "reproAdmin"],
        "anesthesieProduitDelete" => ["paramAdmin", "reproAdmin"],
        "spermeDilueurList" => ["consult"],
        "spermeDilueurChange" => ["paramAdmin", "reproAdmin"],
        "spermeDilueurWrite" => ["paramAdmin", "reproAdmin"],
        "spermeDilueurDelete" => ["paramAdmin", "reproAdmin"],
        "spermeCaracteristiqueList" => ["consult"],
        "spermeCaracteristiqueChange" => ["paramAdmin", "reproAdmin"],
        "spermeCaracteristiqueWrite" => ["paramAdmin", "reproAdmin"],
        "spermeCaracteristiqueDelete" => ["paramAdmin", "reproAdmin"],
        "stadeOeufList" => ["consult"],
        "stadeOeufChange" => ["paramAdmin"],
        "stadeOeufWrite" => ["paramAdmin"],
        "stadeOeufDelete" => ["paramAdmin"],
        "stadeGonadeList" => ["consult"],
        "stadeGonadeChange" => ["paramAdmin"],
        "stadeGonadeWrite" => ["paramAdmin"],
        "stadeGonadeDelete" => ["paramAdmin"],
        "spermeConservateurList" => ["consult"],
        "spermeConservateurChange" => ["paramAdmin", "reproAdmin"],
        "spermeConservateurWrite" => ["paramAdmin", "reproAdmin"],
        "spermeConservateurDelete" => ["paramAdmin", "reproAdmin"],
        "alimentList" => ["consult"],
        "alimentChange" => ["bassinAdmin"],
        "alimentWrite" => ["bassinAdmin"],
        "alimentDelete" => ["bassinAdmin"],
        "categorieList" => ["consult"],
        "categorieChange" => ["bassinAdmin"],
        "categorieWrite" => ["bassinAdmin"],
        "categorieDelete" => ["bassinAdmin"],
        "repartTemplateList" => ["consult"],
        "repartTemplateChange" => ["bassinAdmin"],
        "repartTemplateWrite" => ["bassinAdmin"],
        "repartTemplateDelete" => ["bassinAdmin"],
        "repartitionList" => ["consult"],
        "repartitionChange" => ["bassinGestion"],
        "repartitionCreate" => ["bassinGestion"],
        "repartitionDuplicate" => ["bassinGestion"],
        "repartitionWrite" => ["bassinGestion"],
        "repartitionDelete" => ["bassinAdmin"],
        "repartitionPrint" => ["bassinGestion"],
        "repartitionResteChange" => ["bassinGestion"],
        "repartitionResteWrite" => ["bassinGestion"],
        "documentChange" => ["bassinGestion", "poissonGestion", "reproGestion"],
        "documentWrite" => ["bassinGestion", "poissonGestion", "reproGestion"],
        "documentDelete" => ["bassinGestion", "poissonGestion", "reproGestion"],
        "documentGet" => ["consult"],
        "documentChangeData" => ["bassinGestion", "poissonGestion", "reproGestion"],
        "documentWriteData" => ["bassinGestion", "poissonGestion", "reproGestion"],
        "repro" => ["reproConsult"],
        "poissonCampagneList" => ["reproConsult"],
        "poissonCampagneDisplay" => ["reproConsult"],
        "poissonCampagneChange" => ["reproGestion"],
        "poissonCampagneWrite" => ["reproGestion"],
        "poissonCampagneDelete" => ["reproAdmin"],
        "poissonCampagneChangeStatut" => ["reproGestion"],
        "poissonCampagneInit" => ["reproAdmin"],
        "poissonCampagneRecalcul" => ["reproGestion"],
        "sequenceList" => ["reproConsult"],
        "sequenceDisplay" => ["reproConsult"],
        "sequenceChange" => ["reproGestion"],
        "sequenceWrite" => ["reproGestion"],
        "sequenceDelete" => ["reproGestion"],
        "dosageSanguinChange" => ["reproGestion"],
        "dosageSanguinWrite" => ["reproGestion"],
        "dosageSanguinDelete" => ["reproGestion"],
        "biopsieChange" => ["reproGestion"],
        "biopsieWrite" => ["reproGestion"],
        "biopsieDelete" => ["reproGestion"],
        "poissonSequenceChange" => ["reproGestion"],
        "poissonSequenceWrite" => ["reproGestion"],
        "poissonSequenceDelete" => ["reproGestion"],
        "psEvenementChange" => ["reproGestion"],
        "psEvenementWrite" => ["reproGestion"],
        "psEvenementDelete" => ["reproGestion"],
        "bassinCampagneDisplay" => ["reproConsult"],
        "bassinCampagneDelete" => ["reproGestion"],
        "bassinCampagneWrite" => ["reproGestion"],
        "bassinCampagneInit" => ["reproGestion"],
        "echographieChange" => ["reproGestion"],
        "echographieWrite" => ["reproGestion"],
        "echographieDelete" => ["reproGestion"],
        "profilThermiqueChange" => ["reproGestion"],
        "profilThermiqueNew" => ["reproGestion"],
        "profilThermiqueWrite" => ["reproGestion"],
        "profilThermiqueDelete" => ["reproGestion"],
        "croisementChange" => ["reproGestion"],
        "croisementDisplay" => ["reproGestion"],
        "croisementWrite" => ["reproGestion"],
        "croisementDelete" => ["reproGestion"],
        "croisementList" => ["reproConsult"],
        "lotList" => ["reproConsult"],
        "lotDisplay" => ["reproConsult"],
        "lotChange" => ["reproGestion"],
        "lotWrite" => ["reproGestion"],
        "lotDelete" => ["reproGestion"],
        "lotMesureChange" => ["reproGestion"],
        "lotMesureWrite" => ["reproGestion"],
        "lotMesureDelete" => ["reproGestion"],
        "injectionChange" => ["reproGestion"],
        "injectionWrite" => ["reproGestion"],
        "injectionDelete" => ["reproGestion"],
        "saliniteChange" => ["reproGestion"],
        "saliniteNew" => ["reproGestion"],
        "saliniteWrite" => ["reproGestion"],
        "saliniteDelete" => ["reproGestion"],
        "spermeDisplay" => ["reproConsult"],
        "spermeChange" => ["reproGestion"],
        "spermeWrite" => ["reproGestion"],
        "spermeDelete" => ["reproGestion"],
        "spermeUtiliseChange" => ["reproGestion"],
        "spermeUtiliseWrite" => ["reproGestion"],
        "spermeUtiliseDelete" => ["reproGestion"],
        "spermeMesureChange" => ["reproGestion"],
        "spermeMesureWrite" => ["reproGestion"],
        "spermeMesureDelete" => ["reproGestion"],
        "spermeCongelationChange" => ["reproGestion"],
        "spermeCongelationWrite" => ["reproGestion"],
        "spermeCongelationDelete" => ["reproGestion"],
        "spermeCongelationList" => ["reproConsult"],
        "spermeCongelationVisotubes" => ["reproGestion"],
        "spermeFreezingPlaceChange" => ["reproGestion"],
        "spermeFreezingPlaceWrite" => ["reproGestion"],
        "spermeFreezingPlaceDelete" => ["reproGestion"],
        "spermeFreezingMeasureChange" => ["reproGestion"],
        "spermeFreezingMeasureWrite" => ["reproGestion"],
        "spermeFreezingMeasureDelete" => ["reproGestion"],
        "vieModeleList" => ["reproConsult"],
        "vieModeleChange" => ["reproGestion"],
        "vieModeleWrite" => ["reproGestion"],
        "vieModeleDelete" => ["reproGestion"],
        "bassinLotChange" => ["reproGestion"],
        "bassinLotWrite" => ["reproGestion"],
        "bassinLotDelete" => ["reproGestion"],
        "lotalimGenerate" => ["reproGestion", "bassinGestion"],
        "devenirList" => ["reproConsult"],
        "devenirChange" => ["reproGestion"],
        "devenirWrite" => ["reproGestion"],
        "devenirDelete" => ["reproGestion"],
        "devenirlotChange" => ["reproGestion"],
        "devenirlotWrite" => ["reproGestion"],
        "devenirlotDelete" => ["reproGestion"],
        "ventilationChange" => ["reproGestion", "poissonGestion"],
        "ventilationWrite" => ["reproGestion", "poissonGestion"],
        "ventilationDelete" => ["reproGestion", "poissonGestion"],
        "ventilationCampagneWrite" => ["reproGestion", "poissonGestion"],
        "ventilationCampagneDelete" => ["reproGestion", "poissonGestion"],
        "requestList" => ["requete"],
        "requestChange" => ["requeteAdmin"],
        "requestWrite" => ["requeteAdmin"],
        "requestDelete" => ["requeteAdmin"],
        "requestExec" => ["requete"],
        "requestExecList" => ["requete"],
        "requestWriteExec" => ["requeteAdmin"],
        "requestCopy" => ["requeteAdmin"],
        "siteList" => ["consult"],
        "siteChange" => ["paramAdmin"],
        "siteWrite" => ["paramAdmin"],
        "siteDelete" => ["paramAdmin"],
        "dbstructureSchema" => ["requeteAdmin"],
        "parametres" => ["consult"],
        "reproduction" => ["reproConsult"]
    ];
}
