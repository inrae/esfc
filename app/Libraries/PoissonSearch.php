<?php

namespace App\Libraries;

use App\Models\Bassin;
use App\Models\Categorie;
use App\Models\PoissonStatut;
use App\Models\SearchPoisson;
use App\Models\Sexe;
use App\Models\Site;
use Ppci\Libraries\PpciLibrary;

class PoissonSearch extends PpciLibrary
{

    /**
     * Gestion des variables de recherche
     */
    function getSearchParam($vue)
    {
        if (!isset($_SESSION["searchPoisson"])) {
            $_SESSION["searchPoisson"] = new SearchPoisson();
        }
        $vue->set($_SESSION["searchPoisson"]->getSearchByEvent(), "eventSearchs");
        $_SESSION["searchPoisson"]->setParam($_REQUEST);
        $dataSearch = $_SESSION["searchPoisson"]->getParam();
        if ($_SESSION["searchPoisson"]->isSearch() == 1) {
            $vue->set(1, "isSearch");
        }
        $vue->set($dataSearch, "poissonSearch");
        /**
         * Integration des tables necessaires pour la  recherche
         */
        $sexe = new Sexe;
        $vue->set($sexe->getListe(1), "sexe");
        $poisson_statut = new PoissonStatut;
        $vue->set($poisson_statut->getListe(1), "statut");
        $categorie = new Categorie;
        $vue->set($categorie->getListe(1), "categorie");
        $site = new Site;
        $vue->set($site->getListe(2), "site");
        $bassin = new Bassin;
        $dataSearch["site_id"] > 0 ? $site_id = $dataSearch["site_id"] : $site_id = 0;
        $vue->set($bassin->getListBassin($site_id), "bassins");
        $vue->set($this->dataclass->getListCohortes(), "cohortes");
        return $dataSearch;
    }
}
