<?php

namespace App\Libraries;

use app\Models\BassinType;
use app\Models\Bassin_usage;
use App\Models\Bassin_zone;
use App\Models\CircuitEau;
use App\Models\DocumentSturio;

function bassinParamAssocie($vue)
{
    $bassin_type = new BassinType;
    $vue->set($bassin_type->getListe(2), "bassin_type");
    $bassin_usage = new Bassin_usage;
    $vue->set($bassin_usage->getListe(2), "bassin_usage");
    $bassin_zone = new Bassin_zone;
    $vue->set($bassin_zone->getListe(2), "bassin_zone");
    $circuit_eau = new CircuitEau;
    $vue->set($circuit_eau->getListe(2), "circuit_eau");
}

function getListeDocument($type, array|int $id, $vue, $limit = "", $offset = 0)
{
    $document = new DocumentSturio;
    if (!$limit == "all" && !$limit > 0) {
        $limit = 10;
    }
    if (!$offset || !is_numeric($offset) || $offset < 1) {
        $offset = 0;
    }

    /*
	 * Envoi au navigateur des valeurs de limit et offset
	 */
    $vue->set($limit, "document_limit");
    $vue->set($offset, "document_offset");
    return $document->getListeDocument($type, $id, $limit, $offset);
}
