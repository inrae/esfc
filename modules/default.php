<?php

/**
 * Generate the graph of mortality
 */

if ($_SESSION["droits"]["gestion"] == 1) {
    require_once "modules/classes/mortalite.class.php";
    $mortalite = new Mortalite($bdd, $ObjetBDDParam);
    $type = $_COOKIE["mortalityType"];
    if (empty($type)) {
        $type = 1;
    }
    $nbyears = $_COOKIE["nbyears"];
    if (empty($nbyears) || !is_numeric($nbyears) || $nbyears < 1) {
        $nbyears = 1;
    }
    if ($nbyears == 1) {
        $years = "1 year";
    } else {
        $years = $nbyears ." years";
    }
    $data = $mortalite->getCumulativeMortality($type, date('Y-m-d'), $years);
    $di = array();
    $max = 0;
    foreach ($data as $row) {
        $di[$row["typology"]][] = array(
            "date" => $row["mortalite_date"],
            "nombre" => $row["nombre_cumule"]
        );
        if ($row["nombre_cumule"] > $max) {
            $max = $row["nombre_cumule"];
        }
    }
    if ($_SESSION["FORMATDATE"] == "fr" || $_SESSION["FORMATDATE"] == "en") {
        $dateFormat = "%d/%m/%Y";
    } else  if ($_SESSION["FORMATDATE"] == "us"){
        $dateFormat = "%m/%d/%Y";
    }
    $dc = array("xFormat" => $dateFormat);
    $i = 1;
    foreach ($di as $k => $v) {
        if (empty($k)) {
            $k = _("Inconnu");
        }
        $dc["xs"][$k] = "x" . $i;
        $vdate = array("x" . $i);
        $vval = array($k );
        foreach ($v as $line) {
            $vdate[] = $line["date"];
            $vval[] = $line["nombre"];
        }
        $dc["columns"] [] = $vdate;
        $dc["columns"] [] = $vval;
        $i ++;
    }
    $vue->set(json_encode($dc), "data");
    $vue->htmlVars[] = "data";
    $vue->set($dateFormat, "dateFormat");
    $vue->set($max, "max");
    $vue->set ($type, "type");
    $vue->set (1, "displayMortality");
    $vue->set($nbyears, "nbyears");
} else {
    $vue->set (0, "displayMortality");
}