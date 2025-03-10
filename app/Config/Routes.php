<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->add('/','Defaultpage::display');
$routes->add('dbstructureHtml', '\Ppci\Controllers\Structure::html');
$routes->add('dbstructureGacl', '\Ppci\Controllers\Structure::gacl');
$routes->add('pittagTypeList', 'PittagType::list');
$routes->add('pittagTypeChange', 'PittagType::change');
$routes->post('pittagTypeWrite', 'PittagType::write');
$routes->post('pittagTypeDelete', 'PittagType::delete');
$routes->add('poissonStatutList', 'PoissonStatut::list');
$routes->add('poissonStatutChange', 'PoissonStatut::change');
$routes->post('poissonStatutWrite', 'PoissonStatut::write');
$routes->post('poissonStatutDelete', 'PoissonStatut::delete');
$routes->add('genderMethodeList', 'GenderMethode::list');
$routes->add('genderMethodeChange', 'GenderMethode::change');
$routes->post('genderMethodeWrite', 'GenderMethode::write');
$routes->post('genderMethodeDelete', 'GenderMethode::delete');
$routes->add('evenementTypeList', 'EvenementType::list');
$routes->add('evenementTypeChange', 'EvenementType::change');
$routes->post('evenementTypeWrite', 'EvenementType::write');
$routes->post('evenementTypeDelete', 'EvenementType::delete');
$routes->add('pathologieTypeList', 'PathologieType::list');
$routes->add('pathologieTypeChange', 'PathologieType::change');
$routes->post('pathologieTypeWrite', 'PathologieType::write');
$routes->post('pathologieTypeDelete', 'PathologieType::delete');
$routes->add('morphologieImport', 'Morphologie::import');
$routes->add('morphologieImportMatching', 'Morphologie::matching');
$routes->add('morphologieImportControl', 'Morphologie::control');
$routes->add('morphologieImportExec', 'Morphologie::exec');
$routes->add('poissonList', 'Poisson::list');
$routes->add('poissonDisplay', 'Poisson::display');
$routes->add('poissonChange', 'Poisson::change');
$routes->post('poissonWrite', 'Poisson::write');
$routes->post('poissonDelete', 'Poisson::delete');
$routes->add('poissonSearchAjax', 'Poisson::getListeAjaxJson');
$routes->add('poissonGetFromTag', 'Poisson::getPoissonFromTag');
$routes->add('evenementChange', 'Evenement::change');
$routes->post('evenementWrite', 'Evenement::write');
$routes->post('evenementDelete', 'Evenement::delete');
$routes->add('evenementGetAllCSV', 'Evenement::getAllCSV');
$routes->add('pittagChange', 'Pittag::change');
$routes->post('pittagWrite', 'Pittag::write');
$routes->post('pittagDelete', 'Pittag::delete');
$routes->add('bassinTypeList', 'BassinType::list');
$routes->add('bassinTypeChange', 'BassinType::change');
$routes->post('bassinTypeWrite', 'BassinType::write');
$routes->post('bassinTypeDelete', 'BassinType::delete');
$routes->add('bassinUsageList', 'BassinUsage::list');
$routes->add('bassinUsageChange', 'BassinUsage::change');
$routes->post('bassinUsageWrite', 'BassinUsage::write');
$routes->post('bassinUsageDelete', 'BassinUsage::delete');
$routes->add('bassinZoneList', 'BassinZone::list');
$routes->add('bassinZoneChange', 'BassinZone::change');
$routes->post('bassinZoneWrite', 'BassinZone::write');
$routes->post('bassinZoneDelete', 'BassinZone::delete');
$routes->add('bassinList', 'Bassin::list');
$routes->add('bassinListniv2', 'Bassin::list');
$routes->add('bassinDisplay', 'Bassin::display');
$routes->add('bassinChange', 'Bassin::change');
$routes->post('bassinWrite', 'Bassin::write');
$routes->post('bassinDelete', 'Bassin::delete');
$routes->add('bassinCalculMasseAjax', 'Bassin::calculMasseAjax');
$routes->add('bassinRecapAlim', 'Bassin::recapAlim');
$routes->add('bassinPoissonTransfert', 'Bassin::bassinPoissonTransfert');
$routes->add('bassinEvenementChange', 'BassinEvenement::change');
$routes->post('bassinEvenementWrite', 'BassinEvenement::write');
$routes->post('bassinEvenementDelete', 'BassinEvenement::delete');
$routes->add('circuitEvenementChange', 'CircuitEvenement::change');
$routes->post('circuitEvenementWrite', 'CircuitEvenement::write');
$routes->post('circuitEvenementDelete', 'CircuitEvenement::delete');
$routes->add('circuitEauList', 'CircuitEau::list');
$routes->add('circuitEauDisplay', 'CircuitEau::display');
$routes->add('circuitEauChange', 'CircuitEau::change');
$routes->post('circuitEauWrite', 'CircuitEau::write');
$routes->post('circuitEauDelete', 'CircuitEau::delete');
$routes->add('analyseEauDisplay', 'AnalyseEau::display');
$routes->add('analyseEauChange', 'AnalyseEau::change');
$routes->post('analyseEauWriteList', 'AnalyseEau::write');
$routes->post('analyseEauDeleteList', 'AnalyseEau::delete');
$routes->post('analyseEauWrite', 'AnalyseEau::write');
$routes->post('analyseEauDelete', 'AnalyseEau::delete');
$routes->add('sondeImport', 'Sonde::import');
$routes->add('sondeExec', 'Sonde::importExec');
$routes->add('analyseGraph', 'AnalyseEau::graph');
$routes->add('mimeTypeList', 'MimeType::list');
$routes->add('mimeTypeChange', 'MimeType::change');
$routes->post('mimeTypeWrite', 'MimeType::write');
$routes->post('mimeTypeDelete', 'MimeType::delete');
$routes->add('mortaliteTypeList', 'MortaliteType::list');
$routes->add('mortaliteTypeChange', 'MortaliteType::change');
$routes->post('mortaliteTypeWrite', 'MortaliteType::write');
$routes->post('mortaliteTypeDelete', 'MortaliteType::delete');
$routes->add('cohorteTypeList', 'CohorteType::list');
$routes->add('cohorteTypeChange', 'CohorteType::change');
$routes->post('cohorteTypeWrite', 'CohorteType::write');
$routes->post('cohorteTypeDelete', 'CohorteType::delete');
$routes->add('anomalieList', 'Anomalie::list');
$routes->add('anomalieChange', 'Anomalie::change');
$routes->post('anomalieWrite', 'Anomalie::write');
$routes->post('anomalieDelete', 'Anomalie::delete');
$routes->post('poissonAnomalieWrite', 'Poisson::anomalieWrite');
$routes->post('poissonAnomalieDelete', 'Poisson::anomalieDelete');
$routes->add('parentPoissonChange', 'ParentPoisson::change');
$routes->post('parentPoissonWrite', 'ParentPoisson::write');
$routes->post('parentPoissonDelete', 'ParentPoisson::delete');
$routes->add('alimentTypeList', 'AlimentType::list');
$routes->add('alimentTypeChange', 'AlimentType::change');
$routes->post('alimentTypeWrite', 'AlimentType::write');
$routes->post('alimentTypeDelete', 'AlimentType::delete');
$routes->add('anomalieDbTypeList', 'AnomalieDbType::list');
$routes->add('anomalieDbTypeChange', 'AnomalieDbType::change');
$routes->post('anomalieDbTypeWrite', 'AnomalieDbType::write');
$routes->post('anomalieDbTypeDelete', 'AnomalieDbType::delete');
$routes->add('laboratoireAnalyseList', 'LaboratoireAnalyse::list');
$routes->add('laboratoireAnalyseChange', 'LaboratoireAnalyse::change');
$routes->post('laboratoireAnalyseWrite', 'LaboratoireAnalyse::write');
$routes->post('laboratoireAnalyseDelete', 'LaboratoireAnalyse::delete');
$routes->add('bassinEvenementTypeList', 'BassinEvenementType::list');
$routes->add('bassinEvenementTypeChange', 'BassinEvenementType::change');
$routes->post('bassinEvenementTypeWrite', 'BassinEvenementType::write');
$routes->post('bassinEvenementTypeDelete', 'BassinEvenementType::delete');
$routes->add('circuitEvenementTypeList', 'CircuitEvenementType::list');
$routes->add('circuitEvenementTypeChange', 'CircuitEvenementType::change');
$routes->post('circuitEvenementTypeWrite', 'CircuitEvenementType::write');
$routes->post('circuitEvenementTypeDelete', 'CircuitEvenementType::delete');
$routes->add('sortieLieuList', 'SortieLieu::list');
$routes->add('sortieLieuChange', 'SortieLieu::change');
$routes->post('sortieLieuWrite', 'SortieLieu::write');
$routes->post('sortieLieuDelete', 'SortieLieu::delete');
$routes->add('nageoireList', 'Nageoire::list');
$routes->add('nageoireChange', 'Nageoire::change');
$routes->post('nageoireWrite', 'Nageoire::write');
$routes->post('nageoireDelete', 'Nageoire::delete');
$routes->add('hormoneList', 'Hormone::list');
$routes->add('hormoneChange', 'Hormone::change');
$routes->post('hormoneWrite', 'Hormone::write');
$routes->post('hormoneDelete', 'Hormone::delete');
$routes->add('vieImplantationList', 'VieImplantation::list');
$routes->add('vieImplantationChange', 'VieImplantation::change');
$routes->post('vieImplantationWrite', 'VieImplantation::write');
$routes->post('vieImplantationDelete', 'VieImplantation::delete');
$routes->add('metalList', 'Metal::list');
$routes->add('metalChange', 'Metal::change');
$routes->post('metalWrite', 'Metal::write');
$routes->post('metalDelete', 'Metal::delete');
$routes->add('anesthesieProduitList', 'AnesthesieProduit::list');
$routes->add('anesthesieProduitChange', 'AnesthesieProduit::change');
$routes->post('anesthesieProduitWrite', 'AnesthesieProduit::write');
$routes->post('anesthesieProduitDelete', 'AnesthesieProduit::delete');
$routes->add('spermeDilueurList', 'SpermeDilueur::list');
$routes->add('spermeDilueurChange', 'SpermeDilueur::change');
$routes->post('spermeDilueurWrite', 'SpermeDilueur::write');
$routes->post('spermeDilueurDelete', 'SpermeDilueur::delete');
$routes->add('spermeCaracteristiqueList', 'SpermeCaracteristique::list');
$routes->add('spermeCaracteristiqueChange', 'SpermeCaracteristique::change');
$routes->post('spermeCaracteristiqueWrite', 'SpermeCaracteristique::write');
$routes->post('spermeCaracteristiqueDelete', 'SpermeCaracteristique::delete');
$routes->add('stadeOeufList', 'StadeOeuf::list');
$routes->add('stadeOeufChange', 'StadeOeuf::change');
$routes->post('stadeOeufWrite', 'StadeOeuf::write');
$routes->post('stadeOeufDelete', 'StadeOeuf::delete');
$routes->add('stadeGonadeList', 'StadeGonade::list');
$routes->add('stadeGonadeChange', 'StadeGonade::change');
$routes->post('stadeGonadeWrite', 'StadeGonade::write');
$routes->post('stadeGonadeDelete', 'StadeGonade::delete');
$routes->add('spermeConservateurList', 'SpermeConservateur::list');
$routes->add('spermeConservateurChange', 'SpermeConservateur::change');
$routes->post('spermeConservateurWrite', 'SpermeConservateur::write');
$routes->post('spermeConservateurDelete', 'SpermeConservateur::delete');
$routes->add('alimentList', 'Aliment::list');
$routes->add('alimentChange', 'Aliment::change');
$routes->post('alimentWrite', 'Aliment::write');
$routes->post('alimentDelete', 'Aliment::delete');
$routes->add('categorieList', 'Categorie::list');
$routes->add('categorieChange', 'Categorie::change');
$routes->post('categorieWrite', 'Categorie::write');
$routes->post('categorieDelete', 'Categorie::delete');
$routes->add('repartTemplateList', 'RepartTemplate::list');
$routes->add('repartTemplateChange', 'RepartTemplate::change');
$routes->post('repartTemplateWrite', 'RepartTemplate::write');
$routes->post('repartTemplateDelete', 'RepartTemplate::delete');
$routes->add('repartitionList', 'Repartition::list');
$routes->add('repartitionChange', 'Repartition::change');
$routes->add('repartitionCreate', 'Repartition::create');
$routes->add('repartitionDuplicate', 'Repartition::duplicate');
$routes->post('repartitionWrite', 'Repartition::write');
$routes->post('repartitionDelete', 'Repartition::delete');
$routes->add('repartitionPrint', 'Repartition::print');
$routes->add('repartitionResteChange', 'Repartition::resteChange');
$routes->add('repartitionResteWrite', 'Repartition::resteWrite');
$routes->add('documentChange', 'Document::change');
$routes->post('documentWrite', 'Document::write');
$routes->post('documentDelete', 'Document::delete');
$routes->add('documentGet', 'Document::get');
$routes->add('documentChangeData', 'Document::changeData');
$routes->add('documentWriteData', 'Document::writeData');
$routes->add('repro', 'PoissonCampagne::list');
$routes->add('poissonCampagneList', 'PoissonCampagne::list');
$routes->add('poissonCampagneDisplay', 'PoissonCampagne::display');
$routes->add('poissonCampagneChange', 'PoissonCampagne::change');
$routes->post('poissonCampagneWrite', 'PoissonCampagne::write');
$routes->post('poissonCampagneDelete', 'PoissonCampagne::delete');
$routes->add('poissonCampagneChangeStatut', 'PoissonCampagne::changeStatut');
$routes->add('poissonCampagneInit', 'PoissonCampagne::init');
$routes->add('poissonCampagneRecalcul', 'PoissonCampagne::recalcul');
$routes->add('sequenceList', 'Sequence::list');
$routes->add('sequenceDisplay', 'Sequence::display');
$routes->add('sequenceChange', 'Sequence::change');
$routes->post('sequenceWrite', 'Sequence::write');
$routes->post('sequenceDelete', 'Sequence::delete');
$routes->add('dosageSanguinChange', 'DosageSanguin::change');
$routes->post('dosageSanguinWrite', 'DosageSanguin::write');
$routes->post('dosageSanguinDelete', 'DosageSanguin::delete');
$routes->add('biopsieChange', 'Biopsie::change');
$routes->post('biopsieWrite', 'Biopsie::write');
$routes->post('biopsieDelete', 'Biopsie::delete');
$routes->add('poissonSequenceChange', 'PoissonSequence::change');
$routes->post('poissonSequenceWrite', 'PoissonSequence::write');
$routes->post('poissonSequenceDelete', 'PoissonSequence::delete');
$routes->add('psEvenementChange', 'PsEvenement::change');
$routes->post('psEvenementWrite', 'PsEvenement::write');
$routes->post('psEvenementDelete', 'PsEvenement::delete');
$routes->add('bassinCampagneDisplay', 'BassinCampagne::display');
$routes->post('bassinCampagneDelete', 'BassinCampagne::delete');
$routes->post('bassinCampagneWrite', 'BassinCampagne::write');
$routes->add('bassinCampagneInit', 'BassinCampagne::init');
$routes->add('echographieChange', 'Echographie::change');
$routes->post('echographieWrite', 'Echographie::write');
$routes->post('echographieDelete', 'Echographie::delete');
$routes->add('profilThermiqueChange', 'ProfilThermique::change');
$routes->add('profilThermiqueNew', 'ProfilThermique::new');
$routes->post('profilThermiqueWrite', 'ProfilThermique::write');
$routes->post('profilThermiqueDelete', 'ProfilThermique::delete');
$routes->add('croisementChange', 'Croisement::change');
$routes->add('croisementDisplay', 'Croisement::display');
$routes->post('croisementWrite', 'Croisement::write');
$routes->post('croisementDelete', 'Croisement::delete');
$routes->add('croisementList', 'Croisement::list');
$routes->add('lotList', 'Lot::list');
$routes->add('lotDisplay', 'Lot::display');
$routes->add('lotChange', 'Lot::change');
$routes->post('lotWrite', 'Lot::write');
$routes->post('lotDelete', 'Lot::delete');
$routes->add('lotMesureChange', 'LotMesure::change');
$routes->post('lotMesureWrite', 'LotMesure::write');
$routes->post('lotMesureDelete', 'LotMesure::delete');
$routes->add('injectionChange', 'Injection::change');
$routes->post('injectionWrite', 'Injection::write');
$routes->post('injectionDelete', 'Injection::delete');
$routes->add('saliniteChange', 'Salinite::change');
$routes->add('saliniteNew', 'Salinite::new');
$routes->post('saliniteWrite', 'Salinite::write');
$routes->post('saliniteDelete', 'Salinite::delete');
$routes->add('spermeDisplay', 'Sperme::display');
$routes->add('spermeChange', 'Sperme::change');
$routes->post('spermeWrite', 'Sperme::write');
$routes->post('spermeDelete', 'Sperme::delete');
$routes->add('spermeUtiliseChange', 'SpermeUtilise::change');
$routes->post('spermeUtiliseWrite', 'SpermeUtilise::write');
$routes->post('spermeUtiliseDelete', 'SpermeUtilise::delete');
$routes->add('spermeMesureChange', 'SpermeMesure::change');
$routes->post('spermeMesureWrite', 'SpermeMesure::write');
$routes->post('spermeMesureDelete', 'SpermeMesure::delete');
$routes->add('spermeCongelationChange', 'SpermeCongelation::change');
$routes->post('spermeCongelationWrite', 'SpermeCongelation::write');
$routes->post('spermeCongelationDelete', 'SpermeCongelation::delete');
$routes->add('spermeCongelationList', 'SpermeCongelation::list');
$routes->add('spermeCongelationVisotubes', 'SpermeCongelation::generateVisotube');
$routes->add('spermeFreezingPlaceChange', 'SpermeFreezingPlace::change');
$routes->post('spermeFreezingPlaceWrite', 'SpermeFreezingPlace::write');
$routes->post('spermeFreezingPlaceDelete', 'SpermeFreezingPlace::delete');
$routes->add('spermeFreezingMeasureChange', 'SpermeFreezingMeasure::change');
$routes->post('spermeFreezingMeasureWrite', 'SpermeFreezingMeasure::write');
$routes->post('spermeFreezingMeasureDelete', 'SpermeFreezingMeasure::delete');
$routes->add('vieModeleList', 'VieModele::list');
$routes->add('vieModeleChange', 'VieModele::change');
$routes->post('vieModeleWrite', 'VieModele::write');
$routes->post('vieModeleDelete', 'VieModele::delete');
$routes->add('bassinLotChange', 'BassinLot::change');
$routes->post('bassinLotWrite', 'BassinLot::write');
$routes->post('bassinLotDelete', 'BassinLot::delete');
$routes->add('lotalimGenerate', 'LotAlim::index');
$routes->add('devenirList', 'Devenir::list');
$routes->add('devenirChange', 'Devenir::change');
$routes->post('devenirWrite', 'Devenir::write');
$routes->post('devenirDelete', 'Devenir::delete');
$routes->add('devenirlotChange', 'Devenir::change');
$routes->post('devenirlotWrite', 'Devenir::write');
$routes->post('devenirlotDelete', 'Devenir::delete');
$routes->add('ventilationChange', 'Ventilation::change');
$routes->post('ventilationWrite', 'Ventilation::write');
$routes->post('ventilationDelete', 'Ventilation::delete');
$routes->post('ventilationCampagneWrite', 'Ventilation::write');
$routes->post('ventilationCampagneDelete', 'Ventilation::delete');
$routes->add('requestList', '\Ppci\Controllers\Request::list');
$routes->add('requestChange', '\Ppci\Controllers\Request::change');
$routes->post('requestWrite', '\Ppci\Controllers\Request::write');
$routes->post('requestDelete', '\Ppci\Controllers\Request::delete');
$routes->add('requestExec', '\Ppci\Controllers\Request::exec');
$routes->add('requestExecList', '\Ppci\Controllers\Request::execList');
$routes->post('requestWriteExec', '\Ppci\Controllers\Request::write');
$routes->add('requestCopy', '\Ppci\Controllers\Request::copy');
$routes->add('siteList', 'Site::list');
$routes->add('siteChange', 'Site::change');
$routes->post('siteWrite', 'Site::write');
$routes->post('siteDelete', 'Site::delete');
$routes->add('dbstructureSchema', '\Ppci\Controllers\Structure::schema');
$routes->add('parametres', '\Ppci\Controllers\Submenu::parametres');
$routes->add('paramPoisson', '\Ppci\Controllers\Submenu::index');
$routes->add('sites', '\Ppci\Controllers\Submenu::index');
$routes->add('reproduction', '\Ppci\Controllers\Submenu::index');
$routes->add('alimentation', '\Ppci\Controllers\Submenu::index');
